//
//  DownoadVideoVIewModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 15/07/2024.
//

import Foundation
import SwiftUI

class DownloadedDataViewModel: ObservableObject {
    @Published var feedSeriesBVideoModel: [SeriesBvideo]?

    func loadVideoData() {
        guard let data = UserDefaults.standard.data(forKey: FLUserDefaultKeys.videoData.rawValue) else {
            return
        }
        
        do {
            let decoder = try JSONDecoder().decode([SeriesBvideo].self, from: data)
            feedSeriesBVideoModel = decoder
            print("Decoded Data --> " ,feedSeriesBVideoModel)
            print("Decoder --> ", decoder)
        } catch {
            print(String(describing: error))
        }
        
        print("User defaults data -->", String(data: data, encoding: .utf8) ?? "")
    }
    
}
