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
                    
                    Button("Start") {
                        client.start()
                    }
                }
                .navigationTitle("Set Up Capitalist Clicker")
            }
        } else {
            VStack(alignment: .leading) {
                Button {
                    client.clicks += 1
                } label: {
                    Text("Tap Me!")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.blue.opacity(0.0001))
                        .font(.system(size: 200))
                }
                
                if !client.availablePurchases.isEmpty {
                    Divider()
                    
                    Text("$00N Store")
                        .padding(.horizontal)
                        .font(.headline)
                    ScrollView(.horizontal) {
                        ForEach(client.availablePurchases) { purchase in
                            HStack {
                                VStack(alignment: .leading) {
                                    Image(purchase.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    
                                    HStack {
                                        Text(purchase.name)
                                        
                                        Spacer()
                                        
                                        Text("\(String(format: "%.2f", purchase.amount)) $00N")
                                            .foregroundStyle(.secondary)
                                    }
                                    .font(.title)
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
                                .background(.thickMaterial)
                                .clipShape(.rect(cornerRadius: 16))
                            }
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                    }

                }
            }
        }
    }
}

#Preview {
    ContentView()
}
