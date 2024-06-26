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
    @State private var selectedComment = CommentsState(rawValue: 0)
    @State private var showReportComment = false
    @State private var addComment: String = ""
    @State private var redirectReply = false
    @Binding var dismissSheet: Bool
    
    @Binding var commentData: String
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                CommentsHeaderView(backIcon: .constant("back-icon"), title: .constant("Replies"), dismissSheet: $dismissSheet)
                
                CommunityGuidlineView()
                
                CommentCardView(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
                                                         showReportComment: $showReportComment,
                                                         redirectReply: $redirectReply,
                                                         profileImage: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.user?.avatar ?? ""),
                                                         displayName: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.user?.name ?? ""),
                                                         commentDuration: .constant(""),
                                                         comment: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.comment ?? ""),
                                                         likes: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.like_count ?? 0),
                                                         replies: .constant(feedViewModel.seriesEpisodesCommentsDetailModel?.parent.replies_count ?? 0),
                                                         action: {
                    
                })
                .padding(.top, 10)
            }
            .background(Color.theme.tabbarColor)
            
            ScrollView {
                ForEach(feedViewModel.seriesEpisodesCommentsDetailModel?.replies ?? [], id: \.uid) { reply in
                    CommentCardView(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
                                                             showReportComment: $showReportComment,
                                                             redirectReply: $redirectReply,
                                                             profileImage: .constant(reply.user?.avatar ?? ""),
                                                             displayName: .constant(reply.user?.name ?? ""),
                                                             commentDuration: .constant( ""),
                                                             comment: .constant(reply.comment),
                                                             likes: .constant(reply.like_count),
                                                             replies: .constant(reply.replies_count), action: {
                        
                    })
                }
                .padding(.horizontal, 30)
            }
            
            AddCommentView(addComment: $addComment) { }
            
        }
        .onAppear {
            feedViewModel.showLoader = true
            feedViewModel.getSeriesEpisodesCommentsDetail(id: commentData)
            print("comment detail id --> ", commentData)
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
