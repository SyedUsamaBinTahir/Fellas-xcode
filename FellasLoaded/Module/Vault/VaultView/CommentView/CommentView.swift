//
//  CommentView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI
import ExytePopupView

enum CommentsState: Int, CaseIterable {
    case top
    case nowest
    case oldest
    
    var state: String {
        switch self {
        case .top:
            return "most_liked"
        case .nowest:
            return "newest"
        case .oldest:
            return "oldest"
        }
    }
}

struct CommentView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State private var isPinned = true
    @State private var expandDescription = false
    @State private var commentsToggle = false
    @State private var selectedComment = CommentsState(rawValue: 0)
    @State private var showReportComment = false
    @State private var addComment: String = ""
    @State private var redirectReply = false
    @State private var commentid: String = ""
    @State private var likeAdded: Bool = false
    @Binding var dismissSheet: Bool
    @Binding var commentOrder: String
    @Binding var seriesEpisodeDetailId: String
    @Binding var episodeCategoryID: String
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    VStack {
                        CommentsHeaderView(backIcon: .constant(""), title: .constant("Comments"), dismissSheet: $dismissSheet)
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 6) {
                                ForEach(CommentsState.allCases, id: \.rawValue) { type in
                                    Text(type.state.uppercased())
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 10)
                                        .font(.custom(Font.bold, size: 14))
                                        .foregroundStyle(selectedComment == type ? .black : .white)
                                        .background(selectedComment == type ? .white : Color.theme.appGrayColor)
                                        .cornerRadius(5)
                                        .onTapGesture {
                                            selectedComment = type
                                            commentOrder = type.state.description
                                        }
                                }
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    .background(Color.theme.tabbarColor)
                    
                    CommunityGuidlineView()
                    
                    if feedViewModel.showLoader {
                        FLLoader()
                    } else {
                        ScrollView {
                            ForEach(feedViewModel.seriesEpisodesCommentsModel?.results.reversed() ?? [], id: \.uid) { data in
                                CommentCardView(/*isPinned: $isPinned,*/ expandDescription: $expandDescription, showReportComment: $showReportComment, redirectReply: $redirectReply, profileImage: .constant(data.user?.avatar ?? ""), displayName: .constant(data.user?.name ?? ""), commentDuration: .constant(""), comment: .constant(data.comment), likes: .constant(data.like_count), replies: .constant(data.replies_count), likeAdded: $feedViewModel.likeCommentAdded, action: {
                                    commentid = data.uid
                                    redirectReply = true
                                }, addLikeAction: {
                                    feedViewModel.likeCommnet(comment: data.uid)
                                }, deleteLikeAction: {
                                    feedViewModel.deleteLikeComment(comment: data.uid)
                                })
                                .padding(.top, 10)
                            }
                        }
                    }
                    
                    NavigationLink(isActive: $redirectReply) {
                        RepliesView(dismissSheet: $redirectReply, commentData: $commentid, seriesEpisodeDetailId: $seriesEpisodeDetailId, episodeCategoryID: $episodeCategoryID)
                            .environmentObject(feedViewModel)
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        EmptyView()
                    }
                    
                    AddCommentView(addComment: $addComment, loader: $feedViewModel.showButtonLoader) {
                        feedViewModel.showButtonLoader = true
                        feedViewModel.createComment(episode: seriesEpisodeDetailId != "" ? seriesEpisodeDetailId : episodeCategoryID, comment: addComment)
                        addComment = ""
                    }
                    
                }
                .background {
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                }
                .ignoresSafeArea()
                .navigationBarHidden(true)
                .popup(isPresented: $feedViewModel.showAlert) {
                    FLToastAlert(image: .constant(""), message: .constant(feedViewModel.alertMessage))
                } customize: {
                    $0
                        .type(.floater(useSafeAreaInset: true))
                        .position(.top)
                        .animation(.spring())
                        .closeOnTapOutside(true)
                        .backgroundColor(.black.opacity(0.5))
                        .autohideIn(3)
                        .appearFrom(.top)
                }
                .popup(isPresented: $feedViewModel.commentCreated) {
                    FLToastAlert(image: .constant(""), message: .constant("Comment Added"))
                } customize: {
                    $0
                        .type(.floater(useSafeAreaInset: true))
                        .position(.top)
                        .animation(.spring())
                        .closeOnTapOutside(true)
                        .backgroundColor(.black.opacity(0.5))
                        .autohideIn(3)
                        .appearFrom(.top)
                }
            }
        }
    }
}
//
//#Preview {
//    CommentView(dismissSheet: .constant(true))
//}
