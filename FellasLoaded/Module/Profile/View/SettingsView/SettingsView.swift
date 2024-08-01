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
    @State private var redirectEditProfile: Bool = false
    @Binding var userEmail: String
    
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
                            
                            if FLUserJourney.shared.isSubscibedUserLoggedIn ?? false {
                                VStack(spacing: 26) {
                                    SettingsNavigatorView(icon: "profile", title: "Edit Profile", description: nil, forwardIcon: "chevron.right") {redirectEditProfile = true}
                                    SettingsNavigatorView(icon: "account", title: "Account", description: "Subscription renews on Aug 26, 2024  ", forwardIcon: "chevron.right") { redirectAccount = true }
                                    SettingsNavigatorView(icon: "video-player-controls", title: "Video playback", description: nil, forwardIcon: "chevron.right") { redirectvideoPlayback = true }
                                    SettingsNavigatorView(icon: "notifications", title: "Push notifications", description: nil, forwardIcon: "chevron.right") { redirectPushNotifications = true }
                                    SettingsNavigatorView(icon: "terms", title: "Terms & conditions", description: nil, forwardIcon: "chevron.right") { }
                                    SettingsNavigatorView(icon: "privacy-policy", title: "Privacy policy", description: nil, forwardIcon: "chevron.right") { }
                                    SettingsNavigatorView(icon: "logout", title: "log out", description: nil, forwardIcon: "chevron.right") {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            dismissLogout = true
                                        }
                                    }
                                }
                                .padding(.top)
                            } else {
                                MembershipCardView {  }
                                SettingsNavigatorView(icon: "terms", title: "Terms & conditions", description: nil, forwardIcon: "chevron.right") { }
                                    .padding(.top)
                                SettingsNavigatorView(icon: "privacy-policy", title: "Privacy policy", description: nil, forwardIcon: "chevron.right") { }
                                SettingsNavigatorView(icon: "Logout", title: "Exit", description: nil, forwardIcon: "chevron.right") {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        self.viewControllerHolder?.present(style: .overFullScreen) {
                                            WelcomeScreen()
                                        }
                                    }
                                }
                            }
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

            NavigationLink(isActive: $redirectEditProfile) {
                EditProfile().navigationBarBackButtonHidden(true)
            } label: {
                EmptyView()
            }
            
            NavigationLink(isActive: $redirectAccount) {
                AccountView(userEmail: .constant(userEmail)).navigationBarBackButtonHidden(true)
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
    SettingsView(userEmail: .constant(""))
}
