//
//  DownloadsView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 17/05/2024.
//

import SwiftUI

struct DownloadsView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var downloadModel = DownloadTaskModel()
    @StateObject var downloadDataViewModel = DownloadedDataViewModel()
    @State private var seriesDetails: [SeriesEpisodeDetailModel] = []
    @State private var seriesEpisodeDetailModel: SeriesEpisodeDetailModel?
    @State private var downloadedFiles: [URL] = []
    @State private var redirectToDownloadsVideoPlayer = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 30) {
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
                        Text("Downloads")
                            .font(.custom(Font.semiBold, size: 24))
                            .foregroundStyle(Color.white)
                    }
                    
                    HStack {
                        Spacer()

                        Button(action: {
                            
                        }, label: {
                            Image("edit-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                        })
                        
                    }
                }
                .padding(.top, 30)
                
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(seriesDetails, id: \.uid) { data in
                            ForEach(downloadedFiles, id: \.self) { fileULR in
                                HStack {
                                    EpisodesView(seriesImage: data.bvideo.preview_image_url,
                                                 episode: "\(data.bvideo.length)",
                                                 title: data.bvideo.video_name,
                                                 icon: "downloaded-icon",
                                                 action: {
                                        redirectToDownloadsVideoPlayer = true
                                    })
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        deleteSeriesDetail(id: data.uid)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                NavigationLink(destination: DownloadsVideoPlayerView(url: fileULR).navigationBarBackButtonHidden(true), isActive: $redirectToDownloadsVideoPlayer) {
                                    EmptyView()
                                }
                            }
                        }
                        
                        
//                        DownloadedFilesView()
                    }
                }
            }
            .padding()
        }
        .onAppear {
//            downloadDataViewModel.loadVideoData()
            loadFiles()
            loadSeriesDetails()
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.theme.appColor, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .ignoresSafeArea()
    }
    
    private func loadFiles() {
        downloadedFiles = downloadModel.getDownloadedFiles()
    }
    
    private func deleteFile(at url: URL) {
        downloadModel.deleteFile(at: url)
        loadFiles()  // Refresh the file list
    }
    
    private func loadSeriesDetails() {
        if let loadedDetails = downloadModel.loadSeriesDetailsFromFile() {
            seriesDetails = loadedDetails
            print("series detail -->" ,seriesDetails)
        }
    }
    
    func deleteSeriesDetail(id: String) {
        var seriesDetails = downloadModel.loadSeriesDetailsFromFile() ?? []
        seriesDetails.removeAll { $0.uid == id }  // Assuming 'id' is a unique identifier in SeriesEpisodeDetailModel
        
        if let jsonData = try? JSONEncoder().encode(seriesDetails) {
            downloadModel.saveJSONToFile(data: jsonData, fileName: "seriesDetails.json")
        }
    }
}

#Preview {
    DownloadsView()
}
