//
//  TimerModel.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/23/25.
//

import Foundation

// Base protocol for shared properties across all timer types
protocol BaseTimer {
    var id: UUID { get }
    var title: String { get }
    var duration: Int { get }
}

struct TimerModel: BaseTimer {
    let id: UUID
    let title: String
    let duration: Int
    let detail: TimerDetails
}

enum TimerDetails {
    case amrap(rounds: Int)             //AMRAP-specific: Number of rounds
    case emom(interval: Int)            //EMOM-specific: Interval in seconds
    case forTime(targetTime: Int)       //For time-specific: Target completion in seconds
}

let amrapTimer = TimerModel(id: UUID(),
                            title: "AMRAP",
                            duration: 30,
                            detail: .amrap(rounds: 2))

let emomTimer = TimerModel(id: UUID(),
                           title: "EMOM",
                           duration: 600,
                           detail: .emom(interval: 60))

let forTimeTimer = TimerModel(id: UUID(),
                              title: "For Time",
                              duration: 300,
                              detail: .forTime(targetTime: 180))
