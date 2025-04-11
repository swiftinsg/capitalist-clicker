//
//  ContentView.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var client = Client()
    
    var body: some View {
        @Bindable var client = client
        
        if !client.started {
            NavigationStack {
                Form {
                    Section {
                        LabeledContent("IP Address") {
                            TextField("0.0.0.0:8080",
                                      text: Binding(get: {
                                client.address ?? ""
                            }, set: {
                                client.address = $0
                            }))
                            .monospaced()
                        }
                        
                        Picker("Group", selection: $client.group) {
                            ForEach(Group.allCases, id: \.self) { group in
                                Text(group.name)
                                    .tag(group)
                            }
                        }
                    }
                    
                    DisclosureGroup("Developer Tools") {
                        Section {
                            Toggle("Show All Purchasables", isOn: $client.showAllPurchasables)
                            
                            Picker("Initial Click Count", selection: $client.clicks) {
                                let clickOptions = [0, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000, 10000000000]
                                
                                ForEach(clickOptions, id: \.self) { click in
                                    Text("\(click) → \(Double(click) * 0.01, specifier: "%.2f") $00N")
                                        .tag(click)
                                }
                            }
                            
                            Picker("Clicks Multiplier (1 click == ?? clicks)", selection: $client.clicksMultiplier) {
                                let clickOptions = [1, 2, 5, 10, 20, 50, 100, 200, 500, 1000]
                                
                                ForEach(clickOptions, id: \.self) { click in
                                    Text("\(click)x")
                                        .tag(click)
                                }
                            }
                            
                            Button("Prefill Loopback IP address") {
                                client.address = "172.0.0.1:8080"
                            }
                            
                            Button("Prefill JC IP address") {
                                client.address = "192.168.18.181:8080"
                            }

                            Button("Prefill Tristan IP address") {
                                client.address = "172.20.10.3:8080"
                            }
                        } header: {
                            Text("Developer Tools")
                        } footer: {
                            Text("All should be disabled in production.")
                        }
                    }

                    
                    Button("Start") {
                        client.start()
                    }
                    .disabled(client.address == nil)
                }
                .navigationTitle("Set Up Capitalist Clicker")
            }
        } else {
            ZStack {
                if client.isFireSale || client.isFireClick {
                    FlameView()
                }
                
                VStack(alignment: .leading) {
                    ZStack(alignment: .bottomTrailing) {
                        Button {
                            client.clicks += 1 * client.clicksMultiplier * (client.isFireClick ? 5 : 1)
                        } label: {
                            ZStack {
                                VStack {
                                    if client.isFireClick {
                                        Text("5x click multiplier!")
                                            .font(.title)
                                            .fontWeight(.bold)
                                    }
                                    
                                    HStack {
                                        if client.isFireSale {
                                            Image(.sean)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 200)
                                        }

                                        Text(client.isFireSale ? "Fire Sale" : "Tap Me!")
                                            .font(.system(size: 200))
                                            .fontWeight(.bold)
                                    }
                                    Text("\(client.soonPerClick, specifier: "%.2f") $00N Per Click")
                                        .font(.title)
                                        .fontWeight(.bold)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.blue.opacity(0.0001))
                            .foregroundStyle(client.textColor)
                        }
                        
                        if client.hasBoughtMining {
                            TristanMiningView {
                                client.clicks += 500
                            }
                        }
                    }
                    
                    if !client.purchases.isEmpty {
                        SoonStoreView()
                    }
                }
                
                if client.showRabbit1 {
                    RabbitView(rabbitNumber: 1, clicks: $client.clicks, showRabbit: $client.showRabbit1)
                        .transition(.move(edge: .leading))
                }
                
                if client.showRabbit2 {
                    RabbitView(rabbitNumber: 2, clicks: $client.clicks, showRabbit: $client.showRabbit2)
                        .transition(.move(edge: .trailing))
                }
            }
            .background(client.backgroundColor, ignoresSafeAreaEdges: .all)
            .environment(client)
        }
    }
}

#Preview {
    ContentView()
}
