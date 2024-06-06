//
//  SearchTextFieldView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct SearchTextFieldView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var search: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image("search-back-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
            }
            
            HStack(spacing: 10) {
                Image("search-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 10)
                TextField("Search", text: $search)
                    .font(.custom(Font.regular, size: 16))
                    .foregroundColor(.white)
            }
            .padding(5)
            .background(Color.theme.appGrayColor)
            .cornerRadius(5)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white, lineWidth: isSearching ? 1 : 0)
            }
            .onTapGesture {
                isSearching.toggle()
            }
        }
        .padding(.top, 40)
    }
}
