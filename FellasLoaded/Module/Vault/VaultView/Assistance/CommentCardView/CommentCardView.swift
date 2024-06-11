//
//  CommentCardView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct CommentCardView: View {
    @Binding var isPinned: Bool
    @Binding var expandDescription: Bool
    @Binding var showReportComment: Bool
    @Binding var redirectReply: Bool
    var body: some View {
        HStack {
            HStack(alignment: .top) {
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        if isPinned {
                            Image("pin-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                        }
                        Text("Pinned by Cal")
                            .font(.custom(Font.regular, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Display name")
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.theme.textGrayColor)
                            Image("dot-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 5, height: 18)
                            Text("2 days ago")
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(Color.theme.textGrayColor)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut eet dolore magna aliqua. Ut")
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
                        HStack(spacing: 10) {
                            Image("like-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                            Text("12K")
                                .font(.custom(Font.bold, size: 14))
                                .foregroundStyle(.white)
                        }
                        .padding(10)
                        .background(Color.theme.appGrayColor)
                        .cornerRadius(8)
                        
                        HStack(spacing: 10) {
                            Image("reply-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                            Text("\(32) REPLIES")
                                .font(.custom(Font.bold, size: 14))
                                .foregroundStyle(.white)
                        }
                        .padding(10)
                        .background(Color.theme.appGrayColor)
                        .cornerRadius(8)
                        .onTapGesture {
                            redirectReply = true
                        }
                    }
//                    .navigationDestination(isPresented: $redirectReply) {
//                        RepliesView(dismissSheet: $redirectReply).navigationBarBackButtonHidden(true)
//                    }
                    
                    NavigationLink(isActive: $redirectReply) {
                        RepliesView(dismissSheet: $redirectReply).navigationBarBackButtonHidden(true)
                    } label: {
                        EmptyView()
                    }

                    
                }
                .padding(.top, 4)
                
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
            .padding()
        }
        .overlay {
            if showReportComment {
                Button {
                    
                } label: {
                    Text("Report Comment")
                        .padding(14)
                        .font(.custom(Font.regular, size: 14))
                        .foregroundStyle(.white)
                        .background(Color.theme.appGrayColor)
                        .cornerRadius(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 0.6)
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        .padding(.bottom, 40)
                }
            }

        }

    }
}

#Preview {
    CommentCardView(isPinned: .constant(true), expandDescription: .constant(false), showReportComment: .constant(false), redirectReply: .constant(false))
}
