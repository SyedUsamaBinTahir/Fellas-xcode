//
//  EmailHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct EmailHeaderView: View {
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
            
            if horizontalSizeClass != .regular {
                Image("fellas-loaded-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 144, height: 62, alignment: .center)
            }
        }
        .padding(.top, 50)
    }
}

#Preview {
    EmailHeaderView()
}
