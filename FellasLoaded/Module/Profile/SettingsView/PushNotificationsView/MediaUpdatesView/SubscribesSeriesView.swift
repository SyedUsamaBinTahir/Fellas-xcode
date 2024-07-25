//
//  SubscribesSeriesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct SubscribesSeriesView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State var toggle = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                ZStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                                .fontWeight(.medium)
                                .padding(10)
                                .background(Color.theme.appGrayColor)
                                .clipShape(Circle())
                        }).padding(.leading)
                        
                        Spacer()
                    }
                    
                    if horizontalSizeClass != .regular {
                        HStack {
                            Text("Subscribed Series")
                                .font(.custom(Font.semiBold, size: 24))
                                .foregroundStyle(Color.white)
                        }
                    }
                }
                .padding(.top, 50)
                
                VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            if horizontalSizeClass == .regular {
                                Text("Subscribed Series")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundStyle(Color.white)
                            }
                            
                            VStack(spacing: 16) {
                                ForEach(1...5, id: \.self) { _ in
                                    VStack {
                                        HStack(spacing: 20) {
                                            Image("vault-main-image")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 38, height: 48)
                                            Text("Fellas Studios")
                                                .font(.custom(Font.semiBold, size: 16))
                                                .foregroundStyle(Color.white)
                                            Spacer()
                                            Toggle("", isOn: $toggle)
                                                .toggleStyle(SwitchToggleStyle(tint: .red))
                                                .frame(width: 52, height: 32)
                                                .padding(.trailing, 10)
                                        }
                                        
                                        Rectangle()
                                            .fill(Color.theme.appGrayColor.opacity(0.4))
                                            .frame(maxWidth: .infinity, maxHeight: 2)
                                            .padding(.top, 10)
                                    }
                                }
                            }
                            .padding(.top)
                        }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
                
                
                Spacer()
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SubscribesSeriesView()
}
