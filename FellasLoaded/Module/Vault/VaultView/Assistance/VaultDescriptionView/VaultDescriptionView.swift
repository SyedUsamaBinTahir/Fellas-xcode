//
//  ValutDescriptionView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct VaultDescriptionView: View {
    @Binding var expandDescription: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see wh")
                .font(.custom(Font.regular, size: 14))
                .foregroundStyle(.white)
                .lineLimit(expandDescription ? nil : 2)
            Text(expandDescription ? "show less" : "more")
                .font(.custom(Font.bold, size: 14))
                .foregroundStyle(.white)
                .onTapGesture {
                    expandDescription.toggle()
                }
        }
    }
}
