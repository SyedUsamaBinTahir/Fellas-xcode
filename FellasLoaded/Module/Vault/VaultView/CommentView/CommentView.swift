//
//  CommentView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

enum CommentsState: Int, CaseIterable {
    case top
    case nowest
    case oldest
    
    var state: String {
        switch self {
        case .top:
            return "TOP"
        case .nowest:
            return "NEWEST"
        case .oldest:
            return "OLDEST"
        }
    }
}

struct CommentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPinned = true
    @State private var expandDescription = false
    @State private var commentsToggle = false
    @State private var selectedComment = CommentsState(rawValue: 0)
    @State private var showReportComment = false
    @State private var addComment: String = ""
    @State private var redirectReply = false
    @Binding var dismissSheet: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    CommentsHeaderView(backIcon: .constant(""), title: .constant("Comments"), dismissSheet: $dismissSheet)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 6) {
                            ForEach(CommentsState.allCases, id: \.rawValue) { type in
                                Text(type.state)
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .font(.custom(Font.bold, size: 14))
                                    .foregroundStyle(selectedComment == type ? .black : .white)
                                    .background(selectedComment == type ? .white : Color.theme.appGrayColor)
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        selectedComment = type
                                    }
                            }
                            Spacer()
                        }
                    }
                    .padding()
                }
                .background(Color.theme.tabbarColor)
                
                CommunityGuidlineView()
                
                ScrollView {
                    CommentCardView(isPinned: $isPinned, expandDescription: $expandDescription, showReportComment: $showReportComment, redirectReply: $redirectReply)
                }
                
                AddCommentView(addComment: $addComment) {}
                
            }
            .background {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        }
    }
}

#Preview {
    CommentView(dismissSheet: .constant(true))
}
