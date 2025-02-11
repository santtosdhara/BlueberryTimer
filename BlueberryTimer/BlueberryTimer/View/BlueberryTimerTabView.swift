import SwiftUI

struct BlueberryTimerTabView: View {
    @StateObject private var viewModel = TimerViewModel()
    @State private var selectedTabIndex = 0
    @State private var isSettingUpTimer = true
    @State private var timerDuration: Int = 0

    private let timers: [TimerModel] = [
        amrapTimer,
        emomTimer,
        forTimeTimer
    ]

    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.buttonPlayInnerBg)
    }

    var body: some View {
        TabView(selection: $selectedTabIndex) {
            ForEach(timers.indices, id: \.self) { index in
                let timer = timers[index]

                Group {
                    if isSettingUpTimer {
                        TimerSetupView(selectedType: timer.detail) { selectedTimerType in
                            viewModel.setTimer(type: selectedTimerType)
                            isSettingUpTimer = false
                        }
                    } else {
                        TimerView(viewModel: viewModel, isSettingUpTimer: $isSettingUpTimer)
                    }
                }
                .tabItem {
                    Label(timer.title, systemImage: timerIcon(for: timer.detail))
                }
                .tag(index)
            }
        }
        .onChange(of: selectedTabIndex) { newTab in
            let selectedTimerDetails = timers[newTab].detail // Break into sub-expression
            viewModel.setTimer(type: selectedTimerDetails)
        }
    }

        //
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
