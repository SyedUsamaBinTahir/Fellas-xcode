//
//  FeedHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct FeedHeaderView: View {
    @Binding var redirectSearch: Bool
    @Binding var redirectNotifications: Bool
    
    var body: some View {
        HStack(alignment: .center) {
            Button {
                redirectSearch = true
            } label: {
                Image("search-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            Spacer()
            Image("fellas-loaded-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 98, height: 42, alignment: .center)
                .clipped()
            Spacer()
            Button {
                redirectNotifications = true
            } label: {
                Image("notifications")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
        }
        .padding()
    }
}
