//
//  WebServiceManager.swift
//  VehicleDashboard
//

import Foundation

final class WebServiceManager {
    static let shared = WebServiceManager()

    private init() {
        URLProtocol.registerClass(LocalMockURLProtocol.self)
    }

    func serviceManager<T: Codable>(
        urlStr: String,
        parameter: [String: Any],
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let header = ["Content-Type": "application/json"]

        guard let strURL = URL(string: urlStr) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let jsonObj = try? JSONSerialization.data(withJSONObject: parameter, options: [])
        var jsonRequest = URLRequest(
            url: strURL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        jsonRequest.httpBody = jsonObj
        jsonRequest.allHTTPHeaderFields = header
        jsonRequest.httpMethod = "POST"

        URLSession.shared.dataTask(with: jsonRequest) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  (200...299).contains(statusCode),
                  let data else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.badServerResponse)))
                }
                return
            }

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let value = try container.decode(String.self)
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = .current
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

                guard let date = formatter.date(from: value) else {
                    throw DecodingError.dataCorruptedError(
                        in: container,
                        debugDescription: "Invalid date"
                    )
                }
                return date
            }

            do {
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
