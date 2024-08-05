//
//  VaultsCommentsCard.swift
//  FellasLoaded
//
//  Created by Phebsoft on 24/07/2024.
//


import SwiftUI
import Kingfisher

struct VaultsCommentsCard: View {
//    @Binding var isPinned: Bool
    @Binding var expandDescription: Bool
    @Binding var showReportComment: Bool
    @Binding var redirectReply: Bool
    @State private var profileImage: String = ""
    @State private var displayName: String = ""
    @State private var commentDuration: String = ""
    @State private var comment: String = ""
    @State private var likes: Int = 0
    @State private var replies: Int = 0
    @State private var likeAdded: Bool = false
    @State var action: () -> Void
    @State var likeAction: () -> Void
    @State var dislikeAction: () -> Void
    @State var selection1: String? = nil
    @Binding var commentDeleteAction: () -> Void
    @Binding var editCommentAction: () -> Void
    @Binding var reportCommentAction: () -> Void
    @Binding var tap: Bool

    init(expandDescription: Binding<Bool>,
         showReportComment: Binding<Bool>,
         redirectReply: Binding<Bool>,
         profileImage: String,
         displayName: String,
         commentDuration: String,
         comment: String,
         likes: Int,
         replies: Int,
         likeAdded: Bool,
         action: (() -> Void)? = nil,
         likeAction: (() -> Void)? = nil,
         dislikeAction: (() -> Void)? = nil,
         selection1: String? = nil,
         commentDeleteAction: Binding<() -> Void>,
         editCommentAction: Binding<() -> Void>,
         reportCommentAction: Binding<() -> Void>,
         tap: Binding<Bool>) {
        self._expandDescription = expandDescription
        self._showReportComment = showReportComment
        self._redirectReply = redirectReply
        self.profileImage = profileImage
        self.displayName = displayName
        self.commentDuration = commentDuration
        self.comment = comment
        self.likes = likes
        self.replies = replies
        self.likeAdded = likeAdded
        self.action = action ?? {}
        self.likeAction = likeAction ?? {}
        self.dislikeAction = dislikeAction ?? {}
        self.selection1 = selection1
        self._commentDeleteAction = commentDeleteAction
        self._editCommentAction = editCommentAction
        self._reportCommentAction = reportCommentAction
        self._tap = tap
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
                        Button(action: {
                            if !likeAdded {
                                likes += 1
                                likeAction()
                            } else {
                                likes -= 1
                                dislikeAction()
                            }
                            likeAdded.toggle()
                        }) {
                            HStack(spacing: 10) {
                                Image(likeAdded ? "like-added-icon" : "like-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.white)
                                Text("\(likes)")
                                    .font(.custom(Font.bold, size: 14))
                                    .foregroundStyle(.white)
                            }
                            .padding(8)
                            .background(Color.theme.appGrayColor)
                            .cornerRadius(8)
                        }
                        

                        Button (action: action ) {
                            HStack(spacing: 10) {
                                Image("reply-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                Text(replies > 0 ? "\(replies) REPLIES" : "REPLY")
                                    .font(.custom(Font.bold, size: 14))
                                    .foregroundStyle(.white)
                            }
                            .padding(8)
                            .background(Color.theme.appGrayColor)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, 4)
                
                Spacer()
                
                DropDownPicker(selection: $selection1, 
                               deleteAction: .constant {
                    commentDeleteAction()
                },
                               editAction: .constant {
                    editCommentAction()
                },
                               report: .constant {
                    reportCommentAction()
                }, outSideTap: $tap
                )
                
//                Button {
//                    withAnimation{
//                        showReportComment.toggle()
//                    }
//                } label: {
//                    Image("threedots-icon")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 16, height: 16)
//                        .padding(.top, 5)
//                }
//                .overlay(alignment: .bottom) {
//                    if showReportComment {
//                        Button {
//                            
//                        } label: {
//                            Text("Report Comment")
//                                .padding(14)
//                                .font(.custom(Font.regular, size: 14))
//                                .foregroundStyle(.white)
//                                .background(Color.theme.appGrayColor)
//                                .cornerRadius(5)
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 5)
//                                        .stroke(Color.white, lineWidth: 0.6)
//                                }
//                                .frame(maxWidth: .infinity, alignment: .trailing)
//                                .padding()
//                                .padding(.bottom, 40)
//                        }
//                    }
//                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
    }
}

//#Preview {
//    VaultsCommentsCard(/*isPinned: .constant(true), */expandDescription: .constant(false), showReportComment: .constant(false), redirectReply: .constant(false), profileImage: .constant(""), displayName: .constant(""), commentDuration: .constant(""), comment: .constant(""), likes: .constant(0), replies: .constant(0), isLike: .constant(true), action: {}, likeAction: {}, dislikeAction: {})
//}
