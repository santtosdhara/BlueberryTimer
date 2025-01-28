//
//  ForTimeTimerView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/27/25.
//

import SwiftUI

struct ForTimeTimerView: View {
    @StateObject var viewModel: TimerViewModel

    var body: some View {
        TimerView(viewModel: viewModel)
            .tabItem {
                Label("For Time", systemImage: "timer")
            }
    }
}

#Preview {
    ForTimeTimerView(viewModel: TimerViewModel(timerModel: forTimeTimer))
}
