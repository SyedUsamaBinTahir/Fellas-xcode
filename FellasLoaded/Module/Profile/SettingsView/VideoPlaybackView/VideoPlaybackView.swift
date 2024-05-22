//
//  VideoPlaybackView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct VideoPlaybackView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var captionsToggle = false
    @State private var autoplayToggle = false
    @State private var mobileDataToggle = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                SettingsHeaderView(title: .constant("Video Playback"))
                
                VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            if horizontalSizeClass == .regular {
                                Text("Video Playback")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundStyle(Color.white)
                            }
                            
                            VStack(spacing: 26) {
                                SettingsToggleButtonView(icon: nil, title: "Captions", description: "Caption to show on default.", toggle: $captionsToggle)
                                SettingsToggleButtonView(icon: nil, title: "Autoplay next episode", description: "Next episode will play automatically", toggle: $autoplayToggle)
                                SettingsToggleButtonView(icon: nil, title: "Mobile data usage", description: "Access through your mobile network", toggle: $mobileDataToggle)
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
    VideoPlaybackView()
}
