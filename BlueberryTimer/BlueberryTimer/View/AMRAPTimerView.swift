//
//  AMRAPTimerView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/27/25.
//

import SwiftUI

struct AMRAPTimerView: View {
    @StateObject var viewModel: TimerViewModel

    var body: some View {
        TimerView(viewModel: viewModel)
            .tabItem {
                Label("For Time", systemImage: "stopwatch")
            }
    }
}

#Preview {
    AMRAPTimerView(viewModel: TimerViewModel(timerModel: forTimeTimer))
}
