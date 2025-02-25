import SwiftUI

struct BlueberryTimerTabView: View {
    @StateObject private var viewModel = TimerViewModel()
    @State private var selectedTabIndex = 0
    @State private var isSettingUpTimer = true


    @State private var inputMinutes: String = ""
    @State private var inputRounds: String = ""
    @State private var inputInterval: String = ""

    @State private var timers: [TimerModel] = []

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
                                TimerSetupView(viewModel: viewModel, selectedType: timer.type, inputMinutes: $inputMinutes, inputRounds: $inputRounds, inputInterval: $inputInterval
                                ) {
                                    configureTimer(at: index)
                                    isSettingUpTimer = false
                                }
                            } else {
                                TimerView(viewModel: viewModel, isSettingUpTimer: $isSettingUpTimer)
                            }
                        }
                        .tabItem {
                            Label(timer.title, systemImage: timerIcon(for: timer.type))
                        }
                        .tag(index)
                    }
                }
                .onAppear {
                    initializeTimer()
                }
            }
        }
    }

    private func initializeTimer() {
        timers = [
            createTimer(title: "AMRAP", type: .amrap(duration: 0)),
            createTimer(title: "EMOM", type: .emom(rounds: 0, interval: 0)),
            createTimer(title: "ForTime", type: .forTime(duration: 0))
        ]
    }

    private func configureTimer(at index: Int) {
        guard index < timers.count else { return }

        let timer = timers[index]

        switch timer.type {
                    case .amrap:
                        if let minutes = Int(inputMinutes), minutes > 0 {
                            timers[index] = createTimer(title: "AMRAP", type: .amrap(duration: minutes * 60))
                        }
                    case .emom:
                if let rounds = Int(inputRounds), let interval = Int(inputInterval), rounds > 0, interval > 0 {
                            timers[index] = createTimer(title: "EMOM", type: .emom(rounds: rounds, interval: interval))
                        }
                    case .forTime:
                if let minutes = Int(inputMinutes), minutes > 0 {
                            timers[index] = createTimer(title: "For Time", type: .forTime(duration: minutes * 60))
                        }
                }

                viewModel.configureTimer(timer: timers[index])

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
