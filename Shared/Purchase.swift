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
}

extension Purchase {
    static let hotchoco1 = Purchase(
        id: "hotchoco1",
        name: "Hot Chocolate",
        description: "Double your $00N per click.",
        amount: 1,
        imageName: ""
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
        amount: 200,
        imageName: "bryegg"
    )

    static let all: [Purchase] = [
        jc,
        bryan,
        hotchoco1
    ]
}
