//
//  ContentView.swift
//  Metronom
//
//  Created by Frederik Goplen on 13/06/2025.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var audioPlayer: AVAudioPlayer?
    @AppStorage("selectedSound") private var selectedSound: String = "click"
    @AppStorage("lastBPM") private var bpm: Int = 100

    let bpmRange = 40...208
    let soundFiles: [String: String] = [
        "click": "wav",
        "tunge": "m4a"
    ]

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 40) {
                    Text("\(bpm) SPM")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Picker("SPM", selection: $bpm) {
                        ForEach(bpmRange, id: \.self) { bpm in
                            Text("\(bpm)")
                                .foregroundColor(.white)
                                .tag(bpm)
                        }
                    }
                    .labelsHidden()
                    .frame(height: 150)
                    .clipped()
                    .pickerStyle(.wheel)
                    .onChange(of: bpm) {
                        if isRunning {
                            stopMetronome()
                            startMetronome()
                        }
                    }


                    Button(action: toggleMetronome) {
                        Text(isRunning ? "Stopp" : "Start")
                            .font(.title2)
                            .padding()
                            .frame(width: 140)
                            .background(Color(red: 0.2, green: 0.2, blue: 0.2)) // Koksgrå
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    NavigationLink("Innstillinger") {
                        SettingsView()
                    }
                    .foregroundColor(.white)
                    .padding(.top)
                }
            }
            .navigationTitle("Metronom")
            .navigationBarTitleDisplayMode(.inline)
        }
    }


    func toggleMetronome() {
        isRunning.toggle()
        isRunning ? startMetronome() : stopMetronome()
    }

    func startMetronome() {
        let interval = 60.0 / Double(bpm)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            playClickSound()
        }
    }

    func stopMetronome() {
        timer?.invalidate()
        timer = nil
    }

    func playClickSound() {
        guard let ext = soundFiles[selectedSound],
              let url = Bundle.main.url(forResource: selectedSound, withExtension: ext) else {
            print("Lyd ikke funnet: \(selectedSound)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Feil ved avspilling: \(error)")
        }
    }
}
