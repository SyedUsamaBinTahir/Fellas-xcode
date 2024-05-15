//
//  ContinueWatchingDetailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI

struct ContinueWatchingDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 30) {
                ZStack {
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
                    
                    HStack {
                        Text("Continue Watching")
                            .font(.custom(Font.semiBold, size: 24))
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.top, 30)
                
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(1...5, id: \.self) { data in
                            HStack(spacing: 16) {
                                Image("series-image")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: horizontalSizeClass == .regular ? 345 : 124, height: horizontalSizeClass == .regular ? 194 : 69)
                                    .clipped()
                                    .cornerRadius(10)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("S1:E1")
                                        .font(.custom(Font.Medium, size: 14))
                                        .foregroundStyle(Color.theme.textGrayColor)
                                    Text("The Fellas & W2S Get Drunk in Amsterdam The Fellas & W2S Get Drunk in Amsterdam")
                                        .font(.custom(Font.Medium, size: horizontalSizeClass == .regular ? 24 : 16))
                                        .foregroundStyle(.white)
                                        .lineLimit(2)
                                    
                                    if horizontalSizeClass == .regular {
                                        Text("The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why")
                                            .font(.custom(Font.regular, size: 18))
                                            .foregroundStyle(Color.theme.textGrayColor)
                                            .lineLimit(2)
                                    }
                                }
                                Spacer()
                                Image("download")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 23)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContinueWatchingDetailView()
}
