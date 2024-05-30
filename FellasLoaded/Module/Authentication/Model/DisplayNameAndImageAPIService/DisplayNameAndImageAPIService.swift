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
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}

class DisplayNameAndImageAPIService {
    static let shared = DisplayNameAndImageAPIService()
    @Published var images = UIImage()
    
    func uploadImageToServer(image: UIImage, name: String) {
        images = image
        let parameters: [String:Any] = [
        "name": name,
       ]
       guard let mediaImage = Media(withImage: image, forKey: "avatar") else { return }
       print("Media Image -->", mediaImage)
       guard let url = URL(string: "https://api.fellasloaded.com/api/user/update/") else { return }
       var request = URLRequest(url: url)
       request.httpMethod = "PATCH"
       //create boundary
       let boundary = generateBoundary()
       //set content type
       request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(FLUserJourney.shared.authRegistrationToken ?? "N/A")", forHTTPHeaderField: "Authorization")
       //call createDataBody method
       let dataBody = DataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
       request.httpBody = dataBody
       let session = URLSession.shared
       session.dataTask(with: request) { (data, response, error) in
          if let response = response {
             print("Response --> ",response)
          }
          if let data = data {
             do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON -->",json)
             } catch {
                print("ERROR -->",error)
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
    
    
    
//    func updateRequest(selectedImage: Image?, name: String) {
//        
//        let uiImage: UIImage = selectedImage?.asUIImage() ?? UIImage(imageLiteralResourceName: "")
//        print(uiImage)
//        let imageData: Data = uiImage.jpegData(compressionQuality: 0.1) ?? Data()
//        let imageStr: String = imageData.base64EncodedString()
//        
//        guard let url: URL = URL(string: "https://api.fellasloaded.com/api/user/update/") else {
//            print("invalidURL")
//            return
//        }
//        do {
//            let paramStr: String = "image=\(imageStr)"
//            let paramData: Data = paramStr.data(using: .utf8) ?? Data()
//            let paramString: String = "\(paramData)"
//            
//            let requestData = try JSONEncoder().encode(DisplayNameAndImageRequest( name: name))
//            
//            var urlRequest: URLRequest = URLRequest(url: url)
//            urlRequest.httpMethod = "PATCH"
//            urlRequest.httpBody = requestData
//            urlRequest.setValue("multipart/form-data; boundary=---011000010111000001101001a", forHTTPHeaderField: "Content-Type")
//            urlRequest.setValue("Bearer \(FLUserJourney.shared.authRegistrationToken ?? "N/A")", forHTTPHeaderField: "Authorization")
//            
//            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
//                guard let data = data else {
//                    print("invalid data")
//                    return
//                }
//                
//                let responseStr: String = String(data: data, encoding: .utf8) ?? ""
//                print(responseStr)
//            }
//            .resume()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//    
//    
//    func NetwrokMonitoring() {
//        monitor.pathUpdateHandler = { path in
//            if path.status == .satisfied {
//                self.isConnected = true
//            } else if path.status == .requiresConnection {
//                self.isConnected = false
//            }
//        }
//        monitor.start(queue: queue)
//    }
//    
//    func uploadDisplayImage(image: UIImage, name: String) {
//        images = image
//       
//       guard let imageData = image.jpegData(compressionQuality: 1.0) else {
//           print("failed to convert image")
//           return
//       }
//        let parameters = [
//            
//            "name": name,
//            
//            
//        ]
//        
//        let headers: [String: String] = [
//          "Authorization": "Bearer \(FLUserJourney.shared.authRegistrationToken ?? "")",
//          "content-type": "multipart/form-data; boundary=---011000010111000001101001"
//        ]
//        let httpHeaders = HTTPHeaders.init(headers)
////        AF.upload(multipartFormData: { multipartFormData in
////            
////            //Parameter for Upload files
////            
////            multipartFormData.append(imgData, withName: "file",fileName: "imagename.png" , mimeType: "image/png")
////            
////            for (key, value) in parameters
////                    
////            {
////                
////                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
////                
////            }
//       
//       AF.upload(multipartFormData: { multipartFormData in
//           
//           multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
//           for (key, value) in parameters {
//               multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//           }
//           print("Image -->", imageData.count)
////           multipartFormData.append(DisplayNameAndImageRequest(name: name).name.data(using: .utf8) ?? Data(), withName: "name")
//       }, to: "https://api.fellasloaded.com/api/user/update/", method: .patch, headers: httpHeaders)
//       .response { [weak self] response in
//           guard let self = self else { return }
//           print("Response -->", response.result)
//           
//           guard response.error == nil else {
//               print("No Data found")
//               return
//           }
//           
//           guard let responseData = response.response,
//               (200...299).contains(responseData.statusCode) else {
//               print("Error")
//               return
//           }
//           print(responseData)
//       }
//       
//    }
    
//    func UPLOD()
//    
//    {
//        
//        //Parameter HERE
//        
//        let parameters = [
//            
//            "id": "1221",
//            
//            "docsFor" : "wqww"
//            
//        ]
//        
//        //Header HERE
//        
//        let headers: HTTPHeaders = [
//            
//            "token" : "W2Y3TUYS0RR13T3WX2X4QPRZ4ZQVWPYQ",
//            
//            "Content-type": "multipart/form-data",
//            
//            "Content-Disposition" : "form-data"
//            
//        ]
//        
//        let image = UIImage.init(named: "imagename")
//        
//        let imgData = UIImageJPEGRepresentation(image!, 0.7)!
//        
//        AF.upload(multipartFormData: { multipartFormData in
//            
//            //Parameter for Upload files
//            
//            multipartFormData.append(imgData, withName: "file",fileName: "imagename.png" , mimeType: "image/png")
//            
//            for (key, value) in parameters
//                    
//            {
//                
//                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//                
//            }
//            
//        }, usingThreshold:UInt64.init(),
//                         
//                         to: "http:API-for-url-her", //URL Here
//                         
//                         method: .post,
//                         
//                         headers: headers, //pass header dictionary here
//                         
//                         encodingCompletion: { (result) in
//            
//            switch result {
//                
//            case .success(let upload, _, _):
//                
//                print("the status code is :")
//                
//                upload.uploadProgress(closure: { (progress) in
//                    
//                    print("something")
//                    
//                })
//                
//                upload.responseJSON { response in
//                    
//                    print("the resopnse code is : \(response.response?.statusCode)")
//                    
//                    print("the response is : \(response)")
//                    
//                }
//                
//                break
//                
//            case .failure(let encodingError):
//                
//                print("the error is : \(encodingError.localizedDescription)")
//                
//                break
//                
//            }
//            
//        })
//        
//    }
}
