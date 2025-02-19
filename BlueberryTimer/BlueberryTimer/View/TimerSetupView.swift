import SwiftUI

struct TimerSetupView: SwiftUI.View {
    let selectedType: TimerDetails
    @State private var duration: TimeInterval = 0 // Default to 1 min
    @State private var rounds: Int = 1
    @State private var interval: Int = 0
    @State private var timeCap: Int = 0
    let roundRange = 1...20
    let minuteRange = Array(1...59)
    var onConfirm: (TimerDetails) -> Void

    var body: some View {
        //        NavigationView {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                switch selectedType {
                    case .amrap:
                        VStack {
                            Form {
                                Section(header: Text("Total Duration: ")
                                    .font(.body)
                                    .foregroundStyle(.white)) {

                                        HStack {
                                            Spacer()
                                            Picker("Minutes", selection: $duration) {
                                                ForEach(minuteRange, id: \.self) { minute in
                                                    Text("\(minute) minutes").tag(minute)
                                                        .foregroundStyle(.white)
                                                        .font(.system(size: 20, weight: .medium))
                                                }
                                            }
                                            .pickerStyle(.wheel)
                                            .frame(width: 200 ,height: 40)
                                            Spacer()
                                        }
                                    }
                                    .listRowBackground(Rectangle()
                                        .background(Color.clear)
                                        .foregroundColor(Color.buttonBg)
                                        .opacity(0.3))
                            }
                            .frame(maxWidth:400, maxHeight: 300)
                            .scrollContentBackground(.hidden)

                        }

                    case .emom:
                        ZStack {
                            Color.background.ignoresSafeArea(.all) // Set background
                            Form {
                                Section(header: Text("Rounds:")
                                    .font(.body)
                                    .foregroundStyle(.white)
                                ){
                                    HStack {
                                        Stepper("\(interval)", value: $interval, in: 0...20, step: 1)
                                            .font(.title3)
                                            .foregroundStyle(Color.white)
                                            .tint(Color.buttonBg)
                                    }
                                    .padding(.horizontal)
                                }
                                .listRowBackground(Rectangle()
                                    .background(Color.clear)
                                    .foregroundColor(Color.buttonBg)
                                    .opacity(0.3)
                                )

                                Section(header: Text("Interval:")
                                    .font(.body)
                                    .foregroundStyle(.white)
                                ) {
                                    HStack {
                                        Text("Time Interval:")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)

                                        Spacer()

                                        Picker("Minutes", selection: $duration) {
                                            ForEach(minuteRange, id: \.self) { minute in
                                                Text("\(minute) min")
                                                    .tag(minute)
                                                    .font(.system(size: 20, weight: .medium))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                        .frame(width: 100 ,height: 40)
                                    }
                                    .padding(.horizontal)
                                }
                                .listRowBackground(Rectangle()
                                    .background(Color.clear)
                                    .foregroundColor(Color.buttonBg)
                                    .opacity(0.3)
                                )
                            }
                            .frame(maxWidth:400, maxHeight: 300)
                            .scrollContentBackground(.hidden)
                        }


                    case .forTime:
                        VStack {
                            Text("Time Cap (Min)")
                                .font(.headline)
                                .foregroundStyle(.white)

                            Picker("Minutes", selection: $timeCap) {
                                ForEach(1...60, id: \.self) { Text("\($0) min") }
                            }
                            .pickerStyle(WheelPickerStyle())

                        }
                }


                Button("Start Timer") {
                    let newTimer: TimerDetails
                    switch selectedType {
                        case .amrap:
                            newTimer = .amrap(duration: Int(duration))
                        case .emom:
                            newTimer = .emom(rounds: rounds, interval: interval)
                        case .forTime:
                            newTimer = .forTime(cap: timeCap * 60)
                    }
                    onConfirm(newTimer)
                }
                .frame(maxWidth: 250, maxHeight: 20)
                .padding() // Ensure proper spacing around text
                .background(.buttonPlayInnerBg) // Ensure this color is visible
                .foregroundColor(.buttonBg) // Ensure contrast
                .font(.title2)
                .fontWeight(.semibold)
                .cornerRadius(10) // Make sure it has rounded corners
                .shadow(radius: 3)
            }
        }
        //            .toolbar {
        //                ToolbarItem(placement: .principal) {
        //                    Text("\(titleToolBar.ti)")
        //                        .font(.headline)
        //                        .foregroundColor(.white) // Correct way to change color
        //                }
    }
}

// **Custom SwiftUI Wrapper for UIDatePicker**
struct CustomTimerPickerView: UIViewRepresentable {
    @Binding var timeInterval: TimeInterval

    func makeUIView(context: Context) -> UIDatePicker {
        let picker = UIDatePicker()
        picker.datePickerMode = .countDownTimer
        picker.addTarget(context.coordinator, action: #selector(Coordinator.updateTime), for: .valueChanged)
        return picker
    }

    func updateUIView(_ uiView: UIDatePicker, context: Context) {
        uiView.countDownDuration = timeInterval
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: CustomTimerPickerView

        init(_ parent: CustomTimerPickerView) {
            self.parent = parent
        }

        @objc func updateTime(_ sender: UIDatePicker) {
            parent.timeInterval = sender.countDownDuration
        }
    }
}


#Preview {
    TimerSetupView(selectedType: .amrap(duration: 0), onConfirm: { _ in })
}
