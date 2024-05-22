//
//  ResetPasswordLablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ResetPasswordLablesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Check your email")
                .font(.custom(Font.semiBold, size: 32))
                .foregroundStyle(Color.white)
            Text("We've just sent a password reset code and link to your email address. Please check your inbox, and don't forget to take a look in your spam folder, just in case.")
                .font(.custom(Font.regular, size: 14))
                .foregroundStyle(Color.theme.textGrayColor)
        }
    }
}

#Preview {
    ResetPasswordLablesView()
}
