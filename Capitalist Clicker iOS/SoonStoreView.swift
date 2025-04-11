//
//  SoonStoreView.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct SoonStoreView: View {
    
    @Environment(Client.self) var client
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("$00N Store")
                .padding()
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(client.textColor)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(client.purchases) { purchase in
                        PurchaseView(purchase: purchase)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 21, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 21))
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

#Preview {
    SoonStoreView()
}
