//
//  SeriesDetailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI
import Kingfisher

struct ShowAllSeriesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State var title: String = ""
    @State var seriesID: String = ""
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
            ZStack {
                VStack(alignment: .leading, spacing: 30) {
                    ShowAllSeriesHeaderView(title: $title)
                    
                    GeometryReader(content: { geometry in
                        ScrollView {
                            LazyVGrid(columns: horizontalSizeClass == .regular ? horizontalGridColumn : gridColomn, spacing: 14) {
                                ForEach(feedViewModel.feedCategorySeriesModel?.results ?? [], id: \.uid) { data in
                                    KFImage.init(URL(string: data.thumbnail))
                                        .placeholder({ _ in
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.theme.appGrayColor)
                                        })
                                        .loadDiskFileSynchronously()
                                        .cacheMemoryOnly()
                                        .fade(duration: 0.50)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: horizontalSizeClass == .regular ? geometry.size.width * 0.32 : geometry.size.width * 0.48, height: horizontalSizeClass == .regular ? geometry.size.height * 0.37 : geometry.size.height * 0.35)
                                        .clipped()
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            redirectDetailPage = true
                                        }
//                                }
                                }
                            }
                        }
                    })
                }
                .padding()
                .onAppear {
                    feedViewModel.getFeedCategorySeries(id: seriesID)
                    print("Id -->", seriesID)
                }
                
//                NavigationLink(isActive: $redirectDetailPage) {
//                    EpisodeDetailView(seriesDetailID: $seriesID)
//                } label: {
//                    EmptyView()
//                }

                if feedViewModel.showLoader {
                    FLLoader()
                }
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
