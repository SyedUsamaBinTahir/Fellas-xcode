//
//  FeedSwiperHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 07/06/2024.
//

import SwiftUI

struct FeedSwiperHeaderView: View {
    var title = ""
    @State var action: () ->  Void = {}
    
    var body: some View {
        HStack {
           
                Text(title)
                    .font(.custom(Font.semiBold, size: 18))
                    .foregroundStyle(Color.theme.textGrayColor)
                
                Spacer()
            Button(action: action) {
                Image("chevron-small-icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 24, height: 24)
            }
        }
    }
}
