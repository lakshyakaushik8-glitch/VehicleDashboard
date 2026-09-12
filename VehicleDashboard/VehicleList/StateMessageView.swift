//
//  StateMessageView.swift
//  VehicleDashboard
//
//  Created by Lakshya Kaushik on 11/09/26.
//

import SwiftUI

struct StateMessageView: View {
    let title: String
    let message: String
    let symbolName: String
    var actionTitle: String?
    var action: (() -> Void)?

    var body: some View {
        VStack(spacing: 14) {
            Image(systemName: symbolName)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)

            Text(title)
                .font(.headline)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(maxWidth: 360)
        .accessibilityElement(children: .combine)
    }
}
