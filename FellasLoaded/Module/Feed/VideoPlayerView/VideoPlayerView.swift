//
//  VideoPlayerView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct VideoPlayerView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            VideoPlayer(size: size, safeArea: safeArea)
                .ignoresSafeArea()
            
        }
    }
}

#Preview {
    VideoPlayerView()
}
