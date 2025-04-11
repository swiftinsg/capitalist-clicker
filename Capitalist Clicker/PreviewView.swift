//
//  PreviewView.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct PreviewView: View {
    
    @Environment(Server.self) private var server
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Divider()
                Spacer()
                Divider()
                Spacer()
            }
            Divider()
            HStack {
                Spacer()
                Divider()
                Spacer()
                Divider()
                Spacer()
            }
            Divider()
            HStack {
                Spacer()
                Divider()
                Spacer()
                Divider()
                Spacer()
            }
        }
        .frame(width: 1920, height: 1080)
    }
}

#Preview {
    PreviewView()
}
