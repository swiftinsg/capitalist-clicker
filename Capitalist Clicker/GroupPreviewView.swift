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
                Text("Hello it contains me")
                    .onAppear {
                        group.totalSoon += 100
                    }
            }
            
            VStack {
                Text("\(group.totalSoon, specifier: "%.2f") $00N")
                    .monospacedDigit()
                    .font(.largeTitle)
                
                Text(group.group.name)
            }
        }
    }
}
