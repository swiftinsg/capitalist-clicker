//
//  RabbitView.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct RabbitView: View {
    
    var rabbitNumber: Int
    
    var alignment: Alignment {
        switch rabbitNumber {
        case 1: return .leading
        case 2: return .trailing
        default: return .center
        }
    }
    
    @Binding var clicks: Int
    @Binding var showRabbit: Bool
    @State private var showOptions = false
    
    var body: some View {
        VStack {
            Image("Rabbit\(rabbitNumber)")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: alignment)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        showOptions = true
                    }
                }
            HStack {
                if showOptions {
                    Button("Pet") {
                        if .random() {
                            clicks += 500
                        } else {
                            clicks -= 500
                        }
                        withAnimation {
                            showRabbit = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Feed Banana") {
                        clicks += 200
                        withAnimation {
                            showRabbit = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Feed Chocolate") {
                        clicks -= 1000
                        withAnimation {
                            showRabbit = false
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: alignment)
        }
    }
}
