//
//  DisplayNameAndImageFieldAndButtonsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct DisplayNameAndImageFieldAndButtonsView: View {
    @Binding var code: String
    @Binding var redirectToSubscribeView: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            AuthTestFieldView(field: $code, title: "Display Name", placeHolder: "") {
                
            }
            
            AuthButtonView(action: {
                redirectToSubscribeView = true
            }, title: "CREATE AN ACCOUNT", background: Color.white, foreground: Color.black)
        }
    }
}
