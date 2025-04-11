//
//  SoonResponse.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation

struct SoonResponse: Codable {
    let group: String
    let amount: Double
    let availablePurchases: [Purchase]
    
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
