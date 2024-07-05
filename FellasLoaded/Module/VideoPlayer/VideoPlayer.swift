//
//  VideoPlayerView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI
import AVKit
import GoogleCast

struct VideoPlayer: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var feedViewModel: FeedViewModel
    var size: CGSize
    var safeArea: EdgeInsets?
    var url: URL
    @Binding var commentOrder: String
    @Binding var seriesEpisodeDetailId: String
    @Binding var episodeCategoryID: String
    @State private var player: AVPlayer
    init(size: CGSize, safeArea: EdgeInsets?, url: URL, commentOrder: Binding<String>, seriesEpisodeDetailId: Binding<String>, episodeCategoryID: Binding<String>) {
        self.size = size
        self.safeArea = safeArea
        self.url = url
        self._commentOrder = commentOrder
        self._seriesEpisodeDetailId = seriesEpisodeDetailId
        self._episodeCategoryID = episodeCategoryID
        self._player = State(initialValue: AVPlayer(url: url))
    }
    @State private var showPlayerControlls: Bool = false
    @State private var isPlaying: Bool = false
    @State private var timeoutTask: DispatchWorkItem?
    @State private var isFinishedSeeking: Bool = false
    /// Video Seeker Properties
    @GestureState private var isDragging: Bool = false
    @State private var isSeeking: Bool = false
    @State private var progress: CGFloat = 0
    @State private var lastDraggedProgress: CGFloat = 0
    @State private var isObservedAdded: Bool = false
    /// Video seeker thumbnails
    @State private var thumbnailsFrames: [UIImage] = []
    @State private var draggingImage: UIImage?
    @State private var playerStatusObserver: NSKeyValueObservation?
    /// Rotation Properties
    @State private var isRotated: Bool = false
    
    @State private var expandDescription = false
    @State private var redirectComment = false
    @State private var selectedTab: SegmentsTab = .EPISODES
    
    @State private var showSleepTimer = false
    @State private var showVidoQualityLisit = false
    
    var body: some View {
        VStack(alignment: .leading) {
            let videoPlayerSize: CGSize = .init(width: isRotated ? size.height : size.width, height: isRotated ? size.width : (size.height / 3.5))
            
            // Custom Video Player
            if feedViewModel.showLoader {
                FLLoader()
                    .frame(width: videoPlayerSize.width, height: videoPlayerSize.height)
                    /// To avoid other view expansion set it's native view height
                    .frame(width: size.width, height: size.height / 3, alignment: .bottomLeading)
            } else {
                ZStack(alignment: .topLeading) {
                    CustomVideoPlayer(player: player)
                        .overlay {
                            Rectangle()
                                .fill(.black.opacity(0.4))
                                .opacity(showPlayerControlls || isDragging ? 1 : 0)
                            /// Animating Dragging State
                                .animation(.easeIn(duration: 0.35), value: isDragging)
                                .overlay {
                                    playerbackControlls()
                                }
                        }
                        .overlay(content: {
                            HStack(spacing: 60) {
                                DoubleTapSeek {
                                    /// seeking 15 seconds backward
                                    let seconds = player.currentTime().seconds - 15
                                    player.seek(to: .init(seconds: seconds, preferredTimescale: 600))
                                }
                                
                                DoubleTapSeek(isForward: true) {
                                    /// seeking 15 seconds farward
                                    let seconds = player.currentTime().seconds + 15
                                    player.seek(to: .init(seconds: seconds, preferredTimescale: 600))
                                }
                            }
                        })
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                showPlayerControlls.toggle()
                            }
                            
                            if isPlaying {
                                timeoutControlls()
                            }
                        }
                        .overlay(alignment: .leading ,content: {
                            seekerThumbnailView(videoPlayerSize)
                        })
                        .overlay(alignment: .bottom) {
                            if showPlayerControlls {
                                videoSeekerView(videoPlayerSize)
                            }
                        }
                    
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("back-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .opacity(0.8)
                        }
                        
                        Spacer()
                        if showPlayerControlls {
                            HStack {
                                AirPlayView()
                                    .frame(width: 32, height: 32)
                                CastButtonRepresentable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(.white)
                                Button {
                                    showSleepTimer.toggle()
                                } label: {
                                    Image(systemName: "clock")
                                        .frame(width: 32, height: 32)
                                        .foregroundColor(.white)
                                }
                                
                                Button {
                                    showVidoQualityLisit.toggle()
                                } label: {
                                    Image("settings-icon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .padding(10)
                }
                .sheet(isPresented: $showSleepTimer) {
                    SleepTimerView()
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
                .sheet(isPresented: $showVidoQualityLisit) {
                    VideoQualitySelectionView {
                        
                    }
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .environmentObject(feedViewModel)
                }
                .background(content: {
                    Rectangle()
                        .fill(.black)
                        .padding(.trailing, isRotated ? -safeArea!.bottom : 0)
                })
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            if -value.translation.height > 100 {
                                /// Rotate Player
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isRotated = true
                                }
                            } else {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isRotated = false
                                }
                            }
                        })
                )
                .frame(width: videoPlayerSize.width, height: videoPlayerSize.height)
                /// To avoid other view expansion set it's native view height
                .frame(width: size.width, height: size.height / 3, alignment: .bottomLeading)
                .offset(y: isRotated ? -((size.width / 2) + safeArea!.bottom) : 0)
                .rotationEffect(.init(degrees: isRotated ? 90 : 0), anchor: .topLeading)
                /// Making it top view
                .zIndex(10000)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text(feedViewModel.seriesEpisodeDetailModel?.title ?? "")
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(.white)
                    
                    Text("Quality: \(currentQuality())")
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(.white)
                    
                    Text("Caption: \(currentCaption())")
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(.white)
                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 16) {
                            Button {
                                
                            } label: {
                                Image("add-to-watchlist-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            }
                            
                            Button {
                                
                            } label: {
                                Image("download-icon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            }
                        }
                        
                        Rectangle()
                            .fill(Color.theme.appGrayColor.opacity(0.4))
                            .frame(maxWidth: .infinity, maxHeight: 2)
                    }
                    
                    VStack(alignment: .leading, spacing: 14) {
                        Text("S\(feedViewModel.seriesEpisodeDetailModel?.session_number ?? 0): E\(feedViewModel.seriesEpisodeDetailModel?.episode_number ?? 0) • 2022")
                            .font(.custom(Font.Medium, size: 11))
                            .foregroundStyle(Color.theme.textGrayColor)
                        
                        VStack(alignment: .leading) {
                            Text(feedViewModel.seriesEpisodeDetailModel?.description ?? "")
                                .font(.custom(Font.regular, size: 14))
                                .foregroundStyle(.white)
                                .lineLimit(expandDescription ? nil : 2)
                            Text(expandDescription ? "show less" : "more")
                                .font(.custom(Font.bold, size: 14))
                                .foregroundStyle(.white)
                                .onTapGesture {
                                    expandDescription.toggle()
                                }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: 0) {
                                Text("Hosts: ")
                                ForEach(feedViewModel.seriesEpisodeDetailModel?.main_hosts ?? [], id: \.uid) { host in
                                    Text("\(host.name), ")
                                }
                            }
                            .font(.custom(Font.Medium, size: 14))
                            .foregroundStyle(Color.theme.textGrayColor)
                        }
                        
                        VaultCommentsCardView(numberOfComments: .constant("\(feedViewModel.seriesEpisodesCommentsModel?.count ?? 0)"),
                                              profileImage: .constant(feedViewModel.seriesEpisodesCommentsModel?.results[0].user?.avatar ?? ""),
                                              comment: .constant(feedViewModel.seriesEpisodesCommentsModel?.results[0].comment ?? ""))
                        .onTapGesture {
                            redirectComment = true
                        }
                        .sheet(isPresented: $redirectComment, content: {
                            CommentView(dismissSheet: $redirectComment, commentOrder: $commentOrder, seriesEpisodeDetailId: $seriesEpisodeDetailId, episodeCategoryID: $episodeCategoryID)
                                .presentationDragIndicator(.visible)
                                .environmentObject(feedViewModel)

                        })
                    }
                    .padding(.top, 5)
                    
                    LazyVStack(alignment: .leading, spacing: 20) {
                        Segments(selectedTab: $selectedTab)
                        
                        if selectedTab == .EPISODES {
                            ForEach(feedViewModel.feedCategorySeriesDetailModel?.sessions ?? [], id: \.uid) { data in
                                ForEach(data.episodes ?? [], id: \.uid) { episode in
                                    EpisodesView(seriesImage: episode.thumbnail, episode: "S\(episode.session_number):E\(episode.episode_number)", title: episode.title, description: episode.description, icon: "download") {  }
                                }
                            }
                        } else if selectedTab == .RECOMMENDED {
                            ForEach(1...5, id: \.self) { _ in
                                EpisodesView(seriesImage: "series-image", episode: "S1:E1", title: "The Fellas & W2S Get Drunk", description: "The Fellas head to the city of Amsterdam for some absolute CARNAGE! 24 hours was more than enough and you'll see why")
                            }
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .padding(.top, isRotated ? safeArea!.top : (horizontalSizeClass == .regular ? 0 : 20))
        .padding(.leading, isRotated ? (horizontalSizeClass == .regular ? -44 : 32) : 0)
        .onAppear {
            isPlaying = true
            player.play()
            guard !isObservedAdded else { return }
            /// Adding observer to update seeker when the video is playing
            player.addPeriodicTimeObserver(forInterval: .init(seconds: 1, preferredTimescale: 600), queue: .main) { time in
                /// calculating video prcess
                if let currentPlayerItem = player.currentItem {
                    let totalDuration = currentPlayerItem.duration.seconds
                    let currentDuration = player.currentTime().seconds
                    
                    let calculatedProgress = currentDuration / totalDuration
                    
                    if !isSeeking {
                        progress = calculatedProgress
                        lastDraggedProgress = progress
                    }
                    
                    if calculatedProgress == 1 {
                        isFinishedSeeking = true
                        isPlaying = false
                    }
                }
            }
            
            isObservedAdded = true
            
            // Before generating thumbnail check if the video is loaded
            playerStatusObserver = player.observe(\.status, options: .new, changeHandler: { player, _ in
                if player.status == .readyToPlay {
                    generateThumbnailFrames()
                }
            })
        }
        .onDisappear {
            isPlaying = false
            player.pause()
            
            playerStatusObserver?.invalidate()
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
    
    func currentQuality() -> String {
        // Retrieve the current quality (resolution) from the player
        guard let asset = player.currentItem?.asset as? AVURLAsset else { return "Unknown" }
        let bitrate = asset.tracks.first?.estimatedDataRate ?? 0
        return "\(bitrate / 1000) kbps"
    }
    
    func currentCaption() -> String {
        // Retrieve the current caption (subtitles) from the player
        guard let group = player.currentItem?.asset.mediaSelectionGroup(forMediaCharacteristic: .legible) else { return "None" }
        let selectedOption = player.currentItem?.currentMediaSelection.selectedMediaOption(in: group)
        return selectedOption?.displayName ?? "None"
    }
    
    @ViewBuilder
    func seekerThumbnailView(_ videoSize: CGSize) -> some View {
        let thumbSize: CGSize = .init(width: 175, height: 100)
        ZStack {
            if let draggingImage, isDragging {
                Image(uiImage: draggingImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: thumbSize.width, height: thumbSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .overlay(alignment: .bottom, content: {
                        if let currentTime = player.currentItem {
                            Text(CMTime(seconds: progress * currentTime.duration.seconds, preferredTimescale: 600).toTimeString())
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .offset(y: 25)
                        }
                    })
                    .overlay {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .stroke(.white, lineWidth: 2)
                    }
            } else {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .stroke(.white, lineWidth: 2)
                    }
            }
        }
        .frame(width: thumbSize.width, height: thumbSize.height)
        .opacity(isDragging ? 1 : 0)
        // Moving alongside with gesture
        // Adding some padding at start and end
        .offset(x: progress * (videoSize.width - thumbSize.width))
        .offset(x: 10)
    }
    
    @ViewBuilder
    func videoSeekerView(_ videoSize: CGSize) -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(.gray)
            Rectangle()
                .fill(.red)
                .frame(width: max(videoSize.width * progress, 0))
        }
        .frame(height: 3)
        .overlay(alignment: .leading) {
            Circle()
                .fill(.red)
                .frame(width: 15, height: 15)
            /// showing drag knob only when dragging
                .scaleEffect(showPlayerControlls || isDragging ? 1 : 0.001, anchor: progress * videoSize.width > 15 ? .trailing : .leading)
            /// for more  Dragging Space
                .frame(width: 50, height: 50)
                .contentShape(Rectangle())
            /// moving along side Genture
                .offset(x: videoSize.width * progress)
                .gesture(
                    DragGesture()
                        .updating($isDragging, body: { _, out, _ in
                            out = true
                        })
                        .onChanged({ value in
                            /// cancelling existing timeout task
                            if let timeoutTask {
                                timeoutTask.cancel()
                            }
                            
                            let translationX: CGFloat = value.translation.width
                            let calculatedProgress = (translationX / videoSize.width) + lastDraggedProgress
                            
                            progress = max(min(calculatedProgress, 1), 0)
                            isSeeking = true
                            
                            let dragIndex = Int(progress * 100)
                            // checking if frameThumbnails contain the frame
                            if thumbnailsFrames.indices.contains(dragIndex) {
                                draggingImage = thumbnailsFrames[dragIndex]
                            }
                        })
                        .onEnded({ value in
                            lastDraggedProgress = progress
                            /// seeking video to dragged time
                            if let currentPlayerTime = player.currentItem {
                                let totalDuration = currentPlayerTime.duration.seconds
                                
                                player.seek(to: .init(seconds: totalDuration * progress, preferredTimescale: 600))
                                
                                /// Re-shooting Timeout Task
                                if isPlaying {
                                    timeoutControlls()
                                }
                                
                                /// Releasing with slightly delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                                    isSeeking = false
                                })
                            }
                        })
                )
                .offset(x: progress * videoSize.width > 15 ? -15 : 0)
                .frame(width: 15, height: 15)
        }
    }
    
    @ViewBuilder
    func playerbackControlls() -> some View {
        HStack(spacing: 15) {
            Button {
                
            } label: {
                Image(systemName: "backward.end.fill")
                    .font(.title2)
                    .fontWeight(.ultraLight)
                    .foregroundColor(.white)
                    .padding(15)
                    .background {
                        Circle()
                            .fill(.black.opacity(0.35))
                    }
            }
            .disabled(true)
            .opacity(0.6)
            
            Button {
                if isFinishedSeeking {
                    /// Setting Video To start and playing again
                    isFinishedSeeking = false
                    player.seek(to: .zero)
                    progress = .zero
                    lastDraggedProgress = .zero
                }
                // Chainging Video status to play/puase based on user input
                if isPlaying {
                    player.pause()
                    
                    if let timeoutTask {
                        timeoutTask.cancel()
                    }
                } else {
                    player.play()
                    timeoutControlls()
                }
                
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPlaying.toggle()
                }
            } label: {
                Image(systemName: isFinishedSeeking ? "arrow.clockwise" : (isPlaying ? "pause.fill" : "play.fill"))
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(15)
                    .background {
                        Circle()
                            .fill(.black.opacity(0.35))
                    }
            }
            .scaleEffect(1.1)
            
            Button {
                
            } label: {
                Image(systemName: "forward.end.fill")
                    .font(.title2)
                    .fontWeight(.ultraLight)
                    .foregroundColor(.white)
                    .padding(15)
                    .background {
                        Circle()
                            .fill(.black.opacity(0.35))
                    }
            }
            .disabled(true)
            .opacity(0.6)
            
        }
        /// Hiding controlls when dragging
        .opacity(showPlayerControlls && !isDragging ? 1: 0)
        .animation(.easeInOut(duration: 0.2), value: showPlayerControlls && !isDragging)
    }
    
    // timing out playback controlls
    func timeoutControlls() {
        // Cancelling Already Pending Task
        if let timeoutTask {
            timeoutTask.cancel()
        }
        
        timeoutTask = .init(block: {
            withAnimation(.easeInOut(duration: 0.35)) {
                showPlayerControlls = false
            }
        })
        
        if let timeoutTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: timeoutTask)
        }
    }
    
    // Generating thumbnail frames
    func generateThumbnailFrames() {
        Task.detached {
            guard let asset = await player.currentItem?.asset else { return }
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            /// Min size
            generator.maximumSize = .init(width: 250, height: 250)
            
            do {
                let totalDuration = try await asset.load(.duration).seconds
                var frameTimes: [CMTime] = []
                // frame timing
                // 1/0.1 = 100 (Frames)
                for progress in stride(from: 0, to: 1, by: 0.01) {
                    let time = CMTime(seconds: progress * totalDuration, preferredTimescale: 600)
                    frameTimes.append(time)
                }
                
                // Generating frame images
                for await result in generator.images(for: frameTimes) {
                    let cgImage = try result.image
                    
                    await MainActor.run {
                        thumbnailsFrames.append(UIImage(cgImage: cgImage))
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

//#Preview {
//    VideoPlayerView()
//}
