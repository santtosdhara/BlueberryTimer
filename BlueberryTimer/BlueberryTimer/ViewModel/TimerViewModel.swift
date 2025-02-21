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
            // ✅ Prevents overwriting an existing For Time duration
            if case .forTime(let existingDuration) = activeTimer.type, existingDuration > 0 {
                print("🚫 Skipping Reconfiguration: For Time already set to \(existingDuration) seconds")
                return
            }

            print("🚫 Skipping Reconfiguration: Timer Already Set to \(activeTimer.type)")
            return
        }
        print("🕵️‍♂️ Debug - Timer Setup Creating Timer: \(timer.type)")
        Thread.callStackSymbols.forEach { print($0) }
        
        self.activeTimer = timer
        print("🛠 After Configuration - Active Timer: \(String(describing: self.activeTimer?.type))")

        switch timer.type {
            case .amrap(let duration):
                if remainingTime == 0 || remainingTime == startTime {
                    remainingTime = duration > 0 ? duration : remainingTime
                }
                startTime = remainingTime

            case .forTime(let duration):
                if let activeTimer = activeTimer, case .forTime(let existingDuration) = activeTimer.type {
                       if existingDuration > 0 {
                           print("🚫 Preventing Reset - Keeping Existing Duration: \(existingDuration)")
                           return // ✅ Prevents overwriting a valid duration
                       }
                   }

                   print("✅ Setting For Time - Duration: \(duration)")
                   remainingTime = 0 // Start from 0
                   startTime = duration
            case .emom(let interval, let rounds):
                if remainingTime == 0 || remainingTime == startTime {
                    remainingTime = interval > 0 ? interval : remainingTime
                }
                startTime = remainingTime
                currentRound = rounds > 0 ? 1 : currentRound
        }
    }

    func startTimer() {
        guard let activeTimer = activeTimer else {
            print("🚫 No active timer found. Cannot start.")
            return
        }

        if isRunning {
            print("🚫 Timer Already Running.")
            return
        }

        isRunning = true
        isPaused = false

        print("▶️ Timer Started: \(activeTimer.type)")

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
        isRunning = false
        isPaused = true
        timer?.invalidate()
    }

    func stopTimer() {
        isRunning = false
        isPaused = false
        timer?.invalidate()
    }

    func resetTimer() {
        stopTimer()
        if let activeTimer = activeTimer {
            print("🔄 Resetting Timer: \(activeTimer.type)")
            configureTimer(timer: activeTimer) // Reset to initial values
        }
    }
}
