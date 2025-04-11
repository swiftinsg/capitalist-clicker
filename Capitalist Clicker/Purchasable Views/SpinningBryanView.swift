//
//  SpinningBryanView.swift
//  Capitalist Clicker
//
//  Created by Tristan Chay on 11/4/25.
//

import SwiftUI

struct SpinningBryanView: View {

    @State private var rotation = 0.0

    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var onRotation: (() -> Void)?

    var body: some View {
        Image("bryegg")
            .resizable()
            .scaledToFit()
            .frame(width: 100)
            .rotationEffect(.degrees(rotation))
            .onReceive(timer) { _ in
                withAnimation {
                    rotation += 1
                }
                if Int(rotation) % 360 == 0 {
                    onRotation?()
                }
            }
    }
}

#Preview {
    SpinningBryanView()
}
