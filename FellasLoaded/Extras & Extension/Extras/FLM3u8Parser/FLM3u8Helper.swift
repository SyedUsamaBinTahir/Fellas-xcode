//
//  FLM3u8Helper.swift
//  FellasLoaded
//
//  Created by Syed Usama on 11/07/2024.
//

import Foundation
import Combine
import SwiftUI
import AVKit

struct FLM3U8Parser {
    static func fetchM3U8(url: URL) -> AnyPublisher<[String], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .map { data -> [String] in
                guard let content = String(data: data, encoding: .utf8) else { return [] }
                return parseM3U8(content: content)
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    private static func parseM3U8(content: String) -> [String] {
        let lines = content.split(separator: "\n")
        var resolutions = [String]()

        for line in lines {
            if line.hasPrefix("#EXT-X-STREAM-INF") {
                if let resolution = line.split(separator: ",").first(where: { $0.contains("RESOLUTION") }) {
                    if let res = resolution.split(separator: "=").last {
                        let height = res.split(separator: "x").last?.trimmingCharacters(in: .whitespaces) ?? ""
                        if !height.isEmpty {
                            resolutions.append("\(height)")
                        }
                    }
                }
            }
        }
        return resolutions
    }
}
