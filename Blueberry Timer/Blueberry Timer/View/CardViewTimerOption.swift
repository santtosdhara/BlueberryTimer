//
//  CardViewTimerOption.swift
//  Blueberry Timer
//
//  Created by Dhara Santos on 12/4/24.
//

import SwiftUI

struct CardViewTimerOption: View {
    let icon: String
    let timerName: String
    let timerDescription: String

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.card)
                .frame(width: 328, height: 116)
                .cornerRadius(20)
                .opacity(0.2)

            HStack() {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.white)

                Text(timerName)
                    .font(.custom("SFProRounded-Regular", size: 24))
                    .foregroundColor(Color.white)
            }
           // .frame(maxWidth: .infinity, alignment: .leading) // Align content to the left
           // .padding(.horizontal, 24) // Add padding to the left and right
           // .frame(width: 328, height: 116)
        }
    }
}

#Preview {
    CardViewTimerOption(icon: "figure.run", timerName: "AMRAP", timerDescription: "")
}
