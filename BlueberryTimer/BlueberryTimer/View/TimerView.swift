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
            VStack(spacing: 20) {
                Text(viewModel.statusMessage)
                    .font(.headline)
                    .padding()
                
                Text("\(formatTime(viewModel.remainingTime))")
                    .font(.largeTitle)
                    .padding()
                
                if viewModel.currentRound > 1 {
                    Text("Round \(viewModel.currentRound)")
                        .font(.title2)
                }
                
                HStack(spacing: 20) {
                    Button(action: viewModel.start) {
                        Text("Start")
                            .padding()
                            .frame(width: 100)
                            .background(Color.green)
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isRunning) //Disable start button if timer is running
                    
                    Button(action: viewModel.pause) {
                        Text("Pause")
                            .padding()
                            .frame(width: 100)
                            .background(Color.yellow)
                            .foregroundStyle(.black)
                            .cornerRadius(10)
                    }
                    .disabled(!viewModel.isRunning)
                    
                    Button(action: viewModel.stop) {
                        Text("Stop")
                            .padding()
                            .frame(width: 100)
                            .background(Color.red)
                            .foregroundStyle(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Blueberry Timer")

    }
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secondsPart = seconds % 60
        return String(format: "%02d:%02d", minutes, secondsPart)
    }
}

#Preview {
    TimerView(viewModel: TimerViewModel(timerModel: amrapTimer))
}
