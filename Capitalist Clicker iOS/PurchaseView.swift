//
//  PurchaseView.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct PurchaseView: View {
    
    @Environment(Client.self) var client
    
    var purchase: Purchase
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(purchase.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            Text(purchase.name)
                .font(.title)
                .fontWeight(.bold)
            
            if !client.isFireSale {
                Text("\(String(format: "%.2f", purchase.amount)) $00N")
                    .foregroundStyle(.secondary)
                    .font(.title2)
                    .fontWeight(.bold)
            } else {
                Text("\(String(format: "%.2f", purchase.amount)) $00N")
                    .foregroundStyle(.secondary)
                    .font(.title2)
                    .fontWeight(.bold)
                    .strikethrough()
                
                Text("\(String(format: "%.2f", purchase.amount / 2)) $00N")
                    .font(.title2)
                    .fontWeight(.bold)
                    .strikethrough()
            }
            
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
        .padding(.bottom)
    }
}
