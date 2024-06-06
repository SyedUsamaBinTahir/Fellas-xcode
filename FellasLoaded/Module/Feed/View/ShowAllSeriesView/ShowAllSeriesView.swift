//
//  SeriesDetailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI

struct ShowAllSeriesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var redirectDetailPage = false
    
    var body: some View {
        let gridColomn = [
            GridItem(.adaptive(minimum: 150)),
            GridItem(.adaptive(minimum: 150)),
        ]
        let horizontalGridColumn = [
            GridItem(.adaptive(minimum: 150)),
            GridItem(.adaptive(minimum: 150)),
            GridItem(.adaptive(minimum: 150)),
        ]
        VStack {
            VStack(alignment: .leading, spacing: 30) {
                ShowAllSeriesHeaderView()
                
                GeometryReader(content: { geometry in
                    ScrollView {
                        LazyVGrid(columns: horizontalSizeClass == .regular ? horizontalGridColumn : gridColomn, spacing: 14) {
                            ForEach(1...5, id: \.self) { data in
                                Image("series-image")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: horizontalSizeClass == .regular ? geometry.size.width * 0.32 : geometry.size.width * 0.48, height: horizontalSizeClass == .regular ? geometry.size.height * 0.37 : geometry.size.height * 0.35)
                                    .clipped()
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        redirectDetailPage = true
                                    }
                            }
                        }
                    }
                })
            }
            .padding()
            .navigationDestination(isPresented: $redirectDetailPage) {
                EpisodeDetailView()
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ShowAllSeriesView()
}
