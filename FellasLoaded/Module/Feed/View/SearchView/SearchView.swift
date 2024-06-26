//
//  SearchView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    @State var search: String = ""
    @State var isSearching: Bool = false
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 16) {
                SearchTextFieldView(search: $search, isSearching: $isSearching)
                
                if feedViewModel.showLoader {
                    FLLoader()
                } else {
                    SearchResultAndRecommentdTextView(isSearching: $isSearching)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(feedViewModel.feedSearchModel?.results ?? [], id: \.uid) { data in
                                EpisodesView(seriesImage: data.thumbnail, episode: "S\(data.sessionNumber ?? 0):E\(data.episodeNumber ?? 0)", title: data.title, description: data.description, icon: "download")
                            }
                        }
                    }
                }
            }
            .padding()
            .onChange(of: search) { result in
                feedViewModel.showLoader = true
                feedViewModel.getFeedSearchList(searchParam: "?search=\(result)")
            }
            .onAppear {
                feedViewModel.showLoader = true    
                feedViewModel.getFeedSearchList(searchParam: "")
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SearchView()
}
