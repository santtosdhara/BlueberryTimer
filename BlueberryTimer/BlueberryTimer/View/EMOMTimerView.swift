//
//  EMOMTimerView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/27/25.
//

import SwiftUI

struct EMOMTimerView: View {
    @StateObject var viewModel: TimerViewModel

    var body: some View {
        TimerView(viewModel: viewModel)
            .tabItem {
                Label("EMOM", systemImage: "timer")
            }
    }
}

#Preview {
    EMOMTimerView(viewModel: TimerViewModel(timerModel: amrapTimer))
}
