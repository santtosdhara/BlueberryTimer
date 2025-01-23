//
//  BlueberryTimerApp.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/23/25.
//

import SwiftUI

@main
struct BlueberryTimerApp: App {
    @StateObject private var viewModel = TimerViewModel(
        timerModel: TimerModel(
            id: UUID(),
            title: "AMRAP Workout",
            duration: 1200, // 20 minutes in seconds
            detail: .amrap(rounds: 5)
        )
    )

    var body: some Scene {
        WindowGroup {
            TimerView(viewModel: viewModel)
        }
    }
}
