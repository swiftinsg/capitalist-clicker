//
//  SoonEntry.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation

struct SoonEntry: Codable {
    let group: Group
    var amount: Double
    var purchases: [Purchase]
}
