//
//  ContentView.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(Server.self) private var server
    @State private var session: Session = .morning
    
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        if !server.isRunning {
            Form {
                Picker("Session", selection: $session) {
                    ForEach(Session.allCases, id: \.self) { session in
                        Text(session.rawValue.capitalized)
                    }
                }
                
                Button("Start") {
                    server.groups = Group.getGroups(for: session).map({ group in
                        GroupData(group: group, totalSoon: 0, purchases: [])
                    })
                    server.start()
                }
            }
            .padding()
        } else {
            NavigationStack {
                List {
                    ForEach(server.groups) { group in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(group.group.name)
                                    .lineLimit(1)
                                Spacer()
                                Text("\(group.totalSoon, specifier: "%.2f") $00N")
                                    .foregroundStyle(.secondary)
                                    .monospacedDigit()
                            }
                            .font(.headline)
                            
                            DisclosureGroup("\(group.purchases.count) Purchases") {
                                VStack {
                                    ForEach(group.purchases) { purchase in
                                        Text(purchase.name)
                                            .font(.subheadline)
                                    }
                                }
                                .padding(.leading)
                            }
                        }
                    }
                }
                .navigationTitle("capitalist clicker server")
                .toolbar {
                    Button("show display", systemImage: "play.display") {
                        openWindow(id: "preview")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
