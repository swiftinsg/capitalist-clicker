//
//  BouncingJiaChenView.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct BouncingJiaChenView: View {
    @State private var position = CGPoint(x: 100, y: 100)
    @State private var direction = CGVector(dx: 2, dy: 2)
    
    let onCollision: () -> Void
    
    let size: CGFloat = 80
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            Image("jc")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .position(position)
                .onReceive(timer) { _ in
                    Task {
                        var newPos = CGPoint(
                            x: position.x + direction.dx,
                            y: position.y + direction.dy
                        )
                        
                        var newDirection = direction
                        
                        if newPos.x - size / 2 <= 0 || newPos.x + size / 2 >= geometry.size.width {
                            newDirection.dx *= -1
                            handleCollision()
                        }
                        
                        if newPos.y - size / 2 <= 0 || newPos.y + size / 2 >= geometry.size.height {
                            newDirection.dy *= -1
                            handleCollision()
                        }
                        
                        newPos = CGPoint(
                            x: position.x + newDirection.dx,
                            y: position.y + newDirection.dy
                        )
                        
                        position = newPos
                        direction = newDirection
                    }
                }
        }
        .drawingGroup()
    }
    
    func handleCollision() {
        onCollision()
    }
}
