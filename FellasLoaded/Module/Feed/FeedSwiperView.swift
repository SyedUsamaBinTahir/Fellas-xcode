//
//  FeedSwiperView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct FeedSwiperView: View {
    var title = ""
    var feedImage = ""
    var description: String?
    var width: CGFloat
    var height: CGFloat
    var progressBarValue: CGFloat?
    @State var action: () ->  Void = {}
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
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
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0...5, id: \.self)  { image in
                        VStack(alignment: .leading, spacing: 10) {
                            ZStack(alignment: .bottom) {
                                Image("\(feedImage)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: width, height: height)
                                    .cornerRadius(8)
                                if let progressBarValue = progressBarValue {
                                    ProgressView(value: progressBarValue, total: 10)
                                        .tint(Color.theme.appRedColor)
                                        .background(Color.black.opacity(0.5))
                                }
                            }
                            if let description = description {
                                Text(description)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.custom(Font.Medium, size: 16))
                                    .foregroundStyle(Color.white)
                                    .frame(width: width)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FeedSwiperView(width: 114, height: 171)
}
