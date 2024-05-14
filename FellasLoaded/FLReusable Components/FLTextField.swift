//
//  FLTextField.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct FLTextField: View {
    @Binding var field: String
    var title: String = ""
    var placeHolder: String = ""
    @State var action: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom(Font.regular, size: 11))
                .foregroundStyle(Color.theme.textGrayColor)
            TextField(placeHolder, text: $field)
                .font(.custom(Font.regular, size: 16))
                .foregroundStyle(Color.white)
        }
        .padding(10)
        .frame(height: 48)
        .background(Color.theme.appGrayColor)
        .cornerRadius(10)
    }
}

#Preview {
    FLTextField(field: .constant("Test"))
}
