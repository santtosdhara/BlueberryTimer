//
//  TimerViewModel.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/23/25.
//

import Foundation
import Combine

// MARK: - Published Properties for UI Binding

class TimerViewModel: ObservableObject {
    @Published var remainingTime: Int
    @Published var isRunning: Bool = false
    @Published var isPaused: Bool = false
    @Published var currentRound: Int = 1
    @Published var statusMessage: String = "Timer Ready"
    @Published var timerType: TimerDetails

    // MARK: - Private properties
    private var timer: Timer?
    private var duration: Int
    private var interval: Int?
    private var rounds: Int?


    private var elapsedTime: Int = 0

    init(timerModel: TimerModel) {
        self.duration = timerModel.duration
        self.remainingTime = timerModel.duration
        self.timerType = timerModel.detail

        switch timerModel.detail {
            case .amrap(let rounds):
                self.rounds = rounds
            case .emom(let interval):
                self.interval = interval
            case .forTime:
                break
        }
    }

    // MARK: - Timer Controls

    func start() {
        guard !isRunning else { return }
        isRunning = true
        statusMessage = "Timer Running"

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                self.stop()
            }
        }
    }

    func pause() {
        timer?.invalidate()
        isRunning = false
        statusMessage = "Timer Paused"
    }

    func resume() {
        guard !isRunning else { return }
        isRunning = true
        statusMessage = "Timer Running"

        timer = Timer(timeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.updateTimer()
        }
    }

    func stop() {
        timer?.invalidate()
        isRunning = false
        statusMessage = "Timer Stopped"
        remainingTime = 0
    }


    // MARK: - Timer Logic

    private func updateTimer() {
        guard remainingTime > 0 else {
            timer?.invalidate()
            isRunning = false
            statusMessage = "Timer Complete"
            handleTimerCompletion()
            return
        }

        remainingTime -= 1
        elapsedTime += 1

        switch timerType {
            case .amrap(let rounds):
                handleAMRAPLogic()
            case .emom(let interval):
                handleEMOMLogic()
            case .forTime(let targetTime):
                break // For time just counts down
        }
    }

    private func handleAMRAPLogic() {
        if let rounds = rounds, elapsedTime == (duration / rounds) * currentRound {
            currentRound += 1
            statusMessage = "Starting round \(currentRound)"
        }
    }

    private func handleEMOMLogic() {
        if let interval = interval, elapsedTime % interval == 0 {
            currentRound += 1
            statusMessage = "Starting Minute \(currentRound)"
        }
    }

    private func handleTimerCompletion() {
        switch timerType {
            case .amrap(let rounds):
                statusMessage = "AMRAP complete!"
            case .emom(let interval):
                statusMessage = "EMOM complete!"
            case .forTime(let targetTime):
                statusMessage = "Workout complete!"
        }
    }
}
