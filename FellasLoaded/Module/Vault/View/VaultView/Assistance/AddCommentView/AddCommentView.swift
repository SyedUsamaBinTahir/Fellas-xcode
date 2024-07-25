//
//  AddCommentView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct AddCommentView: View {
    @Binding var addComment: String
    @Binding var loader: Bool
    @FocusState.Binding var keyboardFocused: Bool
    @State var action: () -> Void
    
    var body: some View {
        HStack {
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
                TextField("Add a comment", text: $addComment)
                    .font(.custom(Font.regular, size: 16))
                    .padding(5)
                    .background(Color.theme.appGrayColor)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .focused($keyboardFocused)
            
            Button(action: {
//                keyboardFocused.toggle()
                action()
            }) {
                if loader {
                    ZStack {
                        FLButtonLoader()
                    }
                    .padding(10)
                    .background(Color.theme.appGrayColor)
                    .clipShape(.circle)
                    .frame(width: 40, height: 40)
                } else {
                    Image("send-comment-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
            }
        }
        .padding()
        .background(Color.theme.tabbarColor)
        .padding(.bottom)
    }
}
