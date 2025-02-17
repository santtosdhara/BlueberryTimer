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
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                switch selectedType {
                    case .amrap:
                        VStack {
                            Text("Total Duration (Min:Sec)")
                                .font(.title)
                                .foregroundStyle(.white)
                            
                            Picker("Minutes", selection: $duration) {
                                ForEach(minuteRange, id: \.self) { minute in
                                    Text("\(minute) minutes").tag(minute)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 200 ,height: 150)
                            .foregroundStyle(.white)
                        }
                        
                    case .emom:
                        /* VStack {
                         Text("Number of Rounds")
                         .font(.headline)
                         .foregroundStyle(.white)
                         
                         Picker("Rounds", selection: $rounds) {
                         ForEach(1...30, id: \.self) { Text("\($0) rounds") }
                         }
                         .pickerStyle(WheelPickerStyle())
                         
                         Text("Interval Duration (seconds)")
                         .font(.headline)
                         .foregroundStyle(.white)
                         
                         Picker("Seconds", selection: $interval) {
                         ForEach([15, 30, 45, 60], id: \.self) { Text("\($0) sec") }
                         }
                         .pickerStyle(MenuPickerStyle())
                         } */
                        
                        VStack () {
                            Text("Number of Rounds")
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            HStack {
                                Text("Rounds")
                                    .font(.headline)
                                Spacer()
                                
                                Button(action: {
                                    if rounds > roundRange.lowerBound {
                                        rounds -= 1
                                    }
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                                
                                Text("\(rounds)")
                                    .font(.title2)
                                    .frame(width: 50, alignment: .center)
                                
                                Button(action: {
                                    if rounds > roundRange.lowerBound {
                                        rounds += 1
                                    }
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                                
                                
                                // Selected Values Display
                                
                                
                                
                            }
                            .padding(.horizontal)
                            
                            
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
                .buttonStyle(StartButtonStyle())
                .padding(.top, 20)
            }
        }
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
