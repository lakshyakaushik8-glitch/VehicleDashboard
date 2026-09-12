//
//  VehicleRowView.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import SwiftUI

struct StatusBadgeView: View {
    let status: VehicleStatus

    private var tint: Color {
        status == .online ? .green : .secondary
    }

    var body: some View {
        Label(status.displayName, systemImage: status.symbolName)
            .font(.caption.weight(.semibold))
            .foregroundStyle(tint)
            .accessibilityLabel("Connectivity: \(status.displayName)")
    }
}

struct VehicleRowView: View {
    let vehicle: Vehicle

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(vehicle.name)
                        .font(.headline)
                    Text(vehicle.model)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 8)
                StatusBadgeView(status: vehicle.status)
            }

            BatteryProgressView(battery: vehicle.battery)

            HStack(spacing: 6) {
                Image(systemName: "location.fill")
                    .foregroundStyle(.secondary)
                    .accessibilityHidden(true)
                Text("Range: \(vehicle.range) km")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(
            "\(vehicle.name), \(vehicle.model), battery \(vehicle.battery) percent, range \(vehicle.range) kilometers, \(vehicle.status.displayName)"
        )
    }
}
