//
//  FeedCategoriesModel.swift
//  FellasLoaded
//
//  Created by Phebsoft on 06/06/2024.
//

import Foundation

struct FeedCategoriesModel: Codable {
    let results: [FeedCategoriesResults]
}

struct FeedCategoriesResults: Codable {
    let uid, title, categoryType: String
    let objectsType: ObjectsTypeEnum
    let order: Int
    let results: [CategoriesResults]

    enum CodingKeys: String, CodingKey {
        case uid, title
        case categoryType = "category_type"
        case objectsType = "objects_type"
        case order, results
    }
}

enum ObjectsTypeEnum: String, Codable {
    case episode = "episode"
    case series = "series"
}

// MARK: - ResultResult
struct CategoriesResults: Codable {
    let uid, title: String
    let categoryUUID: String?
    let totalEpisodes, totalSessions: Int?
    let genre: Genre?
    let createdAt: String
    let reachedSession, reachedEpisode: JSONNull?
//    let reachedEpisodeTime: JSONNull?
    let isWatchLater: Bool
    let watchLaterCount: Int?
    let watchLaterAddedAt: JSONNull?
    let isNotificationSubscribed: Bool?
    let coverArt: String?
    let thumbnail: String
    let verticalCoverPhoto: String?
    let horizontalCoverPhoto: String?
    let logo: String?
    let reccommendedType: ObjectsTypeEnum?
    let seriesUid, sessionUid: String?
    let sessionNumber, episodeNumber: Int?
    let description: String?
    let trailer: JSONNull?
    let isPublished, isVisible: Bool?
    let playableFrom, releaseDate: String?
    let bvideo: Bvideo?

    enum CodingKeys: String, CodingKey {
        case uid
        case categoryUUID = "category_uuid"
        case title
        case totalEpisodes = "total_episodes"
        case totalSessions = "total_sessions"
        case genre
        case createdAt = "created_at"
        case reachedSession = "reached_session"
        case reachedEpisode = "reached_episode"
//        case reachedEpisodeTime = "reached_episode_time"
        case isWatchLater = "is_watch_later"
        case watchLaterCount = "watch_later_count"
        case watchLaterAddedAt = "watch_later_added_at"
        case isNotificationSubscribed = "is_notification_subscribed"
        case coverArt = "cover_art"
        case thumbnail
        case verticalCoverPhoto = "vertical_cover_photo"
        case horizontalCoverPhoto = "horizontal_cover_photo"
        case logo, reccommendedType
        case seriesUid = "series_uid"
        case sessionUid = "session_uid"
        case sessionNumber = "session_number"
        case episodeNumber = "episode_number"
        case description, trailer
        case isPublished = "is_published"
        case isVisible = "is_visible"
        case playableFrom = "playable_from"
        case releaseDate = "release_date"
        case bvideo
    }
}

// MARK: - Bvideo
struct Bvideo: Codable {
    let videoName, videoUid: String
    let length: Int
    let fileSize: Double
    let fileEXT: FileEXT
    let previewImageURL: String
    let createdAt: String
    let downloadURL, downloadUrls, hlsVideoPlaylistURL: JSONNull?

    enum CodingKeys: String, CodingKey {
        case videoName = "video_name"
        case videoUid = "video_uid"
        case length
        case fileSize = "file_size"
        case fileEXT = "file_ext"
        case previewImageURL = "preview_image_url"
        case createdAt = "created_at"
        case downloadURL = "download_url"
        case downloadUrls = "download_urls"
        case hlsVideoPlaylistURL = "hls_video_playlist_url"
    }
}

enum FileEXT: String, Codable {
    case mp4 = "mp4"
}

// MARK: - Genre
struct Genre: Codable {
    let uid: String
    let name: Name
    let children: [JSONAny]
    let createdAt: CreatedAt

    enum CodingKeys: String, CodingKey {
        case uid, name, children
        case createdAt = "created_at"
    }
}

enum CreatedAt: String, Codable {
    case the20231103T2056421078200100 = "2023-11-03T20:56:42.107820+01:00"
    case the20231208T1153598383540100 = "2023-12-08T11:53:59.838354+01:00"
    case the20231208T1202598166030100 = "2023-12-08T12:02:59.816603+01:00"
    case the20240229T1856068067950100 = "2024-02-29T18:56:06.806795+01:00"
}

enum Name: String, Codable {
    case cartoons = "Cartoons"
    case podcasts = "Podcasts"
    case special = "Special"
    case studioShows = "Studio Shows"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
