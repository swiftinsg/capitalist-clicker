//
//  Capitalist_ClickerApp.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

@main
struct Capitalist_ClickerApp: App {
    
    @State private var server = Server()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(server)
        }
        
        WindowGroup(id: "preview") {
            PreviewView()
                .environment(server)
        }
    }
}
