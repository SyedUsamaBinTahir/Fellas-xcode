//
//  LogOutView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct LogOutView: View {
    @State var cancelAction: () -> Void = {}
    @State var logoutAction: () -> Void = {}
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Log Out")
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(Color.white)
                    
                    Text("Are you sure you want to log out?")
                        .font(.custom(Font.Medium, size: 14))
                        .foregroundColor(Color.theme.textGrayColor)
                }
                
                HStack(spacing: 18) {
                    Button (action: cancelAction) {
                        Text("CANCEL")
                            .font(.custom(Font.bold, size: 16))
                            .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                            .foregroundStyle(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.theme.textGrayColor, lineWidth: 1)
                            }
                    }
                    
                    Button (action: logoutAction) {
                        Text("LOG OUT")
                            .font(.custom(Font.bold, size: 16))
                            .frame(maxWidth: .infinity, maxHeight: 48, alignment: .center)
                            .background(Color.white)
                            .foregroundStyle(Color.black)
                            .cornerRadius(10)
                    }

                }
            }
            .padding()
            .background(Color.theme.appGrayColor)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.theme.textGrayColor, lineWidth: 0.2)
            }
            .padding()
            
            
            Spacer()
        }
        .background(Color.black.shadow(radius: 5).opacity(0.6))
        .ignoresSafeArea()
    }
}

#Preview {
    LogOutView()
}
