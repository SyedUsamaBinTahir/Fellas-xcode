//
//  DisplayNameAndImageLablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct DisplayNameAndImageLablesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if horizontalSizeClass == .regular {
                Text("STEP 4 OF 5")
                    .font(.custom(Font.semiBold, size: 16))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            
            Text("Display name & image")
                .font(.custom(Font.semiBold, size: 32))
                .foregroundStyle(Color.white)
            
            Text("Display name is required, you can add a display picture later in your settings. Both display name and image will be visible to other users in comment sections.")
                .font(.custom(Font.regular, size: 14))
                .foregroundStyle(Color.theme.textGrayColor)
        }
    }
}

#Preview {
    DisplayNameAndImageLablesView()
}
