//
//  Group.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation

enum Group: String, Codable, CaseIterable, CustomStringConvertible {
    case dingoBingo = "1am"
    case fellaHavingHotChocolateUnderAnUmbrellaAt2am = "2am"
    case iPhone16SuperRetinaXDRDisplay61InchDiagonalAllScreenOLEDDisplay2556x1179PixelResolutionAt460ppi = "3am"
    case miloAt4am = "4am"
    case c4T0rD0g0rH4mst3r = "5am"
    case sigmaBroccolis = "6am"
    case quoteYourBestFanficWritersAndCountersUnquote = "7am"
    case hippopotomonstrosesquippedaliophobia = "8am"
    case theHawkTuahs = "1pm"
    case ligma = "2pm"
    case goodTeammatePls = "3pm"
    case mozzarellaAt4pm = "4pm"
    case charlotteEsUnBoteDeBasura = "5pm"
    case worcestershire = "6pm"
    case papayaLebar = "7pm"
    case 🥚 = "8pm"
    
    var description: String {
        rawValue
    }
    
    var name: String {
        switch self {
        case .dingoBingo: "1am: Dingo bingo"
        case .fellaHavingHotChocolateUnderAnUmbrellaAt2am: "2am: fella having hot chocolate under an umbrella @ 2am"
        case .iPhone16SuperRetinaXDRDisplay61InchDiagonalAllScreenOLEDDisplay2556x1179PixelResolutionAt460ppi: "3am: iPhone 16 Super Retina XDR display 6.1‑inch (diagonal) all‑screen OLED display 2556x1179-pixel resolution at 460 ppi"
        case .miloAt4am: "4am: Milo at 4am"
        case .c4T0rD0g0rH4mst3r: "5am: C4T0rD0g0rH4mst3r"
        case .sigmaBroccolis: "6am: Sigma broccolis"
        case .quoteYourBestFanficWritersAndCountersUnquote: "7am: Your best fanfic writers and counters"
        case .hippopotomonstrosesquippedaliophobia: "8am: Hippopotomonstrosesquippedaliophobia"
        case .theHawkTuahs: "1pm: the hawk tuahs"
        case .ligma: "2pm: Ligma"
        case .goodTeammatePls: "3pm: good teammate pls"
        case .mozzarellaAt4pm: "4pm: mozzarella at 4pm"
        case .charlotteEsUnBoteDeBasura: "5pm: Charlotte es un bote de basura"
        case .worcestershire: "6pm: worcestershire"
        case .papayaLebar: "7pm: Papaya lebar"
        case .🥚: "8pm: 🥚"
        }
    }
}
