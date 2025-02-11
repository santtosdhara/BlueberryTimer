//
//  TimerPickerView.swift
//  BlueberryTimer
//
//  Created by Dhara Santos on 2/6/25.
//

import SwiftUI

struct TimerPickerView: View {
    @Binding var selectedMinutes: Int
    @Binding var selectedSeconds: Int
    var onConfirm: (Int) -> Void // Callback to pass total seconds to TimerSetupView

    let numbers = Array(0...59)

    var body: some View {
        VStack {
            Text("Set Timer")
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 10)

            HStack(spacing: 20) {
                // Minutes Picker
                CustomNumberPicker(selectedValue: $selectedMinutes, label: "Minutes")

                Text(":")
                    .font(.system(size: 60, weight: .bold))
                //change back to white
                    .foregroundColor(.white)

                // Seconds Picker
                CustomNumberPicker(selectedValue: $selectedSeconds, label: "Seconds")
            }
        }
    }
}

struct CustomNumberPicker: View {
    @Binding var selectedValue: Int
    let label: String
    let numbers = Array(0...59)

    var body: some View {
        GeometryReader { geometry in
            ScrollViewReader { scrollView in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(numbers, id: \.self) { number in
                            Text(String(format: "%02d", number)) // Formats numbers as two digits (e.g., 00, 05, 10)
                                .font(.system(size: 80, weight: .bold))
                            //change the  color to white
                                .foregroundColor(.white)
                                .scaleEffect(selectedValue == number ? 1.2 : 1.0)
                                .frame(width: geometry.size.width, height: 100)
                                .id(number)
                        }
                    }
                    .frame(width: geometry.size.width, alignment: .center)
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let step = Int(value.translation.height / 50)
                            let newIndex = max(0, min(59, selectedValue - step))
                            selectedValue = newIndex
                            withAnimation {
                                scrollView.scrollTo(newIndex, anchor: .center)
                            }
                        }
                )
            }
        }
        .frame(width: 120, height: 120)
        .clipped()
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedMinutes = 0
        @State private var selectedSeconds = 0

        var body: some View {
            TimerPickerView(
                selectedMinutes: $selectedMinutes,
                selectedSeconds: $selectedSeconds,
                onConfirm: { _ in } // Dummy closure for preview
            )
        }
    }

    return PreviewWrapper()
}
