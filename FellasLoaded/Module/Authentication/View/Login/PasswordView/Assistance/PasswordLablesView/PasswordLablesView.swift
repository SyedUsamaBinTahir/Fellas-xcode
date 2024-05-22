//
//  PasswordlablesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct PasswordLablesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if horizontalSizeClass == .regular {
                Image("fellas-loaded-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 226, height: 98)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 36)
            }
            
            Text("Enter you password")
                .font(.custom(Font.semiBold, size: 32))
                .foregroundStyle(Color.white)
        }
    }
}
