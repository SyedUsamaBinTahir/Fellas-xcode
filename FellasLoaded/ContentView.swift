//
//  ContentView.swift
//  FellasLoaded
//
//  Created by Phebsoft on 13/05/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if let isLoggedIn = FLUserJourney.shared.isSubscibedUserLoggedIn, isLoggedIn {
            Tabbar()
        } else {
            WelcomeScreen()
        }
    }
}

#Preview {
    ContentView()
}

struct DownloadedFilesView: View {
    @StateObject var downloadModel = DownloadTaskModel()
    @State private var downloadedFiles: [URL] = []
    
    var body: some View {
        NavigationView {
            List(downloadedFiles, id: \.self) { fileURL in
                HStack {
                    NavigationLink(destination: FileDetailView(fileURL: fileURL)) {
                        Text(fileURL.lastPathComponent)
                    }
                    Spacer()
                    
                    Button(action: {
                        deleteFile(at: fileURL)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            
            .navigationTitle("Downloaded Files")
            .onAppear(perform: loadFiles)
        }
    }
    
    private func loadFiles() {
        downloadedFiles = downloadModel.getDownloadedFiles()
    }
    
    private func deleteFile(at url: URL) {
        downloadModel.deleteFile(at: url)
        loadFiles()  // Refresh the file list
    }
}

struct FileDetailView: View {
    @StateObject var feedViewModel = FeedViewModel(_dataService: GetServerData.shared)
    var fileURL: URL
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
//            VideoPlayer(size: size, safeArea: safeArea, url: fileURL, commentOrder: .constant(""), seriesEpisodeDetailId: .constant(""), episodeCategoryID: .constant(""))
//                .environmentObject(feedViewModel)
            // Here you can add code to display more details or play the video
        }
    }
}
