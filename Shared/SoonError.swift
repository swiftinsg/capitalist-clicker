//
//  SoonError.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation

struct SoonError: Codable {
    let error: String
    let bigError: String
    
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
