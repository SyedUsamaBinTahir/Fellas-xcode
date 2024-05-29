//
//  DisplayNameAndImageAPIService.swift
//  FellasLoaded
//
//  Created by Phebsoft on 29/05/2024.
//

import Foundation
import SwiftUI

class DisplayNameAndImageAPIService {
    static let shared = DisplayNameAndImageAPIService()
    
    func updateRequest(selectedImage: Image?, name: String) {
        
        let uiImage: UIImage = selectedImage?.asUIImage() ?? UIImage(imageLiteralResourceName: "")
        print(uiImage)
        let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
        let imageStr: String = imageData.base64EncodedString()
        
        guard let url: URL = URL(string: "https://api.fellasloaded.com/api/user/update/") else {
            print("invalidURL")
            return
        }
        do {
            let paramStr: String = "image=\(imageStr)"
            let paramData: Data = paramStr.data(using: .utf8) ?? Data()
            let paramString: String = "\(paramData)"
            
            let requestData = try JSONEncoder().encode(DisplayNameAndImageRequest(avatar: paramString, name: name))
            
            var urlRequest: URLRequest = URLRequest(url: url)
            urlRequest.httpMethod = "PATCH"
            urlRequest.httpBody = requestData
            urlRequest.setValue("multipart/form-data; boundary=---011000010111000001101001a", forHTTPHeaderField: "Content-Type")
            urlRequest.setValue("Bearer \(FLUserJourney.shared.authRegistrationToken ?? "N/A")", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else {
                    print("invalid data")
                    return
                }
                
                let responseStr: String = String(data: data, encoding: .utf8) ?? ""
                print(responseStr)
            }
            .resume()
        } catch {
            print(error.localizedDescription)
        }
    }
}
