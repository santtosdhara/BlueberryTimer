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
enum TimerType: Hashable {
    case amrap(duration: Int)
    case forTime(duration: Int)
    case emom(rounds: Int, interval: Int)
}

struct TimerModel: BaseTimer {
    let id: UUID
    let title: String
    let type: TimerType
}

func createTimer(title: String, type: TimerType) -> TimerModel {
    return TimerModel(id: UUID(), title: title, type: type)
}



