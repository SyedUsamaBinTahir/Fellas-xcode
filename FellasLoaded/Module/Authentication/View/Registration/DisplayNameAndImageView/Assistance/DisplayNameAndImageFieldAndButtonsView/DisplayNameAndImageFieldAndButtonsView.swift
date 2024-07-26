//
//  DisplayNameAndImageFieldAndButtonsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct DisplayNameAndImageFieldAndButtonsView: View {
    @Binding var name: String
    @Binding var redirectToSubscribeView: Bool
    @Binding var showButtonLoader: Bool
    @State var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $name, title: "Display Name", placeHolder: "") {
                
            }
            
            if showButtonLoader {
                FLButtonLoader(color: .constant(Color.theme.textGrayColor))
                    .font(.custom(Font.bold, size: 16))
                    .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .cornerRadius(10)
            } else {
                AuthButtonView(action: {
                    action()
                }, title: "CREATE AN ACCOUNT", background: Color.white, foreground: Color.black)
            }
        }
    }
}
