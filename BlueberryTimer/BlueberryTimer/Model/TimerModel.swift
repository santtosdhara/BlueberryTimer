//
//  TimerModel.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/23/25.
//

import Foundation

protocol BaseTimer {
    var id: UUID { get }
    var title: String { get }
}

struct TimerModel: BaseTimer {
    let id: UUID
    let title: String
    let detail: TimerDetails
}

enum TimerDetails: Hashable {
    case amrap(duration: Int)
    case emom(rounds: Int, interval: Int)
    case forTime(cap: Int)
}

func createTimer(title: String, detail: TimerDetails) -> TimerModel {
    return TimerModel(id: UUID(), title: title, detail: detail)
}



