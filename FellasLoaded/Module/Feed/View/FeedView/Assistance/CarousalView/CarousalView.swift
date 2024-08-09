//
//  CarousalView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 16/05/2024.
//

import SwiftUI
import UIKit
import ACarousel
import Kingfisher

struct CarousalView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var feedViewModel: FeedViewModel
    @Binding var redirectVideoPlayer: Bool
    @State private var seriesDetailID: String = ""
    @State private var seriesEpisodeDetailId: String = ""
    @State private var episodeCategoryID: String = ""
    @State private var bannerId = ""
    @State var bannerUid: FeedBannerResults? = nil
    let items: [Item] = roles.map { Item(image: Image($0)) }
    
    var body: some View {
        Group {
            if let bannerId = self.bannerUid {
                NavigationLink(isActive: $redirectVideoPlayer) {
                    VideoPlayerView(seriesDetailID: $seriesDetailID, bannerUid: bannerId)
                        .environmentObject(feedViewModel)
                        .navigationBarBackButtonHidden(true)
                } label: {
                    EmptyView()
                }
            }
            if let results = feedViewModel.feedBannerModel?.results, !results.isEmpty {
                ACarousel(results,
                          spacing: 12,
                          headspace: 5,
                          sidesScaling: 0.95,
                          isWrap: true,
                          autoScroll: .active(12)) { item in
                    
//                    NavigationLink {
//                        VideoPlayerView(seriesDetailID: $seriesDetailID, bannerUid: item)
//                                                    .environmentObject(feedViewModel)
//                                                    .navigationBarBackButtonHidden(true)
//                    } label: {
                        KFImage(URL(string: item.cover_art ?? ""))
                            .placeholder({ progress in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.theme.appCardsColor)
                                    .frame(width:  358, height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.34 : UIScreen.main.bounds.height * 0.24)
                            })
                            .loadDiskFileSynchronously()
                            .cacheMemoryOnly()
                            .fade(duration: 0.50)
                            .resizable()
                            .scaledToFill()
                            .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.34 : UIScreen.main.bounds.height * 0.24)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.theme.appGrayColor, lineWidth: 0.3)
                            }
                            .onTapGesture {
                                self.bannerUid = item

                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    redirectVideoPlayer = true
                                }

                                print("item id -->", item.object_uid)
                                print("banner Uid -->", self.bannerUid?.object_uid ?? "")
                            }
//                    }

//                    NavigationLink(isActive: $redirectVideoPlayer) {
//                        VideoPlayerView(seriesDetailID: $seriesDetailID, bannerUid: item)
//                            .environmentObject(feedViewModel)
//                            .navigationBarBackButtonHidden(true)
//                    } label: {
//                       
//                    }
                }
                          .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.34 : UIScreen.main.bounds.height * 0.24)
            } else {
            }
        }
    }
}

#Preview {
    CarousalView(redirectVideoPlayer: .constant(false))
}

struct Item: Identifiable {
    let id = UUID()
    let image: Image
}

let roles = ["series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image", "series-image"]


//                        ScrollView(.horizontal, showsIndicators: false) {
//                            LazyHStack(spacing: 10) {
//                                ForEach(feedViewModel.feedBannerModel?.results ?? [], id: \.uid) { data in
//                                    KFImage.init(URL(string: data.cover_art))
//                                        .placeholder({ progress in
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .fill(Color.theme.appCardsColor)
//                                                .frame(width:  358, height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
//                                        })
//                                        .loadDiskFileSynchronously()
//                                        .cacheMemoryOnly()
//                                        .fade(duration: 0.50)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
//                                        .cornerRadius(10)
//                                        .overlay {
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .stroke(Color.white, lineWidth: 0.3)
//                                        }
//                                        .onTapGesture {
////                                            redirectVideoPlayer = true
//                                        }
//                                }
//                            }
//                            .frame(height: horizontalSizeClass == .regular ? UIScreen.main.bounds.height * 0.32 : UIScreen.main.bounds.height * 0.22)
//                            .padding(.horizontal)
//                        }


