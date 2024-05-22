//
//  VaultCommentsCardView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct VaultCommentsCardView: View {
    @Binding var numberOfComments: String
    @Binding var profileImage: String
    @Binding var comment: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
               Text("COMMENTS")
                    .font(.custom(Font.semiBold, size: 14))
                    .foregroundStyle(.white)
                Text(numberOfComments)
                    .font(.custom(Font.regular, size: 14))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            
            HStack {
                Image(profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24, alignment: .center)
                Text(comment)
                    .font(.custom(Font.regular, size: 14))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Image("expand-arrow-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18, alignment: .center)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.theme.tabbarColor)
        .cornerRadius(10)
    }
}
