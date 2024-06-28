//
//  VideoQualitySelectionView.swift
//  FellasLoaded
//
//  Created by Syed Usama on 27/06/2024.
//

import SwiftUI

struct VideoQualitySelectionView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                
                HStack {
                    Text("Sleep timer")
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(Color.white)
                }
                
                HStack {
                    Spacer()

                    Button(action: {
                        
                    }, label: {
                        Image("xmark-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    })
                    
                }
            }
            .padding(.top)
            
            VStack(alignment: .leading ,spacing: 30) {
                Button(action: action) {
                    Text("5 minutes")
                        .font(.custom(Font.semiBold, size: 16))
                }

            }
            .foregroundStyle(.white)
            
            VStack(spacing: 12) {
                Rectangle()
                    .fill(Color.theme.appGrayColor)
                    .frame(height: 1)
                Text("This selection only applies to the current video")
                    .font(.custom(Font.Medium, size: 12))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .background(Color.theme.tabbarColor)
        .ignoresSafeArea()
    }
}

#Preview {
    VideoQualitySelectionView(action: {})
}
