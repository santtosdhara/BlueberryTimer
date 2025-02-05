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

enum TimerDetails: Hashable {
    case amrap(duration: Int)                        //AMRAP: Workout duration with the timer countdown
    case emom(rounds: Int, interval: Int)            //EMOM-specific: Interval timer with rounds in seconds
    case forTime(cap: Int)                      //For time-specific: Target completion in seconds - Increase timer from 0
}


//TODO: Change the parameters to get the times from the user on the main view.
let amrapTimer = TimerModel(id: UUID(),
                            title: "AMRAP",
                            duration: 0,
                            detail: .amrap(duration: 0))

let emomTimer = TimerModel(id: UUID(),
                           title: "EMOM",
                           duration: 0,
                           detail: .emom(rounds: 0, interval: 0))

let forTimeTimer = TimerModel(id: UUID(),
                              title: "For Time",
                              duration: 0,
                              detail: .forTime(cap: 0))
