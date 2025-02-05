//
//  TimerView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/23/25.
//

import SwiftUI

struct TimerView: View {
    @StateObject var viewModel: TimerViewModel
    @State private var showingSheet = false
    //    @State private var selectedTimerType: TimerDetails?

    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                VStack(spacing: 10) {
                    timerSpecificDetails()

                    Spacer()

                    Text(viewModel.statusMessage)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .padding()

                    Text(formatTime(viewModel.remainingTime))
                        .font(.system(size: 66, weight: .semibold))
                        .foregroundStyle(.white)
                        .onTapGesture {
                            showingSheet = true
                        }



                    HStack {
                        if viewModel.isRunning {
                            Button("Pause", action: viewModel.pause)
                                .buttonStyle(PauseButtonStyle())

                            Button("Stop", action: viewModel.stop)
                                .buttonStyle(StopButtonStyle())
                        } else {
                            Button(viewModel.remainingTime > 0 ? "Resume" : "Start", action: viewModel.start)
                                .buttonStyle(StartButtonStyle())
                        }

                    }
                    Spacer()
                }
            }
        }.sheet(isPresented: $showingSheet) {
            TimerSettingsSheet(viewModel: viewModel, showingSheet: $showingSheet)
                .presentationDetents([.medium]) // 👈 Sets the sheet height to half the screen
                .presentationDragIndicator(.visible) // 👈 Adds a drag indicator at the top
                .foregroundStyle(Color.background)

        }
    }

    // Timer Specific Details Based on Timer Type
    @ViewBuilder
    private func timerSpecificDetails() -> some View {
        switch viewModel.timerType {
            case .amrap(let duration):
                VStack { Text("Workout Time Cap \(formatTime(duration))").foregroundStyle(.white) }
            case .emom(let rounds, let interval):
                VStack {
                    Text("Rounds: \(rounds), Interval: \(interval)s")
                        .font(.title).foregroundStyle(.white)
                    Text("Current Round: \(viewModel.currentRound) / \(rounds)").foregroundStyle(.white)
                }
            case .forTime(let duration):
                Text("Time Cap: \(formatTime(duration))").font(.title).foregroundStyle(.white)
            case .none:
                Text("Select a Timer")
        }
    }

    // Function to format the time
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secondsPart = seconds % 60
        return String(format: "%02d:%02d", minutes, secondsPart)
    }
}

struct StartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(Color.buttonBg)
                .frame(width: 86, height: 86)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)

            Circle()
                .fill(Color.buttonPlayInnerBg)
                .frame(width: 66, height: 66)


            Image(systemName: "play.fill")
                .font(.title)
                .foregroundStyle(.buttonBg)

        }
    }
}

// TODO: Move the button components to another file
struct PauseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(Color.buttonBg)
                .frame(width: 86, height: 86)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)

            Circle()
                .fill(Color.buttonPlayInnerBg)
                .frame(width: 66, height: 66)

            Image(systemName: "pause.fill")
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.buttonBg)
        }
    }
}

struct StopButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(Color.buttonBg)
                .frame(width: 86, height: 86)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)

            Circle()
                .fill(Color.buttonPlayInnerBg)
                .frame(width: 66, height: 66)

            Image(systemName: "stop.fill")
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.buttonBg)
        }
    }
}

struct RestartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .fill(Color.buttonBg)
                .frame(width: 86, height: 86)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 5, y: 5)

            Circle()
                .fill(Color.buttonPlayInnerBg)
                .frame(width: 66, height: 66)

            Image(systemName: "arrow.clockwise")
                .font(.system(size: 36, weight: .semibold))
                .foregroundStyle(.buttonBg)
        }
    }
}


#Preview {
    TimerView(viewModel: TimerViewModel())
}
