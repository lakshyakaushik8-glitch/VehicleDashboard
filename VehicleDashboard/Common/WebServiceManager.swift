//
//  WebServiceManager.swift
//  VehicleDashboard
//

import Foundation

final class WebServiceManager {
    static let shared = WebServiceManager()

    private init() {}

    func serviceManager<T: Codable>(
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let dataURL = Bundle.main.url(forResource: "vehicles", withExtension: "json") else {
                DispatchQueue.main.async {
                    completion(.failure(URLError(.fileDoesNotExist)))
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
                let data = try Data(contentsOf: dataURL)
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
