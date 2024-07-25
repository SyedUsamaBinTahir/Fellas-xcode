//
//  VaultRepliesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/07/2024.
//

import SwiftUI

struct VaultRepliesView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vaultViewModel = VaultViewModel(_dataService: GetServerData.shared)
    @State private var backIcon = ""
    @State private var isPinned = true
    @State private var expandDescription = false
    @State private var commentsToggle = false
    @State private var showReportComment = false
    @State private var addComment: String = ""
    @State private var redirectReply = false
    @Binding var dismissSheet: Bool
    @Binding var isRecieved: Bool
    @Binding var commentData: String
    @Binding var postId: String
    @FocusState var keyboardFocused: Bool

    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                CommentsHeaderView(backIcon: .constant("arrow.left"), title: .constant(""), dismissSheet: $dismissSheet)
                
                CommunityGuidlineView()
                
                
//                if isRecieved {
                    VaultsCommentsCard(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
                                                             showReportComment: $showReportComment,
                                                             redirectReply: $redirectReply,
                                                             profileImage: .constant(vaultViewModel.vaultCommentReplyModel?.parent.user?.avatar ?? ""),
                                                             displayName: .constant(vaultViewModel.vaultCommentReplyModel?.parent.user?.name ?? ""),
                                                             commentDuration: .constant(""),
                                                             comment: .constant(vaultViewModel.vaultCommentReplyModel?.parent.comment ?? ""),
                                                             likes: .constant(vaultViewModel.vaultCommentReplyModel?.parent.like_count ?? 0),
                                                             replies: .constant(vaultViewModel.vaultCommentReplyModel?.parent.replies_count ?? 0),
                                                             isLike: .constant(true),
                                                             action: {},
                                                             likeAction: {},
                                                             dislikeAction: {}
                    )
                    .padding(.top, 10)
                    
//                }else {
//                    VaultsCommentsCard(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
//                                                             showReportComment: $showReportComment,
//                                                             redirectReply: $redirectReply,
//                                                             profileImage: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.user?.avatar ?? ""),
//                                                             displayName: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.user?.name ?? ""),
//                                                             commentDuration: .constant(""),
//                                                             comment: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.comment ?? ""),
//                                                             likes: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.like_count ?? 0),
//                                                             replies: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.replies_count ?? 0),
//                                                             isLike: .constant(true),
//                                                             action: {},
//                                                             likeAction: {},
//                                                             dislikeAction: {}
//                    )
//                    .padding(.top, 10)
                    
//                }
            }
            .background(Color.theme.appColor)
            
            ScrollView {
                
//                if isRecieved {
                    ForEach(vaultViewModel.vaultCommentReplyModel?.replies ?? [], id: \.uid) { reply in
                        VaultsCommentsCard(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
                                                                 showReportComment: $showReportComment,
                                                                 redirectReply: $redirectReply,
                                                                 profileImage: .constant(reply.user?.avatar ?? ""),
                                                                 displayName: .constant(reply.user?.name ?? ""),
                                                                 commentDuration: .constant( ""),
                                                                 comment: .constant(reply.comment),
                                                                 likes: .constant(reply.like_count),
                                                                 replies: .constant(reply.replies_count),
                                                                 isLike: .constant(true),
                                                                 action: {},
                                                                 likeAction: {
                            vaultViewModel.vaultCommentLike(commentId: reply.uid)
                        },
                                                                 dislikeAction: {
                            vaultViewModel.vaultCommentDislike(commentId: reply.uid)
                        })
                    }
                    .padding(.horizontal, 30)
//                }else {
//                    ForEach(feedViewModel.seriesEpisodesCommentsDetailModel?.replies ?? [], id: \.uid) { reply in
//                        VaultsCommentsCard(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
//                                                                 showReportComment: $showReportComment,
//                                                                 redirectReply: $redirectReply,
//                                                                 profileImage: .constant(reply.user?.avatar ?? ""),
//                                                                 displayName: .constant(reply.user?.name ?? ""),
//                                                                 commentDuration: .constant( ""),
//                                                                 comment: .constant(reply.comment),
//                                                                 likes: .constant(reply.like_count),
//                                                                 replies: .constant(reply.replies_count),
//                                                                 isLike: .constant(true),
//                                                                 action: {},
//                                                                 likeAction: {},
//                                                                 dislikeAction: {}
//                        )
//                    }
//                    .padding(.horizontal, 30)
//                }
            }
            
            AddCommentView(addComment: $addComment, loader: .constant(false), keyboardFocused: $keyboardFocused) {
                vaultViewModel.vaultCreateReply(comment: addComment, post: postId, parent: vaultViewModel.vaultCommentReplyModel?.parent.uid ?? "", reply_to: vaultViewModel.vaultCommentReplyModel?.parent.uid ?? "")
                addComment = ""
            }
            
        }
        .background(Color.theme.appColor)
        .ignoresSafeArea()
        
        .onAppear {
//            feedViewModel.showLoader = true
//            print("STATUS ----> \(isRecieved)")
//            if isRecieved {
                vaultViewModel.vaultCommentsReply(commentId: commentData)
                print("vault comment id --->", commentData)
//            }else {
//                feedViewModel.getSeriesEpisodesCommentsDetail(id: commentData)
//                print("feed comment detail id --> ", commentData)
//            }
        }
        .onReceive(vaultViewModel.$replyAdded) { _ in
//            if isRecieved {
                vaultViewModel.vaultCommentsReply(commentId: commentData)
//            }
        }
        
    }
}
