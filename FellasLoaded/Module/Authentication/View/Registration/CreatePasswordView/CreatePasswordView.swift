//
//  CreatePasswordView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var password: String = ""
    @State private var retypePassword: String = ""
    @State private var redirectToCheckEmailView = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                AuthHeaderView(step: .constant("STEP 2 OF 5"))
                
                VStack(alignment: .leading) {
                    
                    CreatePasswordLablesView()
                    
                    CreatePasswordFieldsAndButtonView(password: $password, retypePassword: $retypePassword, redirectToCheckEmailView: $redirectToCheckEmailView)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToCheckEmailView) {
                    CheckEmailView().navigationBarBackButtonHidden(true)
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
    CreatePasswordView()
}
