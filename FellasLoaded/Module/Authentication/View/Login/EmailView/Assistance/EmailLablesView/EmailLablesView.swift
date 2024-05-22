//
//  EmailLablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct EmailLablesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if horizontalSizeClass == .regular {
                Image("fellas-loaded-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 226, height: 98, alignment: .center)
            }
            
            Text("Login in with your email?")
                .font(.custom(Font.semiBold, size: 32))
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    EmailLablesView()
}
