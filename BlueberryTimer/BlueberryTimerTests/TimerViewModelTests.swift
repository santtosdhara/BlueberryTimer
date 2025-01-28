//
//  TimerViewModelTests.swift
//  BlueberryTimerTests
//
//  Created by Dhara Santos on 1/23/25.
//

import Testing
@testable import BlueberryTimer
import Foundation
import XCTest

final class TimerViewModelTests: XCTestCase {

    func testStartTimer() {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let amrapTimer = TimerModel(id: UUID(),
                                    title: "Test Timer",
                                    duration: 60,
                                    detail: .amrap(rounds: 1))

        let viewModel = TimerViewModel(timerModel: amrapTimer)

        viewModel.start()
        XCTAssertTrue(viewModel.isRunning, "Timer should be running after start.")
        XCTAssertEqual(viewModel.remainingTime, 60, "Remaining time should initially match the timer's duration ")
    }

    func testPauseTimer() {
        // Arrange:

        let amrapTimer = TimerModel(id: UUID(),
                                    title: "Test AMRAP Timer",
                                    duration: 60,
                                    detail: .amrap(rounds: 1))

        let viewModel = TimerViewModel(timerModel: amrapTimer)
        viewModel.start()

        //Act

        viewModel.pause()

        XCTAssertFalse(viewModel.isRunning, "Timer should not be running after pause")
    }

    func testResumeTimer() {
        //Arrange

        let emomTimer = TimerModel(id: UUID(),
                                   title: "Test EMOM timer",
                                   duration: 160,
                                   detail: .emom(interval: 30))

        let viewModel = TimerViewModel(timerModel: emomTimer)
        viewModel.start()
        viewModel.pause()

        viewModel.resume()

        XCTAssertTrue(viewModel.isRunning, "Timer should be running after resume")
        XCTAssertEqual(viewModel.remainingTime, 160, "Remainig time should not reset when resuming")
    }

}
