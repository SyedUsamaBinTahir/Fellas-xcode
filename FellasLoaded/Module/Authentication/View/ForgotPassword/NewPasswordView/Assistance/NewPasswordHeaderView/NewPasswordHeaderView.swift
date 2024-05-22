//
//  NewPasswordHeaderView\.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct NewPasswordHeaderView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
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
        
        if horizontalSizeClass != .regular {
            Rectangle()
                .fill(Color.theme.appGrayColor.opacity(0.6))
                .frame(maxWidth: .infinity, maxHeight: 2)
        }
    }
}
