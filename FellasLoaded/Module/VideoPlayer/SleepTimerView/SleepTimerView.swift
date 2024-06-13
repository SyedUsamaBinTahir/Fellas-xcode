//
//  SleepTimerView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 12/06/2024.
//

import SwiftUI

struct SleepTimerView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                
                HStack {
                    Text("Sleep timer")
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(Color.white)
                }
                
                HStack {
                    Spacer()

                    Button(action: {
                        
                    }, label: {
                        Image("xmark-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    })
                    
                }
            }
            .padding(.top)
            
            VStack(alignment: .leading ,spacing: 30) {
                Text("5 minutes")
                    .font(.custom(Font.semiBold, size: 16))
                Text("10 minutes")
                    .font(.custom(Font.semiBold, size: 16))
                Text("15 minutes")
                    .font(.custom(Font.semiBold, size: 16))
                Text("30 minutes")
                    .font(.custom(Font.semiBold, size: 16))
                Text("45 minutes")
                    .font(.custom(Font.semiBold, size: 16))
                Text("End of video")
                    .font(.custom(Font.semiBold, size: 16))
            }
            .foregroundStyle(.white)
            
            VStack(spacing: 12) {
                Rectangle()
                    .fill(Color.theme.appGrayColor)
                    .frame(height: 1)
                Text("This selection only applies to the current video")
                    .font(.custom(Font.Medium, size: 12))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            .padding(.top)
        }
        .padding()
        .background(Color.theme.tabbarColor)
        .ignoresSafeArea()
    }
}

#Preview {
    SleepTimerView()
}
