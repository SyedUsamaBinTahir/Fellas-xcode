//
//  DownoadVideoVIewModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 15/07/2024.
//

import Foundation
import SwiftUI

class DownloadTaskViewModel: ObservableObject {
    
    func getURLs() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        print(url.path)
    }
    
}
