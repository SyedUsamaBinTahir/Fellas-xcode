//
//  VideoPlayerView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 20/05/2024.
//

import SwiftUI

import SwiftUI
import AVKit

struct VideoPlayer: View {
    var size: CGSize
    var safeArea: EdgeInsets
    @State private var player = AVPlayer(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
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
    /// Rotation Properties
    @State private var isRotated: Bool = false
    
    var body: some View {
        VStack {
            let videoPlayerSize: CGSize = .init(width: isRotated ? size.height : size.width, height: isRotated ? size.width : (size.height / 3.5))
            
            // Custom Video Player
            ZStack {
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
                                player.seek(to: .init(seconds: seconds, preferredTimescale: 1))
                            }
                            
                            DoubleTapSeek(isForward: true) {
                                /// seeking 15 seconds farward
                                let seconds = player.currentTime().seconds + 15
                                player.seek(to: .init(seconds: seconds, preferredTimescale: 1))
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
                    .overlay(alignment: .bottom) {
                        videoSeekerView(videoPlayerSize)
                    }
            }
            .background(content: {
                Rectangle()
                    .fill(.black)
                    .padding(.trailing, isRotated ? -safeArea.bottom : 0)
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
            .offset(y: isRotated ? -((size.width / 2) + safeArea.bottom) : 0)
            .rotationEffect(.init(degrees: isRotated ? 90 : 0), anchor: .topLeading)
            /// Making it top view
            .zIndex(10000)
        }
        .padding(.top, safeArea.top)
        .onAppear {
            guard !isObservedAdded else { return }
            /// Adding observer to update seeker when the video is playing
            player.addPeriodicTimeObserver(forInterval: .init(seconds: 1, preferredTimescale: 1), queue: .main) { time in
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
        }
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
                        })
                        .onEnded({ value in
                            lastDraggedProgress = progress
                            /// seeking video to dragged time
                            if let currentPlayerTime = player.currentItem {
                                let totalDuration = currentPlayerTime.duration.seconds
                                
                                player.seek(to: .init(seconds: totalDuration * progress, preferredTimescale: 1))
                                
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
}
