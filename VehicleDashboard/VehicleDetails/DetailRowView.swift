//
//  DetailRowView.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import SwiftUI

struct DetailRowView: View {
    let title: String
    let value: String
    let symbolName: String
    var valueTint: Color = .primary

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: symbolName)
                .font(.body)
                .foregroundStyle(.tint)
                .frame(width: 22)
                .accessibilityHidden(true)

            Text(title)
                .foregroundStyle(.secondary)

            Spacer(minLength: 12)

            Text(value)
                .foregroundStyle(valueTint)
                .multilineTextAlignment(.trailing)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value)")
    }
}
