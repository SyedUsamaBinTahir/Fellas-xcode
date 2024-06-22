//
//  RepliesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct RepliesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var backIcon = ""
    @State private var isPinned = true
    @State private var expandDescription = false
    @State private var commentsToggle = false
    @State private var selectedComment = CommentsState(rawValue: 0)
    @State private var showReportComment = false
    @State private var addComment: String = ""
    @State private var redirectReply = false
    @Binding var dismissSheet: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                CommentsHeaderView(backIcon: .constant("back-icon"), title: .constant("Replies"), dismissSheet: $dismissSheet)
                
                CommunityGuidlineView()
                
//                CommentCardView(isPinned: $isPinned, expandDescription: $expandDescription, showReportComment: $showReportComment, redirectReply: $redirectReply)
            }
            .background(Color.theme.tabbarColor)
            
            ScrollView {
//                CommentCardView(isPinned: $isPinned, expandDescription: $expandDescription, showReportComment: $showReportComment, redirectReply: $redirectReply)
//                    .padding(.horizontal, 30)
            }
            
            AddCommentView(addComment: $addComment) { }
            
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    RepliesView(dismissSheet: .constant(false))
}
