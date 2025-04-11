//
//  GroupData.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation
import SwiftUI

struct GroupData: Codable, Identifiable {
    
    var id: String {
        group.name
    }
    let group: Group
    var totalSoon: Double
    
    var soonPerClick: Double = 0.01
    
    var purchases: [Purchase]
    
    static func color(for soon: Double) -> [Color] {
        if soon == 0 {
            #if os(iOS)
            return [.black, .green]
            #else
            return [.black, .gray]
            #endif
        } else if soon < 0.50 {
            return [.black, .white]
        } else if soon < 10 {
            return [.white, .black]
        } else if soon < 50 {
            return [.brown, .white]
        } else if soon < 100 {
            return [.pink, .white]
        } else if soon < 200 {
            return [.purple, .white]
        } else if soon < 500 {
            return [.indigo, .white]
        } else if soon < 1000 {
            return [.blue, .white]
        } else if soon < 2000 {
            return [.cyan, .black]
        } else if soon < 3000 {
            return [.teal, .black]
        } else if soon < 5000 {
            return [.mint, .black]
        } else if soon < 7000 {
            return [.green, .white]
        } else if soon < 9000 {
            return [.yellow, .black]
        } else if soon < 10000 {
            return [.orange, .white]
        } else {
            return [.red, .white]
        }
    }
}
