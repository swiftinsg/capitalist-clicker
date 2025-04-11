//
//  ContentView.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var server = Server()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Start") {
                server.start()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
