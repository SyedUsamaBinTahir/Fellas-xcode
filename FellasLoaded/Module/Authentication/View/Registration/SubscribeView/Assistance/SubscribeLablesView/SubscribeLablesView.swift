//
//  SubscribeLablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct SubscribeLablesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if horizontalSizeClass == .regular {
                Text("STEP 5 OF 5")
                    .font(.custom(Font.semiBold, size: 16))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            
            Image("app-image")
                .resizable()
                .scaledToFill()
                .frame(width: 358, height: 152)
            
            Text("Gain unlimited access to all our content now")
                .font(.custom(Font.semiBold, size: 24))
                .foregroundStyle(Color.white)
            
            Text("You may cancel at anytime.")
                .font(.custom(Font.regular, size: 16))
                .foregroundStyle(Color.theme.textGrayColor)
        }
        
        Text("By signing up, you agree to our Terms of Service and Privacy Policy.")
             .font(.custom(Font.regular, size: 14))
             .foregroundStyle(Color.white)
    }
}

#Preview {
    SubscribeLablesView()
}
