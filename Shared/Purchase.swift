//
//  Purchase.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation

struct Purchase: Identifiable, Codable {
    var id: String {
        name
    }
    
    var name: String
    var description: String
    
    var amount: Double

    var imageName: String
}
