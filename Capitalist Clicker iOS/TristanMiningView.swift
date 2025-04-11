//
//  TristanMiningView.swift
//  Capitalist Clicker
//
//  Created by Tristan Chay on 11/4/25.
//

import SwiftUI

struct TristanMiningView: View {

    @State private var awakeSecondsLeft = 15
    @State private var count = 0

    var onMine: (() -> Void)?

    var body: some View {
        Button {
            awakeSecondsLeft = 15
        } label: {
            VStack {
                Text(awakeSecondsLeft > 0 ? "\(awakeSecondsLeft)s" : "Tap to wake him up!")
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .background(.white)
                    .foregroundStyle(.black)
                    .contentTransition(.numericText())
                    .clipShape(.rect(cornerRadius: 4))

                if awakeSecondsLeft > 0 {
                    Image("tristan\(count % 4)")
                        .resizable()
                        .scaledToFit()
                } else {
                    VStack(alignment: .trailing, spacing: -5) {
                        Image(systemName: "zzz")
                            .zIndex(10)
                            .font(.largeTitle)
                        Image(.pickaxe)
                            .resizable()
                            .scaledToFit()
                            .clipShape(.circle)
                    }
                }
            }
            .frame(width: 150)
        }
        .onAppear {
            timer()
        }
        .onChange(of: count) {
            if count % 4 == 3 {
                onMine?()
            }
        }
    }

    func timer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if awakeSecondsLeft > 0 {
                awakeSecondsLeft -= 1
                count += 1
            }
        }
    }
}

#Preview {
    TristanMiningView()
}
