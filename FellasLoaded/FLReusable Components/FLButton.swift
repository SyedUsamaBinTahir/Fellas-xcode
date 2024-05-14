//
//  FLButton.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct FLButton: View {
    @State var action: () -> Void = {}
    var title: String = ""
    var background: Color
    var foreground: Color
    
    var body: some View {
        Button (action: action) {
            Text(title)
                .font(.custom(Font.bold, size: 16))
                .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                .background(background)
                .foregroundColor(foreground)
                .cornerRadius(10)
        }

    }
}

#Preview {
    FLButton(background: Color.white, foreground: Color.black)
}
