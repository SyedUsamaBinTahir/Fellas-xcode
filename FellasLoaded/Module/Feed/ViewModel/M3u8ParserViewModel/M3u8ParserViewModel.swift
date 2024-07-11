//
//  M3u8ParserViewModel.swift
//  FellasLoaded
//
//  Created by Syed Usama on 11/07/2024.
//

import Foundation
import Combine

class M3u8ParserViewModel: ObservableObject {
    @Published var resolutions: [String] = []
    @Published var showSheet = false
    private var cancellables = Set<AnyCancellable>()

    func fetchResolutions(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        FLM3U8Parser.fetchM3U8(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] resolutions in
                self?.resolutions = resolutions
            })
            .store(in: &cancellables)
    }
}
