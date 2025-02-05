import Foundation
import Combine

// MARK: - TimerViewModel
class TimerViewModel: ObservableObject {
    @Published var remainingTime: Int = 0 // Used for AMRAP & EMOM
    @Published var elapsedTime: Int = 0 // Used for For Time
    @Published var isRunning: Bool = false
    @Published var isPaused: Bool = false
    @Published var currentRound: Int = 1
    @Published var statusMessage: String = "Set a Time"
    @Published var timerType: TimerDetails?

    // Enable Start button only when time is set for AMRAP & For Time
    var canStart: Bool {
        if let timerType = timerType {
            switch timerType {
            case .amrap: return remainingTime > 0
            case .forTime: return remainingTime > 0
            case .emom: return true // EMOM only requires rounds & interval
            }
        }
        return false
    }

    // MARK: - Private Properties
    private var timer: Timer?
    private var totalTime: Int = 0 // Original time set by user
    private var totalRounds: Int? // For EMOM
    private var interval: Int? // For EMOM
    private var timeCap: Int? // For For Time

    // MARK: - Timer Setup
    func setTimer(type: TimerDetails) {
        self.timerType = type

        switch type {
        case .amrap(let duration):
            self.remainingTime = duration
            self.totalTime = duration
            self.statusMessage = "Ready for AMRAP"

            case .emom(let rounds, let interval):
            self.totalRounds = rounds
            self.interval = interval
            self.remainingTime = interval // Start with one round interval
            self.statusMessage = "Ready for EMOM"

        case .forTime(let cap):
            self.timeCap = cap
            self.elapsedTime = 0
            self.remainingTime = cap
            self.statusMessage = "Ready for For Time"
        }
    }

    // MARK: - Timer Controls

    func start() {
        guard !isRunning else { return }
        isRunning = true
        isPaused = false
        statusMessage = "Timer Running"
        createTimer()
    }

    func pause() {
        guard isRunning else { return }
        timer?.invalidate()
        isRunning = false
        isPaused = true
        statusMessage = "Timer Paused"
    }

    func stop() {
        timer?.invalidate()
        isRunning = false
        isPaused = false
        remainingTime = 0
        elapsedTime = 0
        currentRound = 1
        statusMessage = "Workout Stopped"
    }

    func restart() {
        stop()
        if let timerType = timerType {
            setTimer(type: timerType)
        }
    }

    // MARK: - Timer Logic

    private func createTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }

    private func updateTimer() {
        guard let timerType = timerType else { return }

        switch timerType {
        case .amrap:
            handleAMRAPLogic()
        case .emom:
            handleEMOMLogic()
        case .forTime:
            handleForTimeLogic()
        }
    }

    // MARK: - AMRAP Logic (Counts Down)
    private func handleAMRAPLogic() {
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            stop()
            statusMessage = "AMRAP Complete!"
        }
    }

    // MARK: - EMOM Logic (Rounds + Intervals)
    private func handleEMOMLogic() {
        guard let interval = interval, let totalRounds = totalRounds else { return }

        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            if currentRound < totalRounds {
                currentRound += 1
                statusMessage = "Starting Round \(currentRound)"
                remainingTime = interval // Restart interval countdown
            } else {
                stop()
                statusMessage = "EMOM Complete!"
            }
        }
    }

    // MARK: - For Time Logic (Counts Up)
    private func handleForTimeLogic() {
        guard let timeCap = timeCap else { return }

        if elapsedTime < timeCap {
            elapsedTime += 1
        } else {
            stop()
            statusMessage = "For Time Complete!"
        }
    }
}
