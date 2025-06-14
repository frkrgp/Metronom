//
//  MetronomApp.swift
//  Metronom
//
//  Created by Frederik Goplen on 13/06/2025.
//

import SwiftUI
import AVFoundation

@main
struct MetronomApp: App {
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Kunne ikke aktivere AVAudioSession: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
