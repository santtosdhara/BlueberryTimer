//
//  CustomButtonStyle.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 2/6/25.
//

import SwiftUI
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

struct ContinueButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button("Start") {

        }
    }
}
