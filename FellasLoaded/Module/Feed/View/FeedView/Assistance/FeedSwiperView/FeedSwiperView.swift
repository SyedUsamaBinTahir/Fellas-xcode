//
//  FeedSwiperView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI
import Kingfisher

struct FeedSwiperView: View {
    var feedImage = ""
    var description: String?
    var width: CGFloat
    var height: CGFloat
    var progressBarValue: CGFloat?
    @State var imageAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .bottom) {
                Button(action: imageAction) {
                    KFImage.init(URL(string: "\(feedImage)"))
                        .placeholder({ progress in
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.theme.appCardsColor)

                        })
                        .loadDiskFileSynchronously()
                        .cacheMemoryOnly()
                        .fade(duration: 0.75)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .cornerRadius(8)
                }
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
            
            Spacer()
        }
    }
}

#Preview {
    FeedSwiperView(width: 114, height: 171, imageAction: {})
}
