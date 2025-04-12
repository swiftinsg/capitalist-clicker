//
//  WalkingMaidJamesView.swift
//  Capitalist Clicker
//
//  Created by Sean on 11/4/25.
//

import SwiftUI

struct WalkingMaidJamesView: View {
    
    @State var walkingState: WalkingState = .left
    
    @State var isWalking: Bool = false
    var onWallHit: (() -> Void)
    var body: some View {
        GeometryReader { proxy in
            HStack(alignment: .bottom) {
                let beginningX = walkingState == .left ? 50 : proxy.size.width - 50
                let endX = walkingState == .left ? proxy.size.width - 50 : 50
                Image(.jame)
                    .resizable()
                    .frame(width: 50, height: 86)
                    .scaledToFit()
                    .offset(x: isWalking ? beginningX : endX)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            .onAppear {
                startAnimation()
            }
        }
        
    }
    
    func startAnimation() {
        withAnimation(.bouncy(duration: 15)) {
            isWalking = true
        } completion: {
            isWalking = false
            walkingState = walkingState == .left ? .right : .left
            onWallHit()
            startAnimation()
        }
    }
}

enum WalkingState {
    case left
    case right
}

#Preview {
    WalkingMaidJamesView() {
        print("hit")
    }
    .frame(width: 500)
}
