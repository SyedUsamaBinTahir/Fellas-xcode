//
//  MenbershipCardView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct MembershipCardView: View {
    @State var action: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Gain unlimited access to all our content now!")
                .font(.custom(Font.semiBold, size: 20))
                .foregroundStyle(.white)
            Text("You may cancel at anytime.")
                .font(.custom(Font.regular, size: 14))
                .foregroundStyle(Color.theme.textGrayColor)
            Button (action: action) {
                Text("BECOME A MEMBER")
                    .font(.custom(Font.bold, size: 14))
                    .padding(10)
                    .foregroundStyle(.white)
                    .background(Color.theme.appRedColor)
                    .cornerRadius(10)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.red.opacity(0.2))
        .cornerRadius(10)
        .padding(.top)
    }
}

#Preview {
    MembershipCardView()
}
