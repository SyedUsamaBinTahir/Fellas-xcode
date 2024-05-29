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
    @State var action: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $name, title: "Display Name", placeHolder: "") {
                
            }
            
            AuthButtonView(action: {
                action()
            }, title: "CREATE AN ACCOUNT", background: Color.white, foreground: Color.black)
        }
    }
}