//struct CarousalView: View {
//    
//    @GestureState private var dragState = DragState.inactive
//    @State var carouselLocation = 0
//    
//    var itemHeight: CGFloat
//    @State var views: [AnyView]
//    
//    private func onDragEnded (drag:
//                              DragGesture.Value) {
//        let dragThreshold: CGFloat = 200
//        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold{
//            carouselLocation = carouselLocation - 1
//        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold)
//        {
//            carouselLocation = carouselLocation + 1
//        }
//    }
//    
//    var body: some View {
//            LazyVStack {
//                ZStack{
//                    ForEach(0..<views.count){i in
//                        LazyVStack{
////                            Spacer()
//                            self.views[i]
//                            //Text("\(i)")
//                                .frame(width: 358, height: self.getHeight(i))
//                                .animation (.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
//                                .background (Color.theme.appCardsColor)
//                                .cornerRadius (10)
//                                .shadow (radius: 4)
//                                .opacity(self.getOpacity(i))
//                                .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
//                                .offset(x: self.getOffset(i))
//                                .animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
////                            Spacer()
//                        }
//                    }
//                }.gesture(
//                    DragGesture()
//                        .updating($dragState) { drag, state, transaction in
//                            state = .dragging (translation: drag.translation)
//                        }
//                        .onEnded (onDragEnded)
//                )
//                Spacer()
//            }
//    }
//    
//    func getHeight(_ i: Int) -> CGFloat{
//        if i == relativeLoc() {
//            return itemHeight
//        } else {
//            return itemHeight - 20
//        }
//    }
//
//    func relativeLoc() -> Int {
//        return ((views.count * 10000) + carouselLocation) % views.count
//    }
//
//    func getOpacity(_ i: Int) -> Double{
//        if i == relativeLoc()
//            || i + 1 == relativeLoc()
//            || i - 1 == relativeLoc()
//            || i + 2 == relativeLoc()
//            || i - 2 == relativeLoc()
//            || (i + 1) - views.count == relativeLoc()
//            || (i - 1) + views.count == relativeLoc()
//            || (i + 2) - views.count == relativeLoc()
//            || (i - 2) + views.count == relativeLoc()
//        {
//            return 1
//        } else {
//            return 0
//        }
//    }
//    
//    
//    func getOffset(_ i: Int) -> CGFloat {
//        if i == relativeLoc() {
//            return self.dragState.translation.width
//        } else if (i) == relativeLoc() + 1 || (relativeLoc() == views.count - 1 && i == 0) {
//            return self.dragState.translation.width + (300 + 70)
//        } else if (i) == relativeLoc() - 1 || (relativeLoc() == 0 && i == views.count - 1) {
//            return self.dragState.translation.width - (300 + 70)
//        } else if (i) == relativeLoc() + 2 || (relativeLoc() == views.count-1 && i == 1) || (relativeLoc() == views.count-2 && i == 0) {
//            return self.dragState.translation.width + (2 * (300 + 70))
//        } else if (i) == relativeLoc() - 2 || (relativeLoc() == 1 && i == views.count-1) || (relativeLoc() == 0 && i == views.count-2) {
//            return self.dragState.translation.width - (2 * (300 + 70))
//        } else if  (i) == relativeLoc() + 3 || (relativeLoc () == views.count-1 && i == 2) || (relativeLoc () == views.count-2 && i == 1) || (relativeLoc() == views.count-3 && i == 0) {
//            return self.dragState.translation.width + (3*(300 + 70))
//        } else if (i) == relativeLoc() + 3 || (relativeLoc () == views.count-1 && i == 2) || (relativeLoc () == views.count-2 && i == 1) || (relativeLoc() == views.count-3 && i == 0) {
//            return self.dragState.translation.width + (3*(300 + 70))
//        } else {
//            return 10000
//        }
//    }
//    
//    
//}
//
//
//
//enum DragState {
//    case inactive
//    case dragging (translation: CGSize)
//    var translation: CGSize {
//        switch self {
//        case .inactive:
//            return .zero
//        case .dragging (let translation):
//            return translation
//        }
//    }
//    var isDragging: Bool {
//        switch self {
//        case .inactive:
//            return false
//        case .dragging:
//            return true
//        }
//    }
//}
