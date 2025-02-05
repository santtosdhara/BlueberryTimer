//
//  AmrapView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/27/25.
//

import SwiftUI

struct BlueberryTimerTabView: View {
    @StateObject private var viewModel = TimerViewModel()
    private let timers: [TimerModel] = [
        amrapTimer,
        emomTimer,
        forTimeTimer
    ]

    @State private var selectedTab = 0

    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.buttonPlayInnerBg)
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(Array(timers.enumerated()), id: \.element.id) { index, timer in
                TimerView(viewModel: viewModel) // Use the same ViewModel
                    .tabItem {
                        Label(timer.title, systemImage: timerIcon(for: timer.detail))
                    }
                    .tag(index)
            }
        }
    }

    private func timerIcon(for detail: TimerDetails) -> String {
        switch detail {
            case .amrap:
                return "stopwatch"
            case .emom:
                return "timer"
            case .forTime:
                return "hourglass"
        }
    }
}

#Preview {
    BlueberryTimerTabView()
}
