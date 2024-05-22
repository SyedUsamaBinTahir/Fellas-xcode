//
//  CommunityGuidlineView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct CommunityGuidlineView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Remember to keep comments respectful and to follow our")
                .font(.custom(Font.regular, size: 12))
            Text("Community Guidelines")
                .font(.custom(Font.semiBold, size: 12))
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.appGrayColor)
        .foregroundColor(.white)
    }
}

#Preview {
    CommunityGuidlineView()
}
