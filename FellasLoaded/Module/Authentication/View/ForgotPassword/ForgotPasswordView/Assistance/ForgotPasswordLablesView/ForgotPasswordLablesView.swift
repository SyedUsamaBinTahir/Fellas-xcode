//
//  ForgotPasswordLablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ForgotPasswordLablesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Reset your password")
                .font(.custom(Font.semiBold, size: 32))
                .foregroundStyle(Color.white)
            Text("Enter the email address you use for Fellas, and we’ll send you a password reset link.")
                .font(.custom(Font.regular, size: 14))
                .foregroundStyle(Color.theme.textGrayColor)
        }
    }
}

#Preview {
    ForgotPasswordLablesView()
}
