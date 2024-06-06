//
//  SubscribeDiscountLableView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 03/06/2024.
//

import SwiftUI

struct SubscribeDiscountLableView: View {
    
    var body: some View {
        Text("12 Months at £5.83/month. Save over 15% with an annual subscription.")
            .font(.custom(Font.regular, size: 14))
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.theme.textGrayColor)
    }
}
