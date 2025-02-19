import SwiftUI

struct BlueberryTimerTabView: View {
    @StateObject private var viewModel = TimerViewModel()
    @State private var selectedTabIndex = 0
    @State private var isSettingUpTimer = true
    @State private var selectedTimerTitle: String = "Blueberry Timer"

    private let timers: [TimerModel] = [
        amrapTimer,
        emomTimer,
        forTimeTimer
    ]

    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.buttonPlayInnerBg)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

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
                    let selectedTimer = timers[newTab]
                    selectedTimerTitle = selectedTimer.title
                    viewModel.setTimer(type: selectedTimer.detail)
                }
            }
            .navigationTitle("") // Remove default title
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(selectedTimerTitle)
                        .font(.title)
                        .foregroundColor(.white)
                }
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
