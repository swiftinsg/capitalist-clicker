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
        amount: 0.5,
        imageName: "hc"
    )
    
    static let james = Purchase(
        id: "james",
        name: "James",
        description: "James in a maid outfit. Sweeps up $00N",
        amount: 5,
        imageName: "jame",
        addedFlags: [.james]
    )
    
    static let hotchoco2 = Purchase(
        id: "hotchoco2",
        name: "Hot Chocolate",
        description: "Double your $00N per click.",
        amount: 30,
        imageName: "hc"
    )
    
    static let pavithraa = Purchase(
        id: "pavithraa",
        name: "Pavithraa",
        description: "Your fingers are on fire. Each click counts as five.",
        amount: 80,
        imageName: "pavithraa",
        addedFlags: [.fireClicks]
    )
    
    static let bryan = Purchase(
        id: "bryan",
        name: "Bryan",
        description: "Earn $00N for every rotation.",
        amount: 150,
        imageName: "bryegg",
        addedFlags: [.bryan]
    )

    static let rabbit = Purchase(
        id: "rabbit",
        name: "Jia Chen’s Rabbit",
        description: "Rabbits show up, sometimes you get $00N.",
        amount: 250,
        imageName: "rabbit",
        addedFlags: [.rabbits]
    )
    
    static let hotchoco3 = Purchase(
        id: "hotchoco3",
        name: "Hot Chocolate",
        description: "Double your $00N per click.",
        amount: 400,
        imageName: "hc"
    )
    
    static let sean = Purchase(
        id: "sean",
        name: "Sean",
        description: "🔥 FIRE SALES 🔥",
        amount: 500,
        imageName: "sean",
        addedFlags: [.fireSale]
    )
    
    static let tristan = Purchase(
        id: "tristan",
        name: "Tristan",
        description: "First we mine, then we $00N.",
        amount: 800,
        imageName: "pickaxe",
        addedFlags: [.mining]
    )
    
    static let hotchoco4 = Purchase(
        id: "hotchoco4",
        name: "Hot Chocolate",
        description: "Double your $00N per click.",
        amount: 1000,
        imageName: "hc"
    )
    
    static let jc = Purchase(
        id: "jc",
        name: "Jia Chen",
        description: "Earn $00N for every bounce.",
        amount: 1500,
        imageName: "jc",
        addedFlags: [.jc]
    )
    
    static let tongyu = Purchase(
        id: "tongyu",
        name: "Tongyu",
        description: "fish 🐟",
        amount: 2000,
        imageName: "tongyu",
        addedFlags: [.fish]
    )
    
    static let hotchoco5 = Purchase(
        id: "hotchoco5",
        name: "Hot Chocolate",
        description: "Double your $00N per click.",
        amount: 3000,
        imageName: "hc"
    )

    static let all: [Purchase] = [
        hotchoco1,
        james,
        hotchoco2,
        pavithraa,
        bryan,
        rabbit,
        hotchoco3,
        sean,
        tristan,
        hotchoco4,
        jc,
        tongyu,
        hotchoco5
    ]
}
