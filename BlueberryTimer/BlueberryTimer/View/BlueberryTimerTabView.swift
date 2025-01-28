//
//  AmrapView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/27/25.
//

import SwiftUI

struct BlueberryTimerTabView: View {
    var body: some View {
        TabView {

            // AMRAP Timer Tab
            TimerView(viewModel: TimerViewModel(timerModel: TimerModel(
                id: UUID(),
                title: "AMRAP Workout",
                duration: 1200, // 20 minutes
                detail: .amrap(rounds: 5)
            )))
            //TODO: Style the button to change the color when selected to green
            .tabItem {
                VStack {
                    Image(systemName: "stopwatch")
                        .foregroundColor(Color.buttonPlayInnerBg)
                        Text("AMRAP")
                        .foregroundStyle(.white)
                }
            }

            // EMOM Timer Tab
            TimerView(viewModel: TimerViewModel(timerModel: TimerModel(
                id: UUID(),
                title: "EMOM Workout",
                duration: 600, // 10 minutes
                detail: .emom(interval: 60)
            )))
            .tabItem {
                Label("EMOM", systemImage: "timer")
            }

            // For Time Timer Tab
            TimerView(viewModel: TimerViewModel(timerModel: TimerModel(
                id: UUID(),
                title: "For Time Workout",
                duration: 900, // 15 minutes
                detail: .forTime(targetTime: 900)
            )))
            .tabItem {
                Label("For Time", systemImage: "hourglass")
            }
        }
    }
}

#Preview {
    BlueberryTimerTabView()
}
