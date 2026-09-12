//
//  VehicleListView.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import SwiftUI

struct VehicleListView: View {
    @ObservedObject var viewModel: VehicleListViewModel
    @State private var showEmptyStateDemo = false
    @State private var selectedVehicle: Vehicle?
    @State private var isLoadingDetails = false
    @State private var showVehicleDetails = false

    var body: some View {
        NavigationStack {
            Group {
                if isLoadingDetails {
                    ProgressView("Loading vehicle details...")
                } else if showEmptyStateDemo {
                    StateMessageView(
                        title: "No Vehicles Available",
                        message: "There are no vehicles to display right now.",
                        symbolName: "car",
                        actionTitle: "Show Vehicles"
                    ) {
                        showEmptyStateDemo = false
                    }
                } else if viewModel.isLoading && viewModel.vehicles.isEmpty {
                    ProgressView("Loading vehicles...")
                } else if viewModel.vehicles.isEmpty {
                    StateMessageView(
                        title: "No Vehicles Available",
                        message: "There are no vehicles to display right now.",
                        symbolName: "car"
                    )
                } else {
                    vehicleList
                }
            }
            .navigationTitle("Vehicles")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button("Empty") {
                            showEmptyStateDemo = true
                        }
                        .disabled(isLoadingDetails)

                        Button {
                            viewModel.refresh()
                        } label: {
                            if viewModel.isLoading {
                                ProgressView()
                            } else {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                        .disabled(viewModel.isLoading || isLoadingDetails)
                    }
                }
            }
            .navigationDestination(isPresented: $showVehicleDetails) {
                if let selectedVehicle {
                    VehicleDetailView(vehicle: selectedVehicle)
                }
            }
            .task {
                viewModel.loadIfNeeded()
            }
        }
    }

    private var vehicleList: some View {
        List {
            ForEach(viewModel.vehicles) { vehicle in
                Button {
                    openVehicleDetails(for: vehicle)
                } label: {
                    VehicleRowView(vehicle: vehicle)
                }
                .buttonStyle(.plain)
                .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                .listRowSeparator(.hidden)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.secondary.opacity(0.08))
                        .padding(.horizontal, 12)
                )
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.refresh()
        }
    }

    private func openVehicleDetails(for vehicle: Vehicle) {
        guard !isLoadingDetails else { return }

        isLoadingDetails = true

        Task {
            try? await Task.sleep(for: .seconds(1))
            selectedVehicle = vehicle
            isLoadingDetails = false
            showVehicleDetails = true
        }
    }
}
