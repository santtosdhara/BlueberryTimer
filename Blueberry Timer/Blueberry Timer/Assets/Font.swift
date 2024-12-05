//
//  Font.swift
//  Blueberry Timer
//
//  Created by Dhara Santos on 12/3/24.
//

import Foundation

import SwiftUI

struct BlueberryTimerView: View {
    var body: some View {
        ZStack {
            // Background
            Color("BackgroundColor") // Set this color in Assets.xcassets
                .ignoresSafeArea()

            // Corner circles
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: geometry.size.width * 1.5, height: geometry.size.width * 1.5)
                        .offset(x: -geometry.size.width * 0.7, y: -geometry.size.width * 0.6)

                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .bottomTrailing, endPoint: .topLeading))
                        .frame(width: geometry.size.width * 1.5, height: geometry.size.width * 1.5)
                        .offset(x: geometry.size.width * 0.6, y: geometry.size.width * 0.6)
                }
            }

            // Content
            VStack(spacing: 20) {
                // Title
                Text("Blueberry Timer")
                    .font(.custom("SFProRounded-Bold", size: 36))
                    .foregroundColor(.white)
                    .padding(.top, 50)

                // Cards
                VStack(spacing: 16) {
                    WorkoutCard(icon: "figure.walk", title: "AMRAP", subtitle: "As many rounds as possible")
                    WorkoutCard(icon: "timer", title: "EMOM", subtitle: "Every minute on the minute")
                    WorkoutCard(icon: "stopwatch", title: "FOR TIME", subtitle: "As many rounds as possible")
                    WorkoutCard(icon: "person", title: "TABATA", subtitle: "As many rounds as possible")
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

struct WorkoutCard: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 16) {
            // Icon
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 4) {
                // Title
                Text(title)
                    .font(.custom("SFProRounded-Bold", size: 20))
                    .foregroundColor(.white)

                // Subtitle
                Text(subtitle)
                    .font(.custom("SFProRounded-Regular", size: 14))
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer()
        }
        .padding()
        .background(Color("CardBackgroundColor").opacity(0.8)) // Set this color in Assets.xcassets
        .cornerRadius(12)
    }
}

struct BlueberryTimerView_Previews: PreviewProvider {
    static var previews: some View {
        BlueberryTimerView()
    }
}
