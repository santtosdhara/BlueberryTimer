import Foundation
import Combine


// MARK: - TimerViewModel

class TimerViewModel: ObservableObject {
    @Published var activeTimer: TimerModel?
    @Published var remainingTime: Int = 0
    @Published var isRunning: Bool = false
    @Published var isPaused: Bool = false
    @Published var currentRound: Int = 1

    private var timer: Timer?
    private var startTime: Int = 0

    // MARK: - Timer Control Methods

    func configureTimer(timer: TimerModel) {
        if let activeTimer = activeTimer, activeTimer.id == timer.id {
            print("🚫 Timer already configured: \(activeTimer.type) ")
            return
        }
        print(" Configuring Timer: \(timer.type)")
        self.activeTimer = timer

        switch timer.type {
                case .amrap(let duration):
                    remainingTime = duration
                    startTime = duration

                case .forTime(let duration):
                    remainingTime = 0 // Always start from 0
                    startTime = 0

                case .emom(let rounds, let interval):
                    remainingTime = interval * 60
                    startTime = interval
                    currentRound = 1
                }

                isRunning = false
                isPaused = false
    }

    func startTimer() {
        guard let activeTimer = activeTimer else {
            print("🚫 No active timer found. Cannot start.")
            return
        }

        if isRunning {
            print("🚫 Timer already running.")
            return
        }

        print("▶️ Starting Timer: \(activeTimer.type)")
        isRunning = true
        isPaused = false

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    private func tick() {
        guard let activeTimer = activeTimer, isRunning else { return }

        switch activeTimer.type {
            case .amrap:
                if remainingTime > 0 {
                    remainingTime -= 1
                } else {
                    stopTimer()
                }
            case .forTime(let duration):
                if remainingTime < duration {
                    remainingTime += 1
                } else {
                    stopTimer()
                }
            case .emom(let rounds, let interval):
                let interval = interval * 60

                if remainingTime > 0 {
                    remainingTime -= 1
                } else if currentRound < rounds {
                    currentRound += 1
                    remainingTime = interval
                } else {
                    stopTimer()
                }
        }
    }

    func pauseTimer() {
        guard isRunning else { return }

        print("⏸ Pausing Timer")
        isRunning = false
        isPaused = true
        timer?.invalidate()
        timer = nil
    }

    func stopTimer() {
        print("⏹ Stopping Timer")
        isRunning = false
        isPaused = false
        timer?.invalidate()
        timer = nil
        remainingTime = startTime
    }

    func resetTimer() {
        print("🔄 Resetting Timer")
        stopTimer()

        guard let activeTimer = activeTimer else { return }

        switch activeTimer.type {
            case .amrap(let duration):
                remainingTime = duration
            case .forTime:
                remainingTime = 0
            case .emom(let rounds, let interval):
                remainingTime = interval * 60
                currentRound = 1
        }
    }
}
