//
//  SpinningSeanView.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/12/25.
//

import SwiftUI

struct SpinningSeanView: View {
    
    var body: some View {
        PhaseAnimator([Angle.zero, Angle(degrees: 360)]) { angle in
            Image(.sean)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .rotationEffect(angle)
        } animation: { _ in
                .linear(duration: 0.7).repeatForever(autoreverses: false)
        }
    }
}

#Preview {
    SpinningSeanView()
}
