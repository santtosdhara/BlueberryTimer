import SwiftUI

struct TimerSetupView: View {
    @ObservedObject var viewModel: TimerViewModel
    let selectedType: TimerType
    var onTimerConfigured: () -> Void

    @State private var duration: String = "900" // Default: 15 minutes
    @State private var emomRounds: String = "5"
    @State private var emomInterval: String = "60"

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
                .onTapGesture { hideKeyboard() }

            VStack {
                switch selectedType {
                case .amrap:
                    VStack {
                        Text("Set up your AMRAP")
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)

                        inputField(title: "Duration (seconds)", text: $duration)
                    }

                case .emom:
                    VStack {
                        Text("Set up your EMOM")
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)

                        inputField(title: "Rounds", text: $emomRounds)
                        inputField(title: "Interval (seconds)", text: $emomInterval)
                    }

                case .forTime:
                    VStack {
                        Text("Set up your Time Cap")
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)

                        inputField(title: "Duration (seconds)", text: $duration)
                    }
                }

                Button(action: {
                    configureAndStartTimer() // ✅ Uses updated TextField values
                    onTimerConfigured()
                }) {
                    Text("Start Timer")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.buttonBg)
                        .frame(width: 250, height: 50)
                        .background(Color.buttonPlayInnerBg)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
            .padding()
            .onAppear {
                updateUI()
            }
        }
        .onAppear {
            print("🆕 TimerSetupView Appeared - Type: \(selectedType)")

            DispatchQueue.main.async {
                updateUI()
            }
        }
        .onChange(of: duration) { newValue in
            if duration != newValue {
                print("📝 Duration Edited: \(newValue)")
            }
        }
        .onChange(of: emomRounds) { newValue in
            if emomRounds != newValue {
                print("📝 EMOM Rounds Edited: \(newValue)")
            }
        }
        .onChange(of: emomInterval) { newValue in
            if emomInterval != newValue {
                print("📝 EMOM Interval Edited: \(newValue)")
            }
        }
    }

    // MARK: - Reusable Input Field
    private func inputField(title: String, text: Binding<String>) -> some View {
        VStack {
            Text(title)
                .foregroundStyle(.white)

            TextField("Enter \(title.lowercased())", text: text)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: 250)
        }
    }

    // MARK: - Update UI on Appear

    private func updateUI() {
        switch selectedType {
            case .amrap(let amrapDuration):
                if duration.isEmpty || duration == "900" {
                    self.duration = String(amrapDuration)
                }
            case .forTime(let forTimeDuration):
                if duration.isEmpty || duration == "900" {
                    self.duration = String(forTimeDuration)
                }
            case .emom(let rounds, let interval):
                if emomRounds.isEmpty || emomRounds == "5" {
                    self.emomRounds = String(rounds)
                }
                if emomInterval.isEmpty || emomInterval == "60" {
                    self.emomInterval = String(interval)
                }
        }
    }
    

    // MARK: - Configure and Start Timer (Uses User Input)
    private func configureAndStartTimer() {

        let durationValue = Int(duration) ?? 900 // Default: 15 min
        let emomRoundsValue = Int(emomRounds) ?? 5
        let emomIntervalValue = Int(emomInterval) ?? 60

        let timer: TimerModel
        switch selectedType {
        case .amrap:
            timer = createTimer(title: "AMRAP", type: .amrap(duration: durationValue))
        case .forTime:
            timer = createTimer(title: "For Time", type: .forTime(duration: durationValue))
        case .emom:
            timer = createTimer(title: "EMOM", type: .emom(rounds: emomRoundsValue, interval: emomIntervalValue))
        }

        print("✅ Timer Created: \(timer.title) - \(timer.type)") // Debugging
        viewModel.configureTimer(timer: timer)
    }
}

#Preview {
    TimerSetupView(viewModel: TimerViewModel(), selectedType: .amrap(duration: 900)) {
        print("Timer Configured")
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
