//
//  VaultViewModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 04/07/2024.
//

import Foundation
import Combine

protocol VaultDataProvider {
    func vaultPostDetails()
    func vaultCommentsDetails(postId: String, commentOrderBy: String)
    func vaultCommentsReply(commentId: String)
    func vaultCreateComment(comment: String, post: String)
    func vaultCreateReply(comment: String, post: String, parent: String, reply_to: String)
    func vaultPostLike(postId: String)
    func vaultPostDislike(postId: String)
    func vaultCommentLike(commentId: String)
    func vaultCommentDislike(commentId: String)
    func vaultDeleteComment(commentId: String)
    func vaultEditComment(commentId: String, comment: String)
}

class VaultViewModel: ObservableObject {
    private let dataService: DataServiceBased
    
    init(_dataService: DataServiceBased) {
        self.dataService = _dataService
    }
    
    var subscription = Set<AnyCancellable>()
    
    // show loader
    @Published var showLoader = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var onTap = false
    // for comment status change
//    @Published var isRecieved: Bool = false
//    @Published var commentAdded: Bool = false
//    @Published var replyAdded: Bool = false
//    @Published var isLike: Bool = false
//    @Published var isCommentLike = false
//    @Published var isDeleted = false
    @Published var isSuccess = false
    
    var vaulPostModel: VaultPostModel?
    var vaultCommentsModel: VaultCommentsModel?
    var vaultCommentReplyModel: SeriesEpisodesCommentsDetailModel?
}


extension VaultViewModel : VaultDataProvider {
    
    func vaultPostDetails() {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.vaultPost, type: VaultPostModel.self)
            .sink { [weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("success")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { VaultPostModelData in
                self.vaulPostModel = VaultPostModelData
            }
            .store(in: &subscription)
    }
    
    func vaultCommentsDetails(postId: String, commentOrderBy: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.vaultComments + postId + "/?order_by=\(commentOrderBy)", type: VaultCommentsModel.self)
            .sink {[weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished :
                        print("SUCCESS")
                        self?.showLoader = false
                    }
                }
            } receiveValue: { VaultCommentsModelData in
                self.vaultCommentsModel = VaultCommentsModelData
                print("RESPONSE ---->  \(VaultCommentsModelData)")
            }
            .store(in: &subscription)
    }
    
    func vaultCommentsReply(commentId: String) {
        dataService.getServerData(url: FLAPIs.baseURL + FLAPIs.vaultCommentsReply + "\(commentId)/" , type: SeriesEpisodesCommentsDetailModel.self)
            .sink {[weak self] completion in
                DispatchQueue.main.async {
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showAlert = true
                        self?.alertMessage = error.localizedDescription
                        self?.showLoader = false
                    case .finished:
                        print("SUCCESS")
                        self?.showLoader = false
                        self?.isSuccess = true
                    }
                }
            } receiveValue: { VaultCommentReplyModelData in
                self.vaultCommentReplyModel = VaultCommentReplyModelData
                print(VaultCommentReplyModelData)
            }
            .store(in: &subscription)
    }
    
    func vaultCreateComment(comment: String, post: String) {
        VaultCommentApiService.shared.vaultAddComment(comment: comment, post: post)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("SUCCESS")
                    self?.showLoader = false
                    self?.alertMessage = "Comment Added"
                    self?.showAlert = true
                    self?.isSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
    
    func vaultCreateReply(comment: String, post: String, parent: String, reply_to: String) {
        VaultCommentApiService.shared.vaultCommentReply(comment: comment, post: post, parent: parent, replyTto: reply_to)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("SUCCESS")
                    self?.showLoader = false
                    self?.showAlert = true
                    self?.alertMessage = "Reply Added"

                    self?.isSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
    
    func vaultPostLike(postId: String) {
        VaultPostLikeApiService.shared.vaultPostLike(postId: postId)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("SUCCESS")
                    self?.showLoader = false
                    self?.isSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
    
    func vaultPostDislike(postId: String) {
        VaultPostDislikeApiService.shared.vaultPostDislike(postId: postId)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                    
                case .finished:
                    print("SUCCESS")
                    self?.showLoader = false
                    self?.isSuccess = false
                }
                
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
    
    func vaultCommentLike(commentId: String) {
        VaultLikeCommentApiService.shared.vaultLikeComment(commentId: commentId)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                    
                case .finished:
                    print("SUCCESS")
                    self?.showLoader = false
                    self?.isSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
    
    func vaultCommentDislike(commentId: String) {
        VaultCommentDislikeApiService.shared.vaultCommentDislike(commentId: commentId)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion  in
                switch completion {
                case .failure(let error):
                    print("error", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("SUCCESS")
                    self?.showLoader = false
                    self?.isSuccess = false
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
    
    func vaultDeleteComment(commentId: String) {
        VaultDeleteCommentApiService.shared.vaultDeleteComment(commentId: commentId)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case .finished:
                    print("COMMENT DELETE SUCCESS")
                    self?.showLoader = false
                    self?.alertMessage = "Comment Deleted"
                    self?.showAlert = true
                    self?.isSuccess = true
                }
                 
                
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
    
    func vaultEditComment(commentId: String, comment: String) {
        VaultEditCommentApiService.shared.vaultEditComment(commentId: commentId, comment: comment)
            .receive(on: DispatchQueue.main)
            .sink{[weak self] completion in
                switch completion {
                case .failure(let error):
                    print("error", error.localizedDescription)
                    DispatchQueue.main.async {
                        self?.alertMessage = error.localizedDescription
                        self?.showAlert = true
                        self?.showLoader = false
                    }
                case.finished:
                    print("COMMENT EDITED SUCCESSFULLy")
                    self?.showLoader = false
                    self?.alertMessage = "Edited Successfully"
                    self?.showAlert = true
                    self?.isSuccess = true
                }
            } receiveValue: { _ in
                
            }
            .store(in: &self.subscription)
    }
    
}
