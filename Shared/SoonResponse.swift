//
//  SoonResponse.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation
import Vapor

struct SoonResponse: Codable, Content {
    let group: Group
    let amount: Double
    let availablePurchases: [Purchase]
    let soonPerClick: Double
    
    let flags: [Flag]
    
    func toData() -> Data {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            print("Error encoding: \(error)")
            return Data()
        }
    }
}

enum Flag: Int, Codable {
    case rabbits
    case fireSale
    case mining
    case fish
    case fireClicks
    case james
    case bryan
    case jc
}
