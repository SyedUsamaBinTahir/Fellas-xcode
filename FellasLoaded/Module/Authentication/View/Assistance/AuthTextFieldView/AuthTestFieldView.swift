//
//  FLTextField.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct AuthTestFieldView: View {
    @Binding var field: String
    var title: String = ""
    var placeHolder: String = ""
    @State var action: () -> Void = {}
    
    var body: some View {
        ZStack (alignment: .leading) {
            Text(title)
                .foregroundColor(Color.theme.textGrayColor)
                .offset(y: self.field.isEmpty ? 0  : -20)
//                .scaleEffect(self.field.isEmpty ? 1 : 0.9, anchor: .leading)
                .font(.custom(Font.regular, size: 11))
            
            TextField(placeHolder, text: $field)
                .font(.custom(Font.regular, size: 16))
                .foregroundStyle(Color.white)
                .textInputAutocapitalization(.never)
        }
        .padding(.top, self.field.isEmpty ? 0 : 10)
        .animation(.default, value: !field.isEmpty)
        .padding(10)
        .frame(height: 48)
        .background(Color.theme.appGrayColor)
        .cornerRadius(6)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(field.isEmpty ? Color.clear : .white, lineWidth: 2.2)
        )
    }
}


#Preview {
    AuthTestFieldView(field: .constant(""))
}
