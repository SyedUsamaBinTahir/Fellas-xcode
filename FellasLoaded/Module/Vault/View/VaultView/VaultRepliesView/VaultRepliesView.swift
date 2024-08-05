//
//  VaultRepliesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/07/2024.
//

import SwiftUI
import ExytePopupView

struct VaultRepliesView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject var vaultViewModel = VaultViewModel(_dataService: GetServerData.shared)
//    @FocusState var keyboardFocus: Bool
//    @State private var backIcon = ""
//    @State private var isPinned = true
//    @State private var expandDescription = false
//    @State private var commentsToggle = false
//    @State private var showReportComment = false
//    @State private var addComment: String = ""
//    @State private var redirectReply = false
//    @Binding var dismissSheet: Bool
//    @Binding var isRecieved: Bool
//    @Binding var commentData: String
//    @Binding var postId: String
//    @State var outsideTap: Bool = false
    
    var body: some View {
        ZStack {
//            VStack(spacing: 0) {
//                VStack {
//                    CommentsHeaderView(backIcon: .constant("arrow.left"), title: .constant(""), dismissSheet: $dismissSheet)
//                    
//                    CommunityGuidlineView()
//                    
//                    VaultsCommentsCard(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
//                                                                showReportComment: $showReportComment,
//                                                                redirectReply: $redirectReply,
//                                                                profileImage: .constant(vaultViewModel.vaultCommentReplyModel?.parent.user?.avatar ?? ""),
//                                                                displayName: .constant(vaultViewModel.vaultCommentReplyModel?.parent.user?.name ?? ""),
//                                                                commentDuration: .constant(""),
//                                                                comment: .constant(vaultViewModel.vaultCommentReplyModel?.parent.comment ?? ""),
//                                                                likes: .constant(vaultViewModel.vaultCommentReplyModel?.parent.like_count ?? 0),
//                                                                replies: .constant(vaultViewModel.vaultCommentReplyModel?.parent.replies_count ?? 0),
//                                                                isLike: .constant(true),
//                                                                action: {},
//                                                                likeAction: {},
//                                                                dislikeAction: {},
//                                                                commentDeleteAction: .constant {
//                        
//                    },
//                                                                editCommentAction: .constant {
//                        
//                    },
//                                                                reportCommentAction: .constant {
//                        
//                    }, tap: $outsideTap
//                    )
//                    .padding(.top, 10)
//                }
//                .background(Color.theme.appColor)
//                
//                ScrollView {
//                    
//                    ForEach(vaultViewModel.vaultCommentReplyModel?.replies ?? [], id: \.uid) { reply in
//                        VaultsCommentsCard(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
//                                                                    showReportComment: $showReportComment,
//                                                                    redirectReply: $redirectReply,
//                                                                    profileImage: .constant(reply.user?.avatar ?? ""),
//                                                                    displayName: .constant(reply.user?.name ?? ""),
//                                                                    commentDuration: .constant( ""),
//                                                                    comment: .constant(reply.comment),
//                                                                    likes: .constant(reply.like_count),
//                                                                    replies: .constant(reply.replies_count),
//                                                                    isLike: .constant(true),
//                                                                    action: {},
//                                                                    likeAction: {
//                            vaultViewModel.vaultCommentLike(commentId: reply.uid)
//                        },
//                                                                    dislikeAction: {
//                            vaultViewModel.vaultCommentDislike(commentId: reply.uid)
//                        },
//                                                                    commentDeleteAction: .constant {
//                            vaultViewModel.vaultDeleteComment(commentId: reply.uid)
//                        },
//                                                                    editCommentAction: .constant {
//                            
//                        },
//                                                                    reportCommentAction: .constant {
//                            
//                        }, tap: $outsideTap
//                        )
//                    }
//                    .padding(.horizontal, 30)
//                    .animation(.snappy)
//                }
//                
//                AddCommentView(addComment: $addComment, loader: .constant(false), keyboardFocused: $keyboardFocus) {
//                    withAnimation(.snappy) {
//                        vaultViewModel.vaultCreateReply(comment: addComment, post: postId, parent: vaultViewModel.vaultCommentReplyModel?.parent.uid ?? "", reply_to: vaultViewModel.vaultCommentReplyModel?.parent.uid ?? "")
//                        addComment = ""
//                    }
//                }
//            }
//            .popup(isPresented: $vaultViewModel.showAlert) {
//                FLToastAlert(image: .constant(""), message: $vaultViewModel.alertMessage)
//            } customize: {
//                $0
//                    .type(.floater(useSafeAreaInset: true))
//                    .position(.top)
//                    .animation(.spring())
//                    .closeOnTapOutside(true)
//                    .backgroundColor(.black.opacity(0.5))
//                    .autohideIn(3)
//                    .appearFrom(.top)
//            }

        }
        .background(Color.theme.appColor)
        .ignoresSafeArea()
        
//        .onAppear {
//            //            feedViewModel.showLoader = true
//            
//            vaultViewModel.vaultCommentsReply(commentId: commentData)
//            print("vault comment id --->", commentData)
//            
//        }
//        
//        .onReceive(vaultViewModel.$isSuccess) { _ in
//            vaultViewModel.vaultCommentsReply(commentId: commentData)
//        }
//        .onTapGesture {
//            outsideTap = true
//        }
    }
}
