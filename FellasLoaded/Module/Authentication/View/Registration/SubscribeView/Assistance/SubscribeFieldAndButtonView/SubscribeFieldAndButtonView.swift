//
//  SubscribeFieldAndButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct SubscribeFieldAndButtonView: View {
    var body: some View {
        VStack(spacing: 20) {
            AuthButtonView(action: {
            }, title: "£6.99 / MONTH", background: Color.white, foreground: Color.black)
            
            AuthButtonView(action: {
            }, title: "£69.99 / year", background: Color.white, foreground: Color.black)
            
            Text("12 Months at £5.83/month. Save over 15% with an annual subscription.")
                .font(.custom(Font.regular, size: 14))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.theme.textGrayColor)
        }
    }
}

#Preview {
    SubscribeFieldAndButtonView()
}
