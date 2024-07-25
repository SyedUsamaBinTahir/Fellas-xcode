//
//  CommentCardView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI
import Kingfisher

struct CommentCardView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
//    @Binding var isPinned: Bool
    @Binding var expandDescription: Bool
    @State var showReportComment: Bool = false
    @Binding var redirectReply: Bool
    @Binding var profileImage: String
    @Binding var displayName: String
    @Binding var commentDuration: String
    @Binding var comment: String
    @Binding var likes: Int
    @Binding var replies: Int
    @Binding var likeAdded: Bool
    @Binding var commentCreated: Bool
    @State var action: () -> Void
    @State var addLikeAction: () -> Void = {}
    @State var deleteLikeAction: () -> Void = {}
    @State var deleteCommentAction: () -> Void = {}
    @State var editCommentAction: () -> Void = {}
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 10) {
                KFImage.init(URL(string: profileImage))
                    .placeholder({ progress in
                        Circle()
                            .fill(Color.theme.appGrayColor)
                            .frame(width: 24, height: 24, alignment: .center)
                    })
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.50)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 24, height: 24, alignment: .center)
                
                VStack(alignment: .leading, spacing: 10) {
//                    HStack {
//                        if isPinned {
//                            Image("pin-icon")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 18, height: 18)
//                        }
//                        Text("Pinned by Cal")
//                            .font(.custom(Font.regular, size: 14))
//                            .foregroundStyle(Color.theme.textGrayColor)
//                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(displayName)
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.theme.textGrayColor)
                            Image("dot-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 5, height: 18)
                            Text(commentDuration)
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(comment)
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.white)
                                .lineLimit(expandDescription ? nil : 3)
                            Text(expandDescription ? "Show less" : "Read more")
                                .font(.custom(Font.regular, size: 12))
                                .foregroundStyle(Color.theme.textGrayColor)
                                .onTapGesture {
                                    expandDescription.toggle()
                                }
                        }
                    }
                    
                    HStack {
                        // remove like comment ////
                        if !likeAdded {
                            Button (action: addLikeAction) {
                                HStack(spacing: 10) {
                                    Image("like-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                    Text("\(likes)")
                                        .font(.custom(Font.bold, size: 14))
                                        .foregroundStyle(.white)
                                }
                                .padding(10)
                                .background(Color.theme.appGrayColor)
                                .cornerRadius(8)
                            }
                        } else {
                            Button (action: deleteLikeAction) {
                                HStack(spacing: 10) {
                                    Image("like-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                    Text("\(likes)")
                                        .font(.custom(Font.bold, size: 14))
                                        .foregroundStyle(.white)
                                }
                                .padding(10)
                                .background(Color.theme.appGrayColor)
                                .cornerRadius(8)
                            }
                        }

                        Button (action: action) {
                            HStack(spacing: 10) {
                                Image("reply-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                Text(replies > 0 ? "\(replies) REPLIES" : "REPLY")
                                    .font(.custom(Font.bold, size: 14))
                                    .foregroundStyle(.white)
                            }
                            .padding(10)
                            .background(Color.theme.appGrayColor)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, 4)
                
                Spacer()
                
                Image("threedots-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .padding(.top, 5)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showReportComment.toggle()
                        }
                    }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
        .overlay {
            if showReportComment {
                VStack(alignment: .leading, spacing: 0) {
                    Button (action: editCommentAction) {
                        Text("Edit Comment")
                            .padding(14)
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(.white)
                    }
                    Button (action: deleteCommentAction) {
                        Text("Delete Comment")
                            .padding(14)
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(.white)
                    }
                }
                .background(Color.theme.appGrayColor)
                .cornerRadius(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white, lineWidth: 0.6)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    CommentCardView(/*isPinned: .constant(true), */expandDescription: .constant(false), showReportComment: false, redirectReply: .constant(false), profileImage: .constant(""), displayName: .constant(""), commentDuration: .constant(""), comment: .constant(""), likes: .constant(0), replies: .constant(0), likeAdded: .constant(false), commentCreated: .constant(false), action: {}, addLikeAction: {})
}
