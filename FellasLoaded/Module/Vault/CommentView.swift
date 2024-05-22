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
        NavigationStack {
            VStack(spacing: 0) {
                VStack {
                    ZStack {
                        HStack {
                            Text("Comments")
                                .font(.custom(Font.semiBold, size: 24))
                                .foregroundStyle(Color.white)
                        }
                        
                        HStack {
                            Spacer()

                            Button(action: {
                                dismissSheet = false
                            }, label: {
                                Image("xmark-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 32, height: 32)
                            })
                        }
                    }
                    .padding()
                    
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
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Remember to keep comments respectful and to follow our")
                        .font(.custom(Font.regular, size: 12))
                    Text("Community Guidelines")
                        .font(.custom(Font.semiBold, size: 12))
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.theme.appGrayColor)
                .foregroundColor(.white)
                
                ScrollView {
                    CommentCardView(isPinned: $isPinned, expandDescription: $expandDescription, showReportComment: $showReportComment, redirectReply: $redirectReply)
                }
                
                HStack {
                    Image("profile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                        TextField("Add a comment", text: $addComment)
                            .font(.custom(Font.regular, size: 16))
                            .padding(5)
                            .background(Color.theme.appGrayColor)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    
                    Image("send-comment-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                .padding()
                .background(Color.theme.tabbarColor)
                .padding(.bottom)
                
            }
            .background {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        .ignoresSafeArea()
        }
    }
}

#Preview {
    CommentView(dismissSheet: .constant(true))
}
