//
//  FishView.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/12/25.
//

import SwiftUI

struct FishView: View {
    
    @Binding var fishes: [FishInfo]
    
    var info: FishInfo
    
    @State private var alignment = Alignment.leading
    
    var onSelected: () -> Void
    
    var body: some View {
        ZStack(alignment: .leading) {
            Button {
                onSelected()
                fishes.removeAll {
                    $0.id == info.id
                }
            } label: {
                Image(systemName: "fish.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(info.color)
                    .overlay(alignment: .trailing) {
                        Image(.tongyu)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.5, anchor: .trailing)
                    }
            }
        }
        .frame(height: 100)
        .scaleEffect(x: info.startAtLeading ? 1 : -1)
        .frame(maxWidth: .infinity, alignment: alignment)
        .onAppear {
            alignment = info.startAtLeading ? .leading : .trailing
            
            withAnimation(.linear(duration: info.crossingTime)) {
                alignment = info.startAtLeading ? .trailing : .leading
            } completion: {
                fishes.removeAll {
                    $0.id == info.id
                }
            }
        }
    }
}
