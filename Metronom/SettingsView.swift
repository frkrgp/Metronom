//
//  SettingsView.swift
//  Metronom
//
//  Created by Frederik Goplen on 13/06/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedSound") var selectedSound: String = "click"

    let availableSounds = [
        ("click", "Standard klikk"),
        ("tunge", "Tunge klikk")
    ]

    var body: some View {
        Form {
            Section(header: Text("Klikkelyd")) {
                Picker("Lyd", selection: $selectedSound) {
                    ForEach(availableSounds, id: \.0) { key, label in
                        Text(label).tag(key)
                    }
                }
                .pickerStyle(.inline)
            }
        }
        .navigationTitle("Innstillinger")
    }
}
