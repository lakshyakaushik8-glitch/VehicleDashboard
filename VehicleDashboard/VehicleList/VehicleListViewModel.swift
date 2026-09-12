//
//  VehicleListViewModel.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import Foundation
import Combine

@MainActor
final class VehicleListViewModel: ObservableObject {
    @Published private(set) var vehicles: [Vehicle] = []
    @Published private(set) var isLoading = false

    let webService: WebServiceManager

    init(webService: WebServiceManager = .shared) {
        self.webService = webService
    }

    func loadIfNeeded() {
        guard vehicles.isEmpty else { return }
        refresh()
    }

    func refresh() {
        guard !isLoading else { return }

        isLoading = true
        webService.serviceManager(
            urlStr: "https://mock.simpleenergy.app/vehicles",
            parameter: [:],
            type: [Vehicle].self
        ) { [weak self] result in
            self?.vehicles = (try? result.get()) ?? []
            self?.isLoading = false
        }
    }

}
