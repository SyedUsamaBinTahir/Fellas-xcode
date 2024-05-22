//
//  ResetPasswordHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ResetPasswordHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("back-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                }).padding(.leading)
                
                Spacer()
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    ResetPasswordHeaderView()
}
