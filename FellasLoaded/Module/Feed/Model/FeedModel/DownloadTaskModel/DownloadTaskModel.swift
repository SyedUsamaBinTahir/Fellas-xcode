//
//  DownloadTaskModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 18/07/2024.
//

import Foundation
import SwiftUI

class DownloadTaskModel: NSObject, ObservableObject, URLSessionDownloadDelegate, UIDocumentInteractionControllerDelegate {
    @Published var downloadURL: URL!
    @Published var showAlert = false
    @Published var alertMessage = ""
    // Saving Download Task reference for cancelling
    @Published var downloadTaskSession: URLSessionDownloadTask!
    // Progress
    @Published var downloadProgress: CGFloat = 0
    // show progress view
    @Published var showDownloadProgress = false
    
    // Get downloaded from Document Directory
    func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.last
    }
    
    func getDownloadedFiles() -> [URL] {
        guard let documentsDirectory = getDocumentsDirectory() else { return [] }
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            print("File URL:", fileURLs)
            return fileURLs
        } catch {
            print("Error while enumerating files \(documentsDirectory.path): \(error.localizedDescription)")
            return []
        }
    }
    
    func startDownload(urlString: String) {
        // checking for valid url
        guard let validURL = URL(string: urlString) else {
            self.reportError(error: "Invalid URL")
            return
        }
        
        downloadProgress = 0
        withAnimation {
            showDownloadProgress = true
        }
        
        // Download Task
        // Since we are going to get the progress as well as location of file so we're using delegate..
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        downloadTaskSession = session.downloadTask(with: validURL)
        downloadTaskSession.resume()
    }
    
    func reportError(error: String) {
        alertMessage = error
        showAlert.toggle()
    }
    
    func deleteFile(at url: URL) {
            do {
                try FileManager.default.removeItem(at: url)
                print("File deleted successfully: \(url)")
            } catch {
                print("Error deleting file: \(error.localizedDescription)")
            }
        }
    
    // Implementing URL Session functions...
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Location -->", location)
        // since it will download it as temporary data
        // so we're going to save it in app directry and showing it in document controller
        
        guard let url = downloadTask.originalRequest?.url else {
            self.reportError(error: "Somthing went wrong please try again later")
            return
        }
        
        guard let documentsDirectory = getDocumentsDirectory() else {
            self.reportError(error: "Unable to access documents directory")
            return
        }
        
        let timestamp = Date().timeIntervalSince1970
        let destinationURL = documentsDirectory.appendingPathComponent("\(url.deletingPathExtension().lastPathComponent)_\(timestamp).\(url.pathExtension)")
        
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            print("Destination URL --> ", destinationURL)
            print("Success")
            DispatchQueue.main.async {
                withAnimation {
                    self.showDownloadProgress = false
                }
            }
        } catch {
            self.reportError(error: "Please try again later")
        }
        
        // directory path...
//        let directryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        
//        // creating one for storing file...
//        // destination Url
//        // getting like injustine.mp4...
//        let destinationURL = directryPath.appendingPathComponent(url.lastPathComponent)
//        
//        // if already file is there removing it
//                try? FileManager.default.removeItem(at: destinationURL)
//        
//        do {
//            try FileManager.default.copyItem(at: location, to: destinationURL)
//            print("Destination URL --> ", destinationURL)
//            // if success
//            print("Success")
//            // closing progress view...
//            DispatchQueue.main.async {
//                withAnimation {
//                    self.showDownloadProgress = false
//                }
//                
//                // presenting the file with help of document interaction controller from controller
//                //                let controller = UIDocumentInteractionController(url: destinationURL)
//                //
//                //                // it needs a delegate
//                //                controller.delegate = self
//                //                controller.presentPreview(animated: true)
//            }
//        } catch {
//            self.reportError(error: "Please try again later")
//        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        // Getting progress...
        let progress = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        print(progress)
        
        // since URL Session will be running in BG thread
        // so UI updates will be done on main thread
        DispatchQueue.main.async {
            self.downloadProgress = progress
        }
    }
    
    // cancel task
    func cancelTask() {
        downloadTaskSession.cancel()
    }
    
    // sub functions for presenting view
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
}
