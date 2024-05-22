//
//  RepliesView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct RepliesView: View {
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
        VStack(spacing: 0) {
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image("back-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        })
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("Replies")
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
                
                CommentCardView(isPinned: $isPinned, expandDescription: $expandDescription, showReportComment: $showReportComment, redirectReply: $redirectReply)
            }
            .background(Color.theme.tabbarColor)
            
            ScrollView {
                CommentCardView(isPinned: $isPinned, expandDescription: $expandDescription, showReportComment: $showReportComment, redirectReply: $redirectReply)
                    .padding(.horizontal, 30)
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

#Preview {
    RepliesView(dismissSheet: .constant(false))
}
