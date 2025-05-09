//
//  GroupPreviewView.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct GroupPreviewView: View {
    
    var group: GroupData
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(alignment: .bottom) {
                    ViewThatFits {
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 100))
                            .contentTransition(.numericText(value: group.totalSoon))
                        
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 80))
                            .contentTransition(.numericText(value: group.totalSoon))
                        
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 60))
                            .contentTransition(.numericText(value: group.totalSoon))
                        
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 40))
                            .contentTransition(.numericText(value: group.totalSoon))
                        
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 20))
                            .contentTransition(.numericText(value: group.totalSoon))
                    }
                    .animation(.default, value: group.totalSoon)
                    
                    Text("$00N")
                }
                .monospacedDigit()
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(GroupData.color(for: group.totalSoon)[1])
                
                Text(group.group.name)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(GroupData.color(for: group.totalSoon)[1])
                    .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GroupData.color(for: group.totalSoon)[0])
    }
}
