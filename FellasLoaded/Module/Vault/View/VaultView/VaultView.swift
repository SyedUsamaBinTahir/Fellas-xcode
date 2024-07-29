//
//  VaultView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 15/05/2024.
//

import SwiftUI
import Kingfisher

struct VaultView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var expandDescription = false
    @State private var redirectComment = false
    @StateObject var vaultViewModel = VaultViewModel(_dataService: GetServerData.shared)
    @State var postId: String = ""
    var image: String = ""
    @State var likeStatus: Bool = false
    
    var body: some View {
        VStack {
            VaultHeaderView()
            
            ScrollView {
                ForEach(vaultViewModel.vaulPostModel?.results ?? [], id: \.uid) { data in
                    VStack {
                        TabView {
                            ForEach(data.mediaList, id: \.uid) { images in
                                KFImage.init(URL(string: images.image))
                                    .placeholder({ progress in
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.theme.appGrayColor)
                                    })
                                    .loadDiskFileSynchronously()
                                    .cacheMemoryOnly()
                                    .fade(duration: 0.50)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.42)
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: horizontalSizeClass == .regular ? 634 : UIScreen.main.bounds.width, height: horizontalSizeClass == .regular ? 634 : 390)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            VaultDescriptionView( expandDescription: $expandDescription,
                                                  description: .constant(data.text))
                            
                            VaultLikeAndShareButtonView(date: .constant(data.releaseDate),
                                                        likeCount: .constant("\(data.likeCounts)"),
                                                        likeStatus: $likeStatus,
                                                        shareAction: {},
                                                        likeAction: {
                                vaultViewModel.vaultPostLike(postId: data.uid)
                                vaultViewModel.vaultPostDetails()
                                likeStatus = false
                                
                            },
                                                        dislikeAction: {
                                vaultViewModel.vaultPostDislike(postId: data.uid)
                                vaultViewModel.vaultPostDetails()
                                likeStatus = true
                            }
                            )
                            
                            if FLUserJourney.shared.isSubscibedUserLoggedIn ?? false {
                                VaultCommentsCardView(numberOfComments: .constant("\(data.commentCounts)"),
                                                      profileImage: .constant(data.topComment.user.avatar ?? ""),
                                                      comment: .constant(data.topComment.comment))
                                .onTapGesture {
                                    postId = data.uid
                                    redirectComment = true
                                }
                                .sheet(isPresented: $redirectComment, content: {
                                    VaultCommentView(dismissSheet: $redirectComment,
                                                     commentOrder: .constant(""),
                                                     postId: $postId)
                                    .environmentObject(vaultViewModel)
                                })
                            } else {
                                VStack(alignment: .leading) {
                                    HStack {
                                       Text("COMMENTS")
                                            .font(.custom(Font.semiBold, size: 14))
                                            .foregroundStyle(.white)
                                    }
                                    
                                    Button {
                                        
                                    } label: {
                                        HStack {
                                            Image("lock-icon")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 18, height: 18)
                                            Text("BECOME A MEMBER TO UNLOCK")
                                                .font(.custom(Font.bold, size: 16))
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .frame(height: 40)
                                        .background(Color.theme.appGrayColor)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(8)
                                    }
                                }
                                .padding(10)
                                .frame(maxWidth: .infinity)
                                .background(Color.theme.tabbarColor)
                                .cornerRadius(10)
                            }
                            
                        }
                        .padding(horizontalSizeClass == .regular ? 0 : 10)
                    }
                    .frame(width: horizontalSizeClass == .regular ? 634 : nil)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
        .onAppear {
            vaultViewModel.showLoader = true
            vaultViewModel.vaultPostDetails()
        }
    }
}

#Preview {
    VaultView()
}
