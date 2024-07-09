//
//  FLButtonLoader.swift
//  FellasLoaded
//
//  Created by Syed Usama on 09/07/2024.
//

import SwiftUI

struct FLButtonLoader: View {
    @State var animate = false
    
    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke (AngularGradient(gradient: .init(colors: [Color.white]),
                                          center: .center), style: StrokeStyle(lineWidth: 2, lineCap:
                                                .square))
                .frame (width: 16, height: 16)
                .rotationEffect (.init(degrees: self.animate ? 360 : 0))
                .animation (Animation.linear (duration:
                                                0.7).repeatForever (autoreverses: false))
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black.opacity(0.45))
        .onAppear {
            animate.toggle()
        }
    }
}

#Preview {
    FLButtonLoader()
}
