//
//  Vehicle.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import Foundation

struct Vehicle: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let model: String
    let battery: Int
    let range: Int
    let speed: Int
    let odometer: Int
    let status: VehicleStatus
    let lastUpdated: Date

    var batteryFraction: Double {
        Double(min(max(battery, 0), 100)) / 100
    }

    var formattedOdometer: String {
        odometer.formatted(.number.grouping(.automatic)) + " km"
    }

    var formattedLastUpdated: String {
        lastUpdated.formatted(
            .dateTime
                .day(.twoDigits)
                .month(.abbreviated)
                .year()
                .hour(.defaultDigits(amPM: .abbreviated))
                .minute()
        )
    }
}

enum VehicleStatus: String, Codable, Equatable {
    case online = "ONLINE"
    case offline = "OFFLINE"

    var displayName: String {
        switch self {
        case .online: "Online"
        case .offline: "Offline"
        }
    }

    var symbolName: String {
        switch self {
        case .online: "checkmark.circle.fill"
        case .offline: "xmark.circle.fill"
        }
    }
}
