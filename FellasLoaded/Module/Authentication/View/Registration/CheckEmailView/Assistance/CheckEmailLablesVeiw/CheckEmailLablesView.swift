//
//  CheckEmailLablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct CheckEmailLablesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if horizontalSizeClass == .regular {
                Text("STEP 3 OF 5")
                    .font(.custom(Font.semiBold, size: 16))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            
            Text("Check your email")
                .font(.custom(Font.semiBold, size: 32))
                .foregroundStyle(Color.white)
            
            Text("We’ve sent an email to {{email}}, please follow the instructions in the email or type the code we sent you below so we can confirm your email.")
                .font(.custom(Font.regular, size: 14))
                .foregroundStyle(Color.theme.textGrayColor)
        }
    }
}

#Preview {
    CheckEmailLablesView()
}
