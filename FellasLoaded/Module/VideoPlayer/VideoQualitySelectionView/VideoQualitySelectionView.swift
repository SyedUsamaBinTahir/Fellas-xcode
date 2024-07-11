//
//  VideoQualitySelectionView.swift
//  FellasLoaded
//
//  Created by Syed Usama on 27/06/2024.
//

import SwiftUI
import M3U8Decoder
import Combine


struct MasterPlaylist: Decodable {
    let extm3u: Bool
    let ext_x_version: Int
    let ext_x_stream_inf: [EXT_X_STREAM_INF]
    let uris: [String]
    
    var variantStreams: [(inf: EXT_X_STREAM_INF, uri: String)] {
        Array(zip(ext_x_stream_inf, uris))
      }
}

class MediaPlaylistViewModel: ObservableObject {
    @Published var playList: MasterPlaylist?
    private var cancellable: AnyCancellable?
    
    func mediaPlaylist(url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MasterPlaylist.self, decoder: M3U8Decoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Finished decoding playlist")
                    case .failure(let error):
                        print("Failed to decode playlist: \(error)")
                    }
                },
                receiveValue: { [weak self] playlist in
                    self?.playList = playlist
                    print("Play list --> ", self?.playList ?? "")
                    print(playlist.ext_x_version)
                    print(playlist.ext_x_stream_inf)
                    print(playlist.uris[0])
                }
            )
    }
}

struct VideoQualitySelectionView: View {
    @EnvironmentObject var feedViewModel: FeedViewModel
    @StateObject var viewModel = MediaPlaylistViewModel()
    let url: URL
    @State var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ZStack {
                
                HStack {
                    Text("Quality")
                        .font(.custom(Font.semiBold, size: 24))
                        .foregroundStyle(Color.white)
                }
                
                HStack {
                    Spacer()

                    Button(action: {
                        
                    }, label: {
                        Image("xmark-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                    })
                    
                }
            }
            .padding(.top)
            
            VStack(alignment: .leading ,spacing: 30) {
                ForEach(viewModel.playList?.ext_x_stream_inf ?? [], id: \.bandwidth) { resolution in
                    Button(action: action) {
                        Text("\(resolution.resolution?.height ?? 0)")
                            .font(.custom(Font.semiBold, size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .foregroundStyle(.white)
            Spacer()
            VStack(spacing: 12) {
                Rectangle()
                    .fill(Color.theme.appGrayColor)
                    .frame(height: 1)
                Text("This selection only applies to the current video")
                    .font(.custom(Font.Medium, size: 12))
                    .foregroundStyle(Color.theme.textGrayColor)
            }
            .padding(.top)
            
            Spacer()
        }
        .onAppear {
            viewModel.mediaPlaylist(url: url)
        }
        .padding()
        .background(Color.theme.tabbarColor)
        .ignoresSafeArea()
    }
}
