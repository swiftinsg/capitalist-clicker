//
//  GroupData.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation

struct GroupData: Codable, Identifiable {
    
    var id: String {
        group.name
    }
    let group: Group
    var totalSoon: Double
    
    var soonPerClick: Double = 0.01
    
    var purchases: [Purchase]
}
