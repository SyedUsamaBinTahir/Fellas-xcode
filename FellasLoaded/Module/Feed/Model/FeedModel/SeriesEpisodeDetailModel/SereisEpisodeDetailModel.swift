//
//  SereisEpisodeDetailModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 12/06/2024.
//

import Foundation

struct SeriesEpisodeDetailModel: Codable {
    let uid: String
    let series_uid: String
    let series_thumbnail: String
    let session_uid: String
    let title: String
    let is_published: Bool
    let is_visible: Bool
    let playable_from: String
    let release_date: String
    let created_at: String
    let genre: Genre
    let episode_number: Int
    let session_number: Int
    let description: String
    let thumbnail: String
    let bvideo: SeriesBvideo
    let webvtt_file: String
    let main_hosts: [MainHost]
    let special_guests: [SpecialGuest]
    let series: Int
    let reached_episode_time: Int?
    let is_watch_later: Bool
//    let watch_later_added_at
    let comments_count: Int?
}

struct SeriesBvideo: Codable {
    let video_name, video_uid: String
    let length: Int
    let file_size: Double
    let file_ext: String
    let preview_image_url: String
    let created_at: String
    let download_url: String?
    let download_urls: [String: DownloadURL?]?
    let hls_video_playlist_url: String?
}

struct DownloadURL: Codable {
    let url: String
    let size: Double
}

struct MainHost: Codable {
    let id: Int
    let uid: String
    let name: String
    let created_at: String
}

struct SpecialGuest: Codable {
    let id: Int
    let uid: String
    let name: String
    let created_at: String
}
