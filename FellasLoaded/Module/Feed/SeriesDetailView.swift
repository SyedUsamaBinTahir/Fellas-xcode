//
//  SeriesDetailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI

struct SeriesDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    private let gridColomn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
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
                        Text("Most Popular")
                            .font(.custom(Font.semiBold, size: 24))
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.top, 30)
                
                ScrollView {
                    LazyVGrid(columns: gridColomn, spacing: 20) {
                        ForEach(1...5, id: \.self) { data in
                            HStack(spacing: 16) {
                                Image("series-image")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: horizontalSizeClass == .regular ? 345 : 171, height: horizontalSizeClass == .regular ? 194 : 256)
                                    .clipped()
                                    .cornerRadius(10)
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
    SeriesDetailView()
}
