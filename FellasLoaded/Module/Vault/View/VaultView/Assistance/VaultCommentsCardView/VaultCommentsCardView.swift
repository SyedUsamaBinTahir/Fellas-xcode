//
//  VaultCommentsCardView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI
import Kingfisher

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
                KFImage.init(URL(string: profileImage))
                    .placeholder({ progress in
                        Circle()
                            .fill(Color.theme.appGrayColor)
                            .frame(width: 24, height: 24, alignment: .center)
                    })
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.50)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
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
