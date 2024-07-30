//
//  EditProfileApiSevice.swift
//  FellasLoaded
//
//  Created by Phebsoft on 11/07/2024.
//

import Foundation
import SwiftUI
import Alamofire
import Network
import Combine

struct UploadedMedia {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/png"
        self.filename = "imagefile.png"
        guard let data = image.jpegData(compressionQuality: 0.1) else { return nil }
        self.data = data
    }
}

class EditProfileApiService: ObservableObject {
    @Published var images = UIImage()
    @Published var showLoader = false
    @Published var showAlert = false
    @Published var isSucces: Bool = false
    @Published var alertMessage = ""
    @Published var redirectToSubscribeView = false
    
    func uploadImageToServer(image: UIImage, name: String, email: String = "", phone: String = "", pushId: String = "") {
        images = image
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "push_id": pushId
        ]
        guard let mediaImage = UploadedMedia(withImage: image, forKey: "avatar") else { return }
        print("Media Image -->", mediaImage)
        guard let url = URL(string: FLAPIs.baseURL + FLAPIs.editProfile) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        let boundary = generateBoundary()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: FLUserDefaultKeys.accesstoken.rawValue) ?? "N/A")", forHTTPHeaderField: "Authorization")
        let dataBody = DataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
        
        self.showLoader = true
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                self.showLoader = false
                if let response = response {
                    print("Response --> ", response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("JSON -->", json)
                        self.redirectToSubscribeView = true
                        self.showAlert = true
                        self.alertMessage = "Profile updated successfully"
                        self.isSucces = true
                    } catch {
                        print("ERROR -->", error)
                        self.showAlert = true
                        self.alertMessage = error.localizedDescription
                    }
                } else if let error = error {
                    print("ERROR -->", error)
                    self.showAlert = true
                    self.alertMessage = error.localizedDescription
                }
            }
        }.resume()
    }
    
    func DataBody(withParameters params: [String: Any]?, media: [UploadedMedia]?, boundary: String) -> Data {
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
        return "Boundary-\\(NSUUID().uuidString)"
    }
}
