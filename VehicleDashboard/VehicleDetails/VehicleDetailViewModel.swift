//
//  VehicleDetailViewModel.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import Foundation
import Combine

@MainActor
final class VehicleDetailViewModel: ObservableObject {
    @Published private(set) var vehicle: Vehicle
    @Published private(set) var isRefreshing = false

    private let webService: WebServiceManager

    init(vehicle: Vehicle, webService: WebServiceManager = .shared) {
        self.vehicle = vehicle
        self.webService = webService
    }

    func refresh() {
        guard !isRefreshing else { return }

        isRefreshing = true
        webService.serviceManager(
            urlStr: "https://mock.simpleenergy.app/vehicles",
            parameter: [:],
            type: [Vehicle].self
        ) { [weak self] result in
            guard let self else { return }

            if let updatedVehicle = (try? result.get())?.first(where: { $0.id == self.vehicle.id }) {
                self.vehicle = updatedVehicle
            }
            self.isRefreshing = false
        }
    }
}
