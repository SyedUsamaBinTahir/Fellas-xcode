//
//  SubscribeTerms&ConditionsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 03/06/2024.
//

import SwiftUI

struct SubscribeTermsAndConditionsView: View {
    
    var body: some View {
        Text("By signing up, you agree to our Terms of Service and Privacy Policy.")
             .font(.custom(Font.regular, size: 14))
             .foregroundStyle(Color.white)
    }
}

#Preview {
    SubscribeTermsAndConditionsView()
}
