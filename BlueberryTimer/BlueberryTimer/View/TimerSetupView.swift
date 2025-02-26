import SwiftUI

struct TimerSetupView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    let selectedType: TimerType
    @Binding var inputMinutes: String
    @Binding var inputRounds: String
    @Binding var inputInterval: String
    var onTimerConfigured: () -> Void

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

                            inputField(title: "", text: $inputMinutes)


                        }.padding()

                    case .emom:
                        VStack {
                            Text("Set up your EMOM")
                                .font(.title)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)

                            inputField(title: "Rounds", text: $inputRounds)
                            inputField(title: "Interval (seconds)", text: $inputInterval)
                        }

                    case .forTime:
                        VStack {
                            Text("Set up your Time Cap")
                                .font(.title)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)

                            inputField(title: "Duration", text: $inputMinutes)
                        }
                }

                Button(action: {
                    onTimerConfigured()
                    print("Rounds \(inputRounds), \(inputInterval)")
                }) {
                    Text("Start Timer")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.buttonBg)
                        .frame(width: 350, height: 50)
                        .background(Color.buttonPlayInnerBg)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
            .padding()
        }
    }

    // MARK: - Reusable Input Field

    private func inputField(title: String, text: Binding<String>) -> some View {
        VStack {
            Text(title)
                .foregroundStyle(.white)

            TextField("00:00 \(title.lowercased())", text: text)
                .font(.title)
                .foregroundStyle(.white)
                .padding()
                .background(Color.buttonBg)
                .frame(width: 350, height: 60)
                .cornerRadius(10)
                .keyboardType(.numberPad)
                .onSubmit {
                    print("DurationTime\($inputMinutes)")
                }
        }
    }
}

#Preview {
    TimerSetupView(
        viewModel: TimerViewModel(),
        selectedType: .amrap(duration: 0),
        inputMinutes: .constant(""),
        inputRounds: .constant(""),
        inputInterval: .constant("")
    ) {
        print("Timer Configured")
    }
}


extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
