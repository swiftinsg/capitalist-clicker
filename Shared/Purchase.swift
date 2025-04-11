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
}

extension Purchase {
    static let hotchoco1 = Purchase(
        id: "hotchoco1",
        name: "Hot Chocolate",
        description: "Double your $00N per click.",
        amount: 1,
        imageName: "hc"
    )

    static let jc = Purchase(
        id: "jc",
        name: "Jia Chen",
        description: "Earn $00N for every bounce.",
        amount: 200,
        imageName: "jc"
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
        bryan,
        jc,
        rabbit,
        tristan
    ]
}
