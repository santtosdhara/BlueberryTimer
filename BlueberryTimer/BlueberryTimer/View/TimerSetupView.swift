import SwiftUI

struct TimerSetupView: SwiftUI.View {
    let selectedType: TimerDetails
    @State private var duration: TimeInterval = 60
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
                            Text("Set up your AMRAP")
                                .font(.title)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)

                            ZStack {
                                Rectangle()
                                    .fill(Color.buttonBg)
                                    .frame(width: 350, height: 35)
                                    .cornerRadius(10)
                                    .padding()
                                    .opacity(0.3)

                                HStack {
                                    Spacer()
                                    Picker("Minutes", selection: $duration) {
                                        ForEach(minuteRange, id: \.self) { minute in
                                            Text("\(minute) minutes").tag(minute)
                                                .foregroundStyle(.white)
                                                .font(.system(size: 30, weight: .medium))
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .frame(width: 365 ,height: 150)
                                    Spacer()
                                }
                            }
                            .frame(maxWidth:400, maxHeight: 200)
                            .scrollContentBackground(.hidden)
                        }
                        .frame(maxWidth:400, maxHeight: 500)
                        .scrollContentBackground(.hidden)

                    case .emom:
                        VStack {
                            Text("Set up your EMOM")
                                .font(.title)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .padding(.bottom, 30)
                            Text("Rounds:")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.white)
                                .frame(width: 300, height: 30, alignment: .leading)//
                                .multilineTextAlignment(.leading)

                            ZStack {
                                Rectangle()
                                    .fill(Color.buttonBg)
                                    .frame(width: 350, height: 40)
                                    .opacity(0.3)
                                    .cornerRadius(10)

                                HStack {
                                    Stepper("\(interval)", value: $rounds, in: 0...20, step: 1)
                                        .font(.title3)
                                        .foregroundStyle(Color.white)
                                        .tint(Color.buttonBg)
                                        .padding()

                                }
                                .frame(width: 280, height: 60)
                                .padding(.horizontal)

                            }

                            VStack {
                                Text("Timer Interval:")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                    .frame(width: 300, height: 30, alignment: .leading)
                                    .background(Color.background)
                                    .opacity(100)
                                    .multilineTextAlignment(.leading)
                                    .padding(.bottom, 10)

                                ZStack {

                                    Rectangle()
                                        .fill(Color.buttonBg)
                                        .frame(width: 350, height: 40)
                                        .opacity(0.3)
                                        .cornerRadius(10)
                                    
                                    HStack(alignment: .center) {
                                        Picker("Minutes", selection: $duration) {
                                            ForEach(minuteRange, id: \.self) { minute in
                                                Text("\(minute) minutes")
                                                    .tag(minute)
                                                    .font(.system(size: 20, weight: .medium))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                        .frame(width: 120 ,height: 150, alignment: .leading)


                                        Text(":")
                                            .font(.title)
                                            .foregroundStyle(.white)
                                            .fontWeight(.bold)
//                                            .padding()

                                        Picker("Minutes", selection: $duration) {
                                            ForEach(minuteRange, id: \.self) { minute in
                                                Text("\(minute) seconds")
                                                    .tag(minute)
                                                    .font(.system(size: 20, weight: .medium))
                                                    .foregroundStyle(.white)
                                            }
                                        }
                                        .pickerStyle(.wheel)
                                        .frame(width: 130 ,height: 150)
                                    }
//                                    .padding(.horizontal)
                                    .frame(width: 300 ,height: 40, alignment: .trailing)
                                }
                            }

                        }
                        .frame(maxWidth:400, maxHeight: 500)
                        .scrollContentBackground(.hidden)

                    case .forTime:
                        VStack {
                            Text("Set up your Time Cap")
                                .font(.title)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)

                            ZStack {
                                Rectangle()
                                    .fill(Color.buttonBg)
                                    .frame(width: 350, height: 35)
                                    .cornerRadius(10)
                                    .padding()
                                    .opacity(0.3)

                                HStack {
                                    Spacer()
                                    Picker("Minutes", selection: $timeCap) {
                                        ForEach(minuteRange, id: \.self) { minute in
                                            Text("\(minute) minutes").tag(minute)
                                                .foregroundStyle(.white)
                                                .font(.system(size: 30, weight: .medium))
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .frame(width: 365 ,height: 150)
                                    Spacer()
                                }
                            }
                            .frame(maxWidth:400, maxHeight: 200)
                            .scrollContentBackground(.hidden)
                        }
                        .frame(maxWidth:400, maxHeight: 500)
                        .scrollContentBackground(.hidden)
                }

                Button(action: {
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
                }) {
                    Text("Start Timer")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.buttonBg)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 250, height: 50)
                .background(.buttonPlayInnerBg)
                .cornerRadius(10)
                .shadow(radius: 10)
            }
        }
    }
}

#Preview {
    TimerSetupView(selectedType: .emom(rounds: 1, interval: 0) , onConfirm: { _ in })
}
