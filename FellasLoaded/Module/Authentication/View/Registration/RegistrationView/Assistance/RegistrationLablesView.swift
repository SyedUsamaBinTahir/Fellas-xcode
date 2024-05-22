//
//  RegistrationLablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct RegistrationLablesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if horizontalSizeClass == .regular {
                Text("STEP 1 OF 5")
                    .font(.custom(Font.semiBold, size: 16))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            
            Text("What's your email?")
                .font(.custom(Font.semiBold, size: 32))
                .foregroundStyle(Color.white)
            
            if horizontalSizeClass == .regular {
                Text("You’ll need to confirm your email later.")
                    .font(.custom(Font.regular, size: 16))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
        }
    }
}

#Preview {
    RegistrationLablesView()
}
