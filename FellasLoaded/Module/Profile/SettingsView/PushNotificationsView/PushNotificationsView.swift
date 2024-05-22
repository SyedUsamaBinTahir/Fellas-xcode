//
//  PushNotificationsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

struct PushNotificationsView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @State private var confessionBoxToggle = false
    @State private var appUpdateToggle = false
    @State private var redirectMediaUpdates = false
    @State private var redirectInteraction = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                SettingsHeaderView(title: .constant("Push Notifications"))
                
                VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 10) {
                            if horizontalSizeClass == .regular {
                                Text("Push Notifications")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundStyle(Color.white)
                            }
                            
                            VStack(spacing: 26) {
                                SettingsNavigatorView(icon: nil, title: "Media upates", description: "Content related notifications", forwardIcon: "chevron-icon") { redirectMediaUpdates = true }
                                SettingsNavigatorView(icon: nil, title: "Interactions", description: "Content related notifications", forwardIcon: "chevron-icon") { redirectInteraction  = true }
                                SettingsToggleButtonView(icon: nil, title: "Confession box", description: "Notify me when the confession box is opened.", toggle: $confessionBoxToggle)
                                SettingsToggleButtonView(icon: nil, title: "App updates", description: "Notify me when a new app updates is released.", toggle: $appUpdateToggle)
                            }
                            .padding(.top)
                        }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
                Spacer()
            }
            .navigationDestination(isPresented: $redirectMediaUpdates) {
                MediaUpdatesView().navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $redirectInteraction) {
                InteractionsView().navigationBarBackButtonHidden(true)
            }
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    PushNotificationsView()
}
