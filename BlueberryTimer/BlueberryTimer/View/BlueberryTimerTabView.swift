import SwiftUI

struct BlueberryTimerTabView: View {
    @StateObject private var viewModel = TimerViewModel()
    @State private var selectedTabIndex = 0
    @State private var isSettingUpTimer = true

    private let timers: [TimerModel] = [
        createTimer(title: "AMRAP", type: .amrap(duration: 0)),
        createTimer(title: "EMOM", type: .emom(rounds: 0, interval: 0)),
        createTimer(title: "For Time", type: .forTime(duration: 0)) 
    ]

    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.buttonPlayInnerBg)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()

                TabView(selection: $selectedTabIndex) {
                    ForEach(timers, id: \.id) { timer in
                        Group {
                            if isSettingUpTimer {
                                TimerSetupView(viewModel: viewModel, selectedType: timer.type) {
                                    viewModel.configureTimer(timer: timer)
                                    isSettingUpTimer = false
                                }
                            } else {
                                TimerView(viewModel: viewModel, isSettingUpTimer: $isSettingUpTimer)
                            }
                        }
                        .tabItem {
                            Label(timer.title, systemImage: timerIcon(for: timer.type))
                        }
                        .tag(timers.firstIndex(where: { $0.id == timer.id }) ?? 0)
                    }
                }
                .onChange(of: selectedTabIndex) { newTab in
                    print("🔄 Tab Changed: \(newTab), isSettingUpTimer: \(isSettingUpTimer)")

                    if newTab < timers.count {
                        let selectedTimer = timers[newTab]

                        if viewModel.activeTimer?.id != selectedTimer.id {
                            // ✅ Prevent For Time from being reset to 0
                            if case .forTime(let existingDuration) = viewModel.activeTimer?.type, existingDuration > 0 {
                                print("🚫 Skipping Reset - Keeping Existing For Time Duration: \(existingDuration)")
                                return
                            }

                            print("✅ Configuring Timer on Tab Change: \(selectedTimer.type)")
                            viewModel.configureTimer(timer: selectedTimer)
                        } else {
                            print("🚫 Skipping Timer Configuration - Timer Already Set")
                        }
                    } else {
                        print("🚫 Skipping Timer Configuration - Invalid Index")
                    }
                }
            }
        }
    }

    private func timerIcon(for type: TimerType) -> String {
        switch type {
            case .amrap: return "stopwatch"
            case .emom:  return "timer"
            case .forTime: return "hourglass"
        }
    }
}

#Preview {
    BlueberryTimerTabView()
}
