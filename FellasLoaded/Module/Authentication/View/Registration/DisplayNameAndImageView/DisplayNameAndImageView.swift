//
//  DisplayNameAndImageView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct DisplayNameAndImageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var code: String = ""
    @State private var redirectToSubscribeView = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                AuthHeaderView(step: .constant("STEP 4 OF 5"))
                
                VStack(alignment: .center, spacing: 30) {
                    
                    DisplayNameAndImageLablesView()
                    
                    DisplayNameAndImageImageView(name: .constant("default-profile-icon"))
                    
                    DisplayNameAndImageFieldAndButtonsView(code: $code, redirectToSubscribeView: $redirectToSubscribeView)
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                .navigationDestination(isPresented: $redirectToSubscribeView) {
                    SubscribeView()
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
    DisplayNameAndImageView()
}
