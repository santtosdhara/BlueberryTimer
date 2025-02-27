//
//  TimerView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 1/23/25.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel: TimerViewModel
    @Binding var isSettingUpTimer: Bool
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea(.all)

                VStack(spacing: 10) {
                    Spacer()
                        .frame(height: 146)

                    if let activeTimer = viewModel.activeTimer {
                        Text(activeTimer.title)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .padding()
                    }

                    Text("Time cap 12:00")
                        .font(.title3)
                        .foregroundStyle(.white)

                    Text(formatTime(viewModel.remainingTime))
                        .font(.system(size: 100, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.bottom, 50)
                        .padding(.top, 40)

                    HStack {
                        if viewModel.isRunning {
                            Button("Pause", action: viewModel.pauseTimer)
                                .buttonStyle(PauseButtonStyle())

                            Button("Stop") {
                                viewModel.stopTimer()
                                isSettingUpTimer = true
                            }
                            .buttonStyle(StopButtonStyle())

                            Button("Reset", action: viewModel.resetTimer)
                                .buttonStyle(RestartButtonStyle())
                        } else {
                            Button(viewModel.isPaused ? "Resume" : "Start") {
                                viewModel.startTimer()
                            }
                            .buttonStyle(StartButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("Blueberry Timer", displayMode: .inline)
            .navigationBarItems(leading: backButton)
            .gesture(DragGesture().onEnded { gesture in
                if gesture.translation.width > 100 {
                    isSettingUpTimer = true
                }
            })
            .onAppear {
                if let activeTimer = viewModel.activeTimer {
                    print("✅ TimerView Appeared - Using Existing Timer: \(activeTimer.type) with \(viewModel.remainingTime) seconds")
                } else {
                    print("🚫 No active timer or invalid timer detected, please configure one first")
                }
            }
        }
    }

    private var backButton: some View {
        Button(action: {
            isSettingUpTimer = true
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .bold()
            }
            .foregroundColor(.buttonPlayInnerBg)
        }
    }

    // Timer Specific Details Based on Timer Type
    @ViewBuilder
    private func timerSpecificDetails() -> some View {
        if let activeTimer = viewModel.activeTimer {
            switch activeTimer.type {
            case .amrap(let duration):
                VStack {
                    Text("Workout Time Cap: \(formatTime(duration))")
                        .foregroundStyle(.white)
                }
            case .emom(let rounds, let interval):
                VStack {
                    Text("Rounds: \(rounds), Interval: \(formatTime2(interval))")
                        .font(.title).foregroundStyle(.white)
                    Text("Current Round: \(viewModel.currentRound) / \(rounds)")
                        .foregroundStyle(.white)
                }
            case .forTime(let duration):
                Text("Time Cap: \(formatTime(duration))")
                    .font(.title)
                    .foregroundStyle(.white)
            }
        } else {
            Text("No Timer Selected")
                .foregroundStyle(.white)
                .font(.title3)
        }
    }

    // Function to format the time properly
    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func formatTime2(_ intervalSeconds: Int) -> String {
        let interval = intervalSeconds / 60
//        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", interval)
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

#Preview {
    TimerView(viewModel: TimerViewModel(), isSettingUpTimer: .constant(true) )
}
