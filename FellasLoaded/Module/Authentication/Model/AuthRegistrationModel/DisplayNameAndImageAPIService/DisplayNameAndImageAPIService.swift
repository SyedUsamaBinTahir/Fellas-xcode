//
//  DisplayNameAndImageAPIService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 29/05/2024.
//

import Foundation
import SwiftUI
import Alamofire
import Network
import Combine

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image.jpegData(compressionQuality: 0.1) else { return nil }
        self.data = data
    }
}

class DisplayNameAndImageAPIService: ObservableObject {
    @Published var images = UIImage()
    // show loader after api calls variable
    @Published var showLoader = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var redirectToSubscribeView = false
    
    func uploadImageToServer(image: UIImage, name: String) {
        images = image
        let parameters: [String:Any] = [
        "name": name,
       ]
       guard let mediaImage = Media(withImage: image, forKey: "avatar") else { return }
       print("Media Image -->", mediaImage)
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.displayNameAndImage) else { return }
       var request = URLRequest(url: url)
       request.httpMethod = "PATCH"
       //create boundary
       let boundary = generateBoundary()
       //set content type
       request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(FLUserJourney.shared.authToken ?? "N/A")", forHTTPHeaderField: "Authorization")
       //call createDataBody method
       let dataBody = DataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
       request.httpBody = dataBody
       let session = URLSession.shared
       session.dataTask(with: request) { (data, response, error) in
          if let response = response {
             print("Response --> ",response)
          }
           self.showLoader = true
          if let data = data {
             do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON -->",json)
                 self.showLoader = false
                 self.redirectToSubscribeView = true
             } catch {
                print("ERROR -->",error)
                 self.showLoader = false
                 self.showAlert = true
                 self.alertMessage = error.localizedDescription
             }
          }
       }.resume()
    }
    
    func DataBody(withParameters params: [String: Any]?, media: [Media]?, boundary: String) -> Data {
       let lineBreak = "\r\n"
       var body = Data()
       if let parameters = params {
          for (key, value) in parameters {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
             body.append("\(value as! String + lineBreak)")
          }
       }
       if let media = media {
          for photo in media {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
             body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
             body.append(photo.data)
             body.append(lineBreak)
          }
       }
       body.append("--\(boundary)--\(lineBreak)")
       return body
    }
    
    func generateBoundary() -> String {
       return "Boundary-\(NSUUID().uuidString)"
    }
}
