//
//  TimerSettingsSheet.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 2/4/25.
//

import SwiftUI

struct TimerSettingsSheet: View {
    @ObservedObject var viewModel: TimerViewModel
    @Binding var showingSheet: Bool

    @State private var selectedType: TimerDetails = .amrap(duration: 300)
    @State private var duration: Int = 300 // Default 5 min for AMRAP
    @State private var rounds: Int = 2
    @State private var interval: Int = 60
    @State private var timeCap: Int = 600 // Default 10 min for For Time

    var body: some View {
        NavigationView {
            Form {
                // Timer Type Picker
                Picker("Timer Type", selection: $selectedType) {
                    Text("AMRAP").tag(TimerDetails.amrap(duration: duration))
                    Text("EMOM").tag(TimerDetails.emom(rounds: rounds, interval: interval))
                    Text("For Time").tag(TimerDetails.forTime(cap: timeCap))
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Dynamic Input Fields
                switch selectedType {
                case .amrap:
                    Section(header: Text("AMRAP Duration")) {
                        Stepper("\(duration / 60) min", value: $duration, in: 60...1800, step: 60)
                    }

                case .emom:
                    Section(header: Text("EMOM Settings")) {
                        Stepper("Rounds: \(rounds)", value: $rounds, in: 1...10)
                        Stepper("Interval: \(interval) sec", value: $interval, in: 10...120, step: 5)
                    }

                case .forTime:
                    Section(header: Text("For Time Cap")) {
                        Stepper("\(timeCap / 60) min", value: $timeCap, in: 60...1800, step: 60)
                    }
                }

                // Confirm Button
                Button("Confirm") {
                    saveSettings()
                    showingSheet = false
                }
//                .buttonStyle(ConfirmButtonStyle())
            }
            .navigationTitle("Set Timer")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        showingSheet = false
                    }
                }
            }
        }
    }

    private func saveSettings() {
        switch selectedType {
        case .amrap:
            viewModel.setTimer(type: .amrap(duration: duration))
        case .emom:
            viewModel.setTimer(type: .emom(rounds: rounds, interval: interval))
        case .forTime:
            viewModel.setTimer(type: .forTime(cap: timeCap))
        }
    }
}

//struct ConfirmButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        
//    }
//}
    #Preview {
        TimerSettingsSheet(viewModel: TimerViewModel(), showingSheet: .constant(true))
    }
