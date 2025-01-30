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
    @Published var currentRound: Int = 1 // Check the need of this variable
    @Published var statusMessage: String = "Timer Ready" // Delete in the future
    @Published var timerType: TimerDetails

    // MARK: - Private properties
    private var timer: Timer?
    private var totalRounds: Int?
    private var interval: Int?
    private var totalWorkoutTime: Int

    init(timerModel: TimerModel) {
        self.timerType = timerModel.detail

        switch timerModel.detail {
               case .emom(let rounds, let interval):
                   self.totalRounds = rounds
                   self.interval = interval
                   self.totalWorkoutTime = rounds * interval // Total workout time
                   self.remainingTime = interval // Start with one round interval
               case .amrap(let duration), .forTime(let duration):
                   self.totalRounds = nil
                   self.interval = nil
                   self.totalWorkoutTime = duration
                   self.remainingTime = duration
               }
    }

    // MARK: - Timer Controls

    func start() {
        guard !isRunning else { return }
        isRunning = true
        statusMessage = "Timer Running"
        createTimer()
    }

    func pause() {
        timer?.invalidate()
        isRunning = false
        isPaused = true
        statusMessage = "Timer Paused"
    }

    func resume() {
        guard !isRunning else { return }
        isRunning = true
        isPaused = false
        statusMessage = "Timer Resumed"
        createTimer()
    }

    func stop() {
        timer?.invalidate()
        isRunning = false
        isPaused = false
        remainingTime = 0
        statusMessage = getCompletionMessage()
    }

    // MARK: - Timer Logic

    private func createTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                self?.updateTimer()
            }
        }

    private func updateTimer() {
        guard let interval = interval, let totalRounds = totalRounds else { return }

        if totalWorkoutTime > 0 {
            remainingTime -= 1
            totalWorkoutTime -= 1
        }

        if remainingTime == 0 {
            if currentRound < totalRounds {
                currentRound += 1
                statusMessage = "Starting Round \(currentRound)"
                remainingTime = interval
            } else {
                stop()
            }
        }
    }


    private func getCompletionMessage() -> String {
        switch timerType {
            case .amrap: return "AMRAP complete!"
            case .emom: return "EMOM complete!"
            case .forTime: return "Workout complete!"
        }
    }
}
