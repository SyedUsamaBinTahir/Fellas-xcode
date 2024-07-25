//
//  RepliesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct RepliesView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var feedViewModel: FeedViewModel
    @State private var backIcon = ""
    @State private var isPinned = true
    @State private var expandDescription = false
    @State private var commentsToggle = false
    @State private var showReportComment = false
    @State private var addComment: String = ""
    @State private var redirectReply = false
    @State private var likeAdded: Bool = false
    @State private var replyLikeAdded: Bool = false
    @Binding var dismissSheet: Bool
    @Binding var commentData: String
    @Binding var seriesEpisodeDetailId: String
    @Binding var episodeCategoryID: String
    @FocusState var keyboardFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                CommentsHeaderView(backIcon: .constant("back-icon"), title: .constant("Replies"), dismissSheet: $dismissSheet)
                
                CommunityGuidlineView()
                
            }
            .background(Color.theme.tabbarColor)
            
            if feedViewModel.showLoader {
                FLLoader()
            } else {
                ScrollView {
                    
                    CommentCardView(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
                                                             redirectReply: $redirectReply,
                                                             profileImage: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.user?.avatar ?? ""),
                                                             displayName: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.user?.name ?? ""),
                                                             commentDuration: .constant(""),
                                                             comment: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.comment ?? ""),
                                                             likes: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.like_count ?? 0),
                                                             replies: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.replies_count ?? 0), likeAdded: $likeAdded,commentCreated: $feedViewModel.commentCreated ,
                                                             action: {
                        
                    })
                    .padding(.top, 10)
                    .background(Color.theme.tabbarColor)
                    
                    ForEach(feedViewModel.seriesEpisodesCommentsDetailModel?.replies?.reversed() ?? [], id: \.uid) { reply in
                        CommentCardView(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
                                                                 redirectReply: $redirectReply,
                                                                 profileImage: .constant(reply.user?.avatar ?? ""),
                                                                 displayName: .constant(reply.user?.name ?? ""),
                                                                 commentDuration: .constant( ""),
                                                                 comment: .constant(reply.comment),
                                                                 likes: .constant(reply.like_count),
                                                                 replies: .constant(reply.replies_count), likeAdded: $replyLikeAdded, commentCreated: $feedViewModel.commentCreated, action: {
                            
                        }, deleteCommentAction: {
                            feedViewModel.deleteComment(commentUid: reply.uid)
                        })
                    }
                    .padding(.horizontal, 30)
                }
            }
            
            AddCommentView(addComment: $addComment, loader: $feedViewModel.showButtonLoader, keyboardFocused: $keyboardFocused) {
                feedViewModel.showButtonLoader = true
                feedViewModel.createReplies(episode: seriesEpisodeDetailId != "" ? seriesEpisodeDetailId : episodeCategoryID, parent: feedViewModel.seriesEpisodesCommentsDetailModel?.parent.uid ?? "", replyTo: feedViewModel.seriesEpisodesCommentsDetailModel?.parent.uid ?? "", comment: addComment)
                addComment = ""
            }
            
        }
        .onReceive(feedViewModel.$commentCreated) { _ in
            feedViewModel.getSeriesEpisodesCommentsDetail(id: commentData)
            print("comment Reply id --> ", commentData)
        }
        .onReceive(feedViewModel.$commentDeleted) { _ in
            feedViewModel.getSeriesEpisodesCommentsDetail(id: commentData)
            print("comment Reply id --> ", commentData)
        }
        .onAppear {
            feedViewModel.showLoader = true
            feedViewModel.getSeriesEpisodesCommentsDetail(id: commentData)
            print("comment Reply id --> ", commentData)
        }
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
        
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

//#Preview {
//    RepliesView(dismissSheet: .constant(false))
//}
