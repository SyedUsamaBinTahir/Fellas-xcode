//
//  ProfileImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("default-profile-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 108, height: 108, alignment: .center)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay {
                    Circle()
                        .stroke(Color.white)
                }
            
            Text("Title")
                .font(.custom(Font.semiBold, size: 24))
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    ProfileImageView()
}
