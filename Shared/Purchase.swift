//
//  Purchase.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation

struct Purchase: Identifiable, Codable, Equatable {
    var id: String {
        name
    }
    
    var name: String
    var description: String
    
    var amount: Double

    var imageName: String
    
    static let jc = Purchase(name: "Jia Chen", description: "Earn $00N for every bounce", amount: 200, imageName: "jc")
    
    static let all: [Purchase] = [
        jc
    ]
}
