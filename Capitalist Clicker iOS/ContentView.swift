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
            VStack(alignment: .leading) {
                Button {
                    client.clicks += 1 * client.clicksMultiplier
                } label: {
                    Text("Tap Me!")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.blue.opacity(0.0001))
                        .font(.system(size: 200))
                        .fontWeight(.bold)
                        .foregroundStyle(client.textColor)
                }
                
                if !client.purchases.isEmpty {
                    VStack(alignment: .leading) {
                        Text("$00N Store")
                            .padding()
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(client.textColor)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(client.purchases) { purchase in
                                    VStack(alignment: .leading) {
                                        Image(purchase.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        Text(purchase.name)
                                            .font(.title)
                                            .fontWeight(.bold)
                                        
                                        Text("\(String(format: "%.2f", purchase.amount)) $00N")
                                            .foregroundStyle(.secondary)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        
                                        Text(purchase.description)
                                        
                                        Button("Buy", systemImage: "cart") {
                                            withAnimation {
                                                client.itemsPurchased.append(purchase)
                                                client.availablePurchases.removeAll { $0.id == purchase.id }
                                            }
                                        }
                                        .buttonStyle(.borderedProminent)
                                    }
                                    .frame(width: 300, height: 300, alignment: .leading)
                                    .padding()
                                    .background(.thinMaterial)
                                    .clipShape(.rect(cornerRadius: 16))
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                }
                            }
                        }
                    }
                    .background(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 21, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 21))
                    .ignoresSafeArea(.container, edges: .bottom)
                }
            }
            .background(client.backgroundColor, ignoresSafeAreaEdges: .all)
        }
    }
}

#Preview {
    ContentView()
}
