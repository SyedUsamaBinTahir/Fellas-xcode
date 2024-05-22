//
//  CheckEmailView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct CheckEmailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var code: String = ""
    @State private var redirectToDisplayNameAndImageView = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                AuthHeaderView(step: .constant("STEP 3 OF 5"))
                
                VStack(alignment: .leading) {
                    
                    CheckEmailLablesView()
                    
                    CheckEmailFieldAndButtonView(code: $code, redirectToDisplayNameAndImageView: $redirectToDisplayNameAndImageView)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToDisplayNameAndImageView) {
                    DisplayNameAndImageView()
                        .navigationBarBackButtonHidden(true)
                }
                
                Spacer()
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CheckEmailView()
}
