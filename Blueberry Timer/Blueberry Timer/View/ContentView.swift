//
//  ContentView.swift
//  Blueberry Timer
//
//  Created by Dhara Santos on 11/5/24.
//

import SwiftUI

struct ContentView: View {

    lazy var teste: Int = 2
    var body: some View {
        ZStack {
            Color.secondBG
                .ignoresSafeArea()

            //Background style:
            GeometryReader { geometry in
                ZStack {
                    Circle()
                        .fill(LinearGradient(gradient:  Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: geometry.size.width * 1.0, height: geometry.size.height * 1.0)
                        .offset(x: -geometry.size.width * 0.5, y: -geometry.size.width * 0.95)
                }

                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: geometry.size.width * 1.0, height: geometry.size.width * 1.0)
                    .offset(x: geometry.size.width * 0.5, y: geometry.size.width * 1.5)
            }

            VStack(spacing: 20) {
                Text("Blueberry Timer")
                    .font(.custom("SFProRounded-Bold", size: 36))
                    .foregroundStyle(.white)
                    .padding(.top, 40)
                    .padding(.bottom, 50)

                CardViewTimerOption(icon: "figure.run", timerName: "AMRAP", timerDescription: "")
                CardViewTimerOption(icon: "figure.cross.training", timerName: "EMOM", timerDescription: "")
                CardViewTimerOption(icon: "figure.strengthtraining.functional", timerName: "FOR TIME", timerDescription: "")
                CardViewTimerOption(icon: "figure.highintensity.intervaltraining", timerName: "TABATA", timerDescription: "")

                Spacer()

            }


        }
    }
}

#Preview {
    ContentView()
}
