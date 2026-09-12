//
//  BatteryProgressView.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import SwiftUI

struct BatteryProgressView: View {
    let battery: Int

    private var normalizedBattery: Double {
        Double(min(max(battery, 0), 100))
    }

    private var tint: Color {
        switch battery {
        case ..<20: .red
        case ..<50: .yellow
        default: .green
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack {
                Label("Battery", systemImage: "battery.75percent")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(battery)%")
                    .font(.subheadline.weight(.semibold))
                    .monospacedDigit()
            }

            ProgressView(value: normalizedBattery, total: 100)
                .tint(tint)
        }
    }
}
