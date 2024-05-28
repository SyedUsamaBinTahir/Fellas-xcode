//
//  FLToastAlert.swift
//  FellasLoaded
//
//  Created by Phebsoft on 27/05/2024.
//

import SwiftUI

struct FLToastAlert: View {
    @Binding var image: String
    @Binding var message: String
    
    var body: some View {
        HStack {
            Image(image)
                .frame(width: 30, height: 30)
            Text(message)
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: 350, height: 50)
        .background(Color.theme.appGrayColor)
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.top, 50)
    }
}
