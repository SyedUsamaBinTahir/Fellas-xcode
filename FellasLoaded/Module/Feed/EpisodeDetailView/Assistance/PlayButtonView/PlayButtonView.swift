//
//  PlayButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct PlayButtonView: View {
    @State var action: () -> Void = {}
    
    var body: some View {
        Button (action: action) {
            HStack {
                Image("play-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text("PLAY")
                    .font(.custom(Font.bold, size: 16))
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(width: 300,height: 48)
            .background(Color.white)
            .foregroundColor(Color.black)
            .cornerRadius(10)
        }
    }
}

#Preview {
    PlayButtonView()
}
