//
//  BouncingJiaChenView.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI
import SpriteKit

struct BouncingJiaChenView: View {
    
    var onCollision: (() -> Void)
    
    var scene: SKScene {
        let scene = BouncyJiaChenScene()
        scene.size = CGSize(width: 1920 / 3, height: 1080 / 3)
        scene.scaleMode = .resizeFill
        scene.onCollision = onCollision
        
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene, options: [.allowsTransparency])
            .ignoresSafeArea()
    }
}

class BouncyJiaChenScene: SKScene, SKPhysicsContactDelegate {
    private var jcNode: SKSpriteNode!
    private var velocity = CGVector(dx: 200, dy: 150) // points/sec
    
    var onCollision: (() -> Void)?
    
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = 0b1
        
        jcNode = SKSpriteNode(imageNamed: "jc")
        
        jcNode.size = CGSize(width: 66, height: 80)
        jcNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        jcNode.physicsBody = SKPhysicsBody(rectangleOf: jcNode.size)
        jcNode.physicsBody?.affectedByGravity = false
        jcNode.physicsBody?.allowsRotation = false
        jcNode.physicsBody?.friction = 0
        jcNode.physicsBody?.restitution = 1.0
        jcNode.physicsBody?.linearDamping = 0
        jcNode.physicsBody?.velocity = CGVector(dx: 200, dy: 100)
        
        jcNode.physicsBody?.categoryBitMask = 0b10
        jcNode.physicsBody?.contactTestBitMask = 0b1
        
        addChild(jcNode)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        onCollision?()
    }
}
