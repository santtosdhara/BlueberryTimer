//
//  TimerView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/23/25.
//

import SwiftUI

struct TimerView: View {
    @StateObject var viewModel: TimerViewModel // StateObject for observing changes

    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea(.all)
                VStack(spacing: 10) {
                    timerSpecificDetails()
                    //Change this statusMessage to the timer name
                    Spacer()

                    Text(viewModel.statusMessage)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .padding()

                    Text(formatTime(viewModel.remainingTime))
                        .font(.system(size: 66, weight: .semibold))
                        .foregroundStyle(.white)


                    //Mudar essa lógica pra mudar os botões quando estiver pausado
                    HStack {
                        if !viewModel.isRunning {
                            Button("Start", action: viewModel.start)
                                .buttonStyle(StartButtonStyle())
                        } else {
                            Button("Stop", action: viewModel.stop)
                                .buttonStyle(StopButtonStyle())
                            Button("Pause", action: viewModel.pause)
                                .buttonStyle(PauseButtonStyle())

                            Button("Resume", action: viewModel.start)
                                .buttonStyle(RestartButtonStyle())
                        }

                    }
                    Spacer()
                }
            }

        }//end NavigationView
    }

    // Timer Specific Details Based on Timer Type
    @ViewBuilder
    private func timerSpecificDetails() -> some View {
        switch viewModel.timerType {
            case .amrap(let rounds):
                VStack {
                    Text("ROUNDS")
                        .foregroundStyle(.white)
                    Text("\(viewModel.currentRound) / \(rounds)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
            case .emom(let interval):
                Text("Interval: \(interval) seconds")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            case .forTime(let targetTime):
                Text("Target Time: \(formatTime(targetTime))")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
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
    TimerView(viewModel: TimerViewModel(timerModel: amrapTimer))
}
