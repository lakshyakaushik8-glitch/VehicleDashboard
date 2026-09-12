//
//  VehicleDetailView.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import SwiftUI

struct VehicleDetailView: View {
    @StateObject private var viewModel: VehicleDetailViewModel

    init(vehicle: Vehicle) {
        _viewModel = StateObject(
            wrappedValue: VehicleDetailViewModel(vehicle: vehicle)
        )
    }

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.vehicle.name)
                        .font(.title2.weight(.bold))
                    Text(viewModel.vehicle.model)
                        .foregroundStyle(.secondary)
                    StatusBadgeView(status: viewModel.vehicle.status)
                }
                .padding(.vertical, 8)
                .accessibilityElement(children: .combine)
            }

            Section("Battery") {
                BatteryProgressView(battery: viewModel.vehicle.battery)
                    .padding(.vertical, 4)
            }

            Section("Vehicle Information") {
                DetailRowView(
                    title: "Estimated Range",
                    value: "\(viewModel.vehicle.range) km",
                    symbolName: "location.fill"
                )
                DetailRowView(
                    title: "Current Speed",
                    value: "\(viewModel.vehicle.speed) km/h",
                    symbolName: "speedometer"
                )
                DetailRowView(
                    title: "Odometer",
                    value: viewModel.vehicle.formattedOdometer,
                    symbolName: "gauge.with.dots.needle.50percent"
                )
                DetailRowView(
                    title: "Connectivity",
                    value: viewModel.vehicle.status.displayName,
                    symbolName: viewModel.vehicle.status.symbolName,
                    valueTint: viewModel.vehicle.status == .online ? .green : .secondary
                )
                DetailRowView(
                    title: "Last Updated",
                    value: viewModel.vehicle.formattedLastUpdated,
                    symbolName: "clock"
                )
            }

        }
        .navigationTitle("Vehicle Details")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            viewModel.refresh()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.refresh()
                } label: {
                    if viewModel.isRefreshing {
                        ProgressView()
                    } else {
                        Image(systemName: "arrow.clockwise")
                    }
                }
                .disabled(viewModel.isRefreshing)
                .accessibilityLabel("Refresh vehicle information")
            }
        }
    }
}
