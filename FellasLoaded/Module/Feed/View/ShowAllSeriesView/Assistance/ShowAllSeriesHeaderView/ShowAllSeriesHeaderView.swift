//
//  ShowAllSeriesHeaderView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 22/05/2024.
//

import SwiftUI

struct ShowAllSeriesHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var title: String
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("back-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                })
                
                Spacer()
            }
            
            HStack {
                Text(title)
                    .font(.custom(Font.semiBold, size: 24))
                    .foregroundStyle(Color.white)
            }
        }
        .padding(.top, 30)
    }
}

#Preview {
    ShowAllSeriesHeaderView(title: .constant(""))
}
