//
//  FLLoader.swift
//  FellasLoaded
//
//  Created by Phebsoft on 27/05/2024.
//

import SwiftUI

struct FLLoader: View {
    @State var animate = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke (AngularGradient(gradient: .init(colors: [Color.theme.appRedColor]),
                                          center: .center), style: StrokeStyle(lineWidth: 6, lineCap:
                                                .square))
                .frame (width: 45, height: 45)
                .rotationEffect (.init(degrees: self.animate ? 360 : 0))
                .animation (Animation.linear (duration:
                                                0.7).repeatForever (autoreverses: false))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black.opacity(0.45))
        .onAppear {
            animate.toggle()
        }
    }
}

#Preview {
    FLLoader()
}
