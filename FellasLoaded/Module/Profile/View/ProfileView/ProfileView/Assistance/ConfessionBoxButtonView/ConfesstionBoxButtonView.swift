//
//  ConfesstionBoxButtonView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ConfesstionBoxButtonView: View {
    @State var action: () -> Void = {}
    var body: some View {
        Button (action: action) {
            VStack {
                HStack(spacing: 20) {
                    Image("confession-box")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Confession box")
                            .font(.custom(Font.semiBold, size: 16))
                        Text("We’re closed so note it down, and come back when we’re open. We’ll notify you when we’re back up.")
                            .font(.custom(Font.Medium, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                    
                    Image("chevron-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .foregroundStyle(Color.gray)
                
                Rectangle()
                    .fill(Color.theme.appGrayColor.opacity(0.4))
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .padding(.top)
            }
        }
    }
}

#Preview {
    ConfesstionBoxButtonView()
}
