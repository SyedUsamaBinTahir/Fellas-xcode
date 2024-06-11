//
//  EpisodesDetailDescriptionView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct EpisodesDetailDescriptionView: View {
    @EnvironmentObject var viewModel: FeedViewModel
    @Binding var seasonNumber: String
    @Binding var desctiption: String
//    @Binding var host: String
    
    var body: some View {
        Text(seasonNumber)
            .font(.custom(Font.Medium, size: 14))
            .foregroundStyle(Color.white)
        
        Text(desctiption)
            .font(.custom(Font.regular, size: 14))
            .foregroundStyle(Color.white)
        
        HStack(spacing: 0) {
            ForEach(viewModel.feedCategorySeriesDatailModel?.hosts ?? [], id: \.uid) { host in
                Text(host.name)
                    .font(.custom(Font.Medium, size: 14))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
        }
    }
}
