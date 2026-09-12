//
//  VehicleDashboardApp.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import SwiftUI

@main
struct VehicleDashboardApp: App {
    @StateObject private var viewModel = VehicleListViewModel()

    var body: some Scene {
        WindowGroup {
            VehicleListView(viewModel: viewModel)
        }
    }
}
