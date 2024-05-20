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
                HStack(spacing: 5) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("search-back-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    }
                    
                    HStack(spacing: 10) {
                        Image("search-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.leading, 10)
                        TextField("Search", text: $search)
                            .font(.custom(Font.regular, size: 16))
                            .foregroundColor(.white)
                    }
                    .padding(5)
                    .background(Color.theme.appGrayColor)
                    .cornerRadius(5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: isSearching ? 1 : 0)
                    }
                    .onTapGesture {
                        isSearching.toggle()
                    }
                }
                .padding(.top, 40)
                
                Text(isSearching ? "RESULTS" : "Recommended")
                    .font(.custom(Font.semiBold, size: 18))
                    .foregroundStyle(Color.white)
                
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
