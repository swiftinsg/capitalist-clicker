//
//  FireView.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation
import SwiftUI

struct FlameView: View {
    
    @State private var flame1 = CGSize(width: 1, height: 1)
    @State private var flame2 = CGSize(width: 1, height: 1)
    @State private var flame3 = CGSize(width: 1, height: 0.8)
    
    @State private var offset = 0.0
    @State private var rotation = -40.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(.flame3)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .scaleEffect(flame3, anchor: .bottom)
                Image(.flame2)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .scaleEffect(flame2, anchor: .bottom)
                Image(.flame1)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .scaleEffect(flame1, anchor: .bottom)
            }
            .ignoresSafeArea(.container, edges: .bottom)
            .padding([.horizontal, .bottom], -32)
            .padding(.bottom, -21)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3).repeatForever()) {
                rotation = -20
            }
            withAnimation(.easeInOut(duration: 2.2).repeatForever()) {
                offset = 21
            }
            withAnimation(.easeInOut(duration: 2).repeatForever()) {
                flame1 = CGSize(width: 1.4, height: 0.9)
            }
            
            withAnimation(.easeInOut(duration: 1).repeatForever()) {
                flame2 = CGSize(width: 0.9, height: 1.3)
            }
            
            withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
                flame3 = CGSize(width: 1.3, height: 1.2)
            }
        }
    }
}
