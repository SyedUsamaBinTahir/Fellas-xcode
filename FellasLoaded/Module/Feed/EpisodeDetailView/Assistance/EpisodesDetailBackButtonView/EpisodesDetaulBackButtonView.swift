//
//  EpisodesDetaulBackButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct EpisodesDetaulBackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("back-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            })
            Spacer()
        }
        .padding()
    }
}

#Preview {
    EpisodesDetaulBackButtonView()
}
