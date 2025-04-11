//
//  Purchase.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation

struct Purchase: Identifiable, Codable, Equatable {
    var id: String
    
    var name: String
    var description: String
    
    var amount: Double

    var imageName: String
    
    var addedFlags: [Flag] = []
    
    static func == (lhs: Purchase, rhs: Purchase) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Purchase {
    static let hotchoco1 = Purchase(
        id: "hotchoco1",
        name: "Hot Chocolate",
        description: "Double your $00N per click.",
        amount: 1,
        imageName: "hc"
    )
    
    static let james = Purchase(id: "james",
        name: "James",
        description: "James in a maid outfit. Sweeps up $00N",
        amount: 42.5,
        imageName: "jame"
    )
    
    static let bryan = Purchase(
        id: "bryan",
        name: "Bryan",
        description: "Earn $00N for every rotation.",
        amount: 50,
        imageName: "bryegg"
    )

    static let tristan = Purchase(
        id: "tristan",
        name: "Tristan",
        description: "First we mine, then we $00N.",
        amount: 100,
        imageName: "pickaxe",
        addedFlags: [.mining]
    )

    static let pavithraa = Purchase(
        id: "pavithraa",
        name: "Pavithraa",
        description: "Your fingers are on fire. Each click counts as five.",
        amount: 150,
        imageName: "pavithraa",
        addedFlags: [.fireClicks]
    )

    static let sean = Purchase(
        id: "sean",
        name: "Sean",
        description: "🔥 FIRE SALES 🔥",
        amount: 200,
        imageName: "sean",
        addedFlags: [.fireSale]
    )
    
    static let jc = Purchase(
        id: "jc",
        name: "Jia Chen",
        description: "Earn $00N for every bounce.",
        amount: 300,
        imageName: "jc"
    )
    
    static let rabbit = Purchase(
        id: "rabbit",
        name: "Jia Chen’s Rabbit",
        description: "Rabbits show up, sometimes you get $00N.",
        amount: 400,
        imageName: "rabbit",
        addedFlags: [.rabbits]
    )

    static let all: [Purchase] = [
        hotchoco1,
        james,
        sean,
        bryan,
        jc,
        rabbit,
        tristan,
        pavithraa
    ]
}
