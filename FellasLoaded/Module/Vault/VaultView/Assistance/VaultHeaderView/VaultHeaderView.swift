//
//  VaultHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct VaultHeaderView: View {
    var body: some View {
        Text("Vault")
            .font(.custom(Font.semiBold, size: 24))
            .foregroundStyle(Color.white)
            .padding(.top, 60)
    }
}

#Preview {
    VaultHeaderView()
}
