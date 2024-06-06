//
//  SubscribeFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct SubscribeFieldAndButtonView: View {
    @State var monthlyPrice: String
    @State var action: () -> Void
    
    var body: some View {
        AuthButtonView(action: {
            action()
        }, title: monthlyPrice, background: Color.white, foreground: Color.black)
    }
}
