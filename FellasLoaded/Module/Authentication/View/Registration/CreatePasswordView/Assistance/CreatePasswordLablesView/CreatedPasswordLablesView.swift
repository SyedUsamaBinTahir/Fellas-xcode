//
//  CreatedPasswordLablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct CreatePasswordLablesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if horizontalSizeClass == .regular {
                Text("STEP 2 OF 5")
                    .font(.custom(Font.semiBold, size: 16))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            
            Text("Create a password")
                .font(.custom(Font.semiBold, size: 32))
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    CreatePasswordLablesView()
}
