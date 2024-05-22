//
//  SearchResultAndRecommentdTextView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct SearchResultAndRecommentdTextView: View {
    @Binding var isSearching: Bool
    
    var body: some View {
        Text(isSearching ? "RESULTS" : "Recommended")
            .font(.custom(Font.semiBold, size: 18))
            .foregroundStyle(Color.white)
    }
}
