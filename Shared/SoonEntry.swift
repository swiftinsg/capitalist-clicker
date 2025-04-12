//
//  SoonEntry.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation
import Vapor

struct SoonEntry: Codable, Content {
    let group: Group
    var clicks: Int
    var purchases: [Purchase]
}
