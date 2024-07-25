//
//  CommentsHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct CommentsHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var backIcon: String?
    @Binding var title: String
    @Binding var dismissSheet: Bool
    
    var body: some View {
        ZStack {
            if let backIcon = backIcon {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(backIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    })
                    
                    Spacer()
                }
            }
            
            HStack {
                Text(title)
                    .font(.custom(Font.semiBold, size: 24))
                    .foregroundStyle(Color.white)
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    dismissSheet = false
                }, label: {
                    Image("xmark-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                })
            }
        }
        .padding()
    }
}
