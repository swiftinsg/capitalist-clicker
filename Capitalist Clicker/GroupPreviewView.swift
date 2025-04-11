//
//  GroupPreviewView.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct GroupPreviewView: View {
    
    @Binding var group: GroupData
    
    var body: some View {
        ZStack {
            if group.purchases.contains(.jc) {
                BouncingJiaChenView {
                    group.totalSoon += 10
                }
            }
            
            VStack {
                HStack(alignment: .bottom) {
                    ViewThatFits {
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 100))
                        
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 80))
                        
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 60))
                        
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 40))
                        
                        Text("\(group.totalSoon, specifier: "%.2f")")
                            .font(.system(size: 20))
                    }
                    
                    Text("$00N")
                }
                .monospacedDigit()
                .font(.largeTitle)
                .fontWeight(.bold)
                
                Text(group.group.name)
                    .multilineTextAlignment(.center)
                    .padding(.top, 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
