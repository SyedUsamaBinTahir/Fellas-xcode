//
//  SettingsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 14/05/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @State private var email: String = ""
    @State private var redirectAccount = false
    @State private var dismissLogout = false
    @State private var redirectPushNotifications = false
    @State private var redirectvideoPlayback = false
    
    var body: some View {
        VStack {
            VStack(alignment: horizontalSizeClass == .regular ? .center : .leading) {
                SettingsHeaderView(title: .constant("Settings"))
                
                VStack(alignment: .leading) {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 10) {
                            if horizontalSizeClass == .regular {
                                Text("Settings")
                                    .font(.custom(Font.semiBold, size: 24))
                                    .foregroundStyle(Color.white)
                            }
                            
                            VStack(spacing: 26) {
                                SettingsNavigatorView(icon: "profile", title: "Edit Profile", description: nil, forwardIcon: "chevron-icon") { }
                                SettingsNavigatorView(icon: "account", title: "Account", description: "Subscription renews on Aug 26, 2024  ", forwardIcon: "chevron-icon") { redirectAccount = true }
                                SettingsNavigatorView(icon: "video-player-controls", title: "Video playback", description: nil, forwardIcon: "chevron-icon") { redirectvideoPlayback = true }
                                SettingsNavigatorView(icon: "notifications", title: "Push notifications", description: nil, forwardIcon: "chevron-icon") { redirectPushNotifications = true }
                                SettingsNavigatorView(icon: "terms", title: "Terms & conditions", description: nil, forwardIcon: "chevron-icon") { }
                                SettingsNavigatorView(icon: "privacy-policy", title: "Privacy policy", description: nil, forwardIcon: "chevron-icon") { }
                                SettingsNavigatorView(icon: "logout", title: "log out", description: nil, forwardIcon: "chevron-icon") {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        dismissLogout = true
                                    }
                                }
                            }
                            .padding(.top)
                        }
                    }
                }
                .frame(width: horizontalSizeClass == .regular ? 472 : nil)
                .padding(horizontalSizeClass == .regular ? 140 : 20)
                
                Spacer()
            }
            .overlay {
                if dismissLogout {
                    LogOutView(cancelAction: { withAnimation(.easeInOut(duration: 0.2)) { dismissLogout = false } },
                               logoutAction: {
                        FLUserJourney.shared.logoutOccured()
                        self.viewControllerHolder?.present(style: .overFullScreen) {
                            WelcomeScreen()
                        }
                    })
                }
            }
//            .navigationDestination(isPresented: $redirectAccount) {
//                AccountView().navigationBarBackButtonHidden(true)
//            }
//            .navigationDestination(isPresented: $redirectPushNotifications) {
//                PushNotificationsView().navigationBarBackButtonHidden(true)
//            }
//            .navigationDestination(isPresented: $redirectvideoPlayback) {
//                VideoPlaybackView().navigationBarBackButtonHidden(true)
//            }
            
            NavigationLink(isActive: $redirectAccount) {
                AccountView().navigationBarBackButtonHidden(true)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $redirectPushNotifications) {
                PushNotificationsView().navigationBarBackButtonHidden(true)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $redirectvideoPlayback) {
                VideoPlaybackView().navigationBarBackButtonHidden(true)
            } label: {
                EmptyView()
            }

        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SettingsView()
}
