//
//  ContentView.swift
//  Blueberry Timer
//
//  Created by Dhara Santos on 11/5/24.
//

import SwiftUI

struct ContentView: View {

    lazy var teste: Int = 1
    var body: some View {
        ZStack {
            HStack {
                Text("Blueberry Timer")
                    .font(.largeTitle)
                    .foregroundStyle(Color.purple)
                    .bold()

                Spacer()

                Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)

        }
//        .background(Color.black.opacity(0.2))


//        NavigationStack {
//            HStack {
//                Text("Timer Buttons")
//                    .navigationTitle("Blueberry Timer")
//                    .toolbar {
//                        ToolbarItem() {
//                            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
//                        }
//                    }
//            }
//        }
//        .padding()
    }
}

#Preview {
    ContentView()
}
