//
//  CommentCardView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI
import Kingfisher

struct CommentCardView: View {
    //    @Binding var isPinned: Bool
    @Binding var expandDescription: Bool
    @State var showReportComment: Bool = false
    @Binding var redirectReply: Bool
    @State private var profileImage: String = ""
    @State private var displayName: String = ""
    @State private var commentDuration: String = ""
    @State private var comment: String = ""
    @State private var likes: Int = 0
    @State private var replies: Int = 0
    @State private var likeAdded: Bool = false
    var seriesImage: String = ""
    var action: () -> Void
    var addLikeAction: () -> Void
    var deleteLikeAction: () -> Void
    var deleteCommentAction: () -> Void
    var editCommentAction: () -> Void
    
    init(expandDescription: Binding<Bool>,
         redirectReply: Binding<Bool>,
         profileImage: String,
         displayName: String,
         commentDuration: String,
         comment: String,
         likes: Int,
         replies: Int,
         likeAdded: Bool,
         seriesImage: String = "",
         action: (() -> Void)? = nil,
         addLikeAction: (() -> Void)? = nil,
         deleteLikeAction: (() -> Void)? = nil,
         deleteCommentAction: (() -> Void)? = nil,
         editCommentAction: (() -> Void)? = nil) {
        self._expandDescription = expandDescription
        self._redirectReply = redirectReply
        self.profileImage = profileImage
        self.displayName = displayName
        self.commentDuration = commentDuration
        self.comment = comment
        self.likes = likes
        self.replies = replies
        self.likeAdded = likeAdded
        self.seriesImage = seriesImage
        self.action = action ?? {}
        self.addLikeAction = addLikeAction ?? {}
        self.deleteLikeAction = deleteLikeAction ?? {}
        self.deleteCommentAction = deleteCommentAction ?? {}
        self.editCommentAction = editCommentAction ?? {}
    }
    
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
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(displayName)
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.theme.textGrayColor)
                            KFImage.init(URL(string: seriesImage))
                                .placeholder({ _ in
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.theme.appCardsColor)
                                })
                                .loadDiskFileSynchronously()
                                .cacheMemoryOnly()
                                .fade(duration: 0.50)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 8, height: 18)
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
                        Button (action: {
                            if !likeAdded {
                                likes += 1
                                addLikeAction()
                            } else {
                                likes -= 1
                                deleteLikeAction()
                            }
                            likeAdded.toggle()
                        }) {
                            HStack(spacing: 10) {
                                Image(likeAdded ? "like-added-icon" : "like-icon")
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
//                                        Text("Edit Comment")
//                                            .padding(14)
//                                            .font(.custom(Font.regular, size: 14))
//                                            .foregroundStyle(.white)
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

//#Preview {
//    CommentCardView(/*isPinned: .constant(true), */expandDescription: .constant(false), redirectReply: .constant(false), profileImage: .constant(""), displayName: .constant(""), commentDuration: .constant(""), comment: .constant(""), likes: .constant(0), replies: .constant(0), likeAdded: .constant(false), action: {}, addLikeAction: {})
//}
