

//
//  CommentView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI
import ExytePopupView

enum VaultCommentsState: Int, CaseIterable {
    case top
    case nowest
    case oldest
    
    var state: String {
        switch self {
        case .top:
            return "most_liked"
        case .nowest:
            return "newest"
        case .oldest:
            return "oldest"
        }
    }
}

struct VaultCommentView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vaultViewModel: VaultViewModel
    @State private var isPinned = true
    @State private var expandDescription = false
    @State private var commentsToggle = false
    @State private var selectedComment = CommentsState(rawValue: 0)
    @State private var showReportComment = false
    @State private var addComment: String = ""
    @State private var redirectReply = false
    @State private var commentid: String = ""
    @Binding var dismissSheet: Bool
    @Binding var commentOrder: String
    @State var isRecieved: Bool = false
    @Binding var postId: String
    @State var isLike: Bool = false
    @FocusState var keyboardFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    CommentsHeaderView(backIcon: .constant("multiply"), title: .constant("Comments"), dismissSheet: $dismissSheet)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 6) {
                            ForEach(CommentsState.allCases, id: \.rawValue) { type in
                                Text(type.state.uppercased())
                                    .padding(.vertical, 5)
                                    .padding(.horizontal, 10)
                                    .font(.custom(Font.bold, size: 14))
                                    .foregroundStyle(selectedComment == type ? .black : .white)
                                    .background(selectedComment == type ? .white : Color.theme.appGrayColor)
                                    .cornerRadius(5)
                                    .onTapGesture {
                                        selectedComment = type
                                        commentOrder = type.state.description
                                    }
                            }
                            Spacer()
                        }
                    }
                    .padding()
                }
                .background(Color.theme.tabbarColor)
                
                CommunityGuidlineView()
                
                //                if feedViewModel.showLoader || vaultViewModel.showLoader {
                //                    FLLoader()
                //                } else {
                ScrollView {
                    //                    if vaultViewModel.isRecieved {
                    ForEach(vaultViewModel.vaultCommentsModel?.results?.reversed() ?? [], id: \.uid) { data in
                        VaultsCommentsCard(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
                                                                    showReportComment: $showReportComment,
                                                                    redirectReply: $redirectReply,
                                                                    profileImage: .constant(data.user?.avatar ?? ""),
                                                                    displayName: .constant(data.user?.name ?? ""),
                                                                    commentDuration: .constant(""),
                                                                    comment: .constant(data.comment),
                                                                    likes: .constant(data.like_count),
                                                                    replies: .constant(data.replies_count),
                                                                    isLike: $isLike,
                                                                    action: {
                            commentid = data.uid
                            redirectReply = true
                        },
                                                                    likeAction: {
                            vaultViewModel.vaultCommentLike(commentId: data.uid)
                            isLike.toggle()
                        },
                                                                    dislikeAction:  {
                            vaultViewModel.vaultCommentDislike(commentId: data.uid)
                        })
                        .padding(.top, 10)
                    }
                    //                    } else {
                    //                        ForEach(feedViewModel.seriesEpisodesCommentsModel?.results.reversed() ?? [], id: \.uid) { data in
                    //                            VaultsCommentsCard(/*isPinned: $isPinned,*/ expandDescription: $expandDescription,
                    //                                                                     showReportComment: $showReportComment,
                    //                                                                     redirectReply: $redirectReply,
                    //                                                                     profileImage: .constant(data.user?.avatar ?? ""),
                    //                                                                     displayName: .constant(data.user?.name ?? ""),
                    //                                                                     commentDuration: .constant(""),
                    //                                                                     comment: .constant(data.comment),
                    //                                                                     likes: .constant(data.like_count),
                    //                                                                     replies: .constant(data.replies_count),
                    //                                                                     isLike: .constant(true),
                    //                                                                     action: {
                    //                                commentid = data.uid
                    //                                redirectReply = true
                    //                            },
                    //                                                                     likeAction: {},
                    //                                                                     dislikeAction: {}
                    //                            )
                    //                            .padding(.top, 10)
                    //                        }
                    //                    }
                }
                //                }
                
                NavigationLink(isActive: $redirectReply) {
                    VaultRepliesView(dismissSheet: $redirectReply, isRecieved: $vaultViewModel.isRecieved , commentData: $commentid, postId: $postId)
                        .environmentObject(vaultViewModel)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
                
                AddCommentView(addComment: $addComment, loader: .constant(false), keyboardFocused: $keyboardFocused) {
                    vaultViewModel.vaultCreateComment(comment: addComment, post: postId)
                    addComment = ""
                }
                
            }
            .background {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            
            .popup(isPresented: $vaultViewModel.commentAdded) {
                FLToastAlert(image: .constant(""), message: .constant("Comment Added"))
            } customize: {
                $0
                    .type(.floater(useSafeAreaInset: true))
                    .position(.top)
                    .animation(.spring())
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.5))
                    .autohideIn(3)
                    .appearFrom(.top)
            }
            
            .onAppear {
                //                vaultViewModel.showLoader = true
                print("STATUS ---> \(vaultViewModel.isRecieved)")
                vaultViewModel.vaultCommentsDetails(postId: postId)
                print("ID ---> \(postId)")
            }
            .onReceive(vaultViewModel.$commentAdded){ _ in
                vaultViewModel.vaultCommentsDetails(postId: postId)
            }
        }
    }
}
//
//#Preview {
//    VaultCommentView(dismissSheet: .constant(true))
//}
