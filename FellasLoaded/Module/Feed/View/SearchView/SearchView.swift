//
//  SearchView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var search: String = ""
    @State var isSearching: Bool = false
    
    var body: some View {
        VStack {
            VStack (alignment: .leading, spacing: 16) {
                SearchTextFieldView(search: $search, isSearching: $isSearching)
                
                SearchResultAndRecommentdTextView(isSearching: $isSearching)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(1...5, id: \.self) { data in
                            EpisodesView(seriesImage: "series-image", episode: "S1:E1", title: "The Fellas & W2S Get Drunk in Amsterdam The Fellas & W2S Get Drunk in Amsterdam", description: "The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why", icon: "download")
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
    SearchView()
}
