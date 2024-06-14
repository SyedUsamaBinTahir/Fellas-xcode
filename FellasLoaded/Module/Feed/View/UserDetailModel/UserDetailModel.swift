// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userDetailModel = try? JSONDecoder().decode(UserDetailModel.self, from: jsonData)

import Foundation

// MARK: - UserDetailModel
struct UserDetailModel: Codable {
    let uid, name, surname, email: String
    let phone: String?
    let avatar, avatarCompressed: String?
    let streak: Streak?
    let streakProgress: StreakProgress
    let isEmailVerified, isPhoneVerified: Bool
    let stripeID: String
    let isPaymentMethodAdded, isSubscribed: Bool
    let subscriptionType: String?
    let subObject: SubObject?
    let activeTopic: ActiveTopic?
    let notificationSettings: [String: Bool]
    let pushID: String
    let sendPushNotifications: Bool

    enum CodingKeys: String, CodingKey {
        case uid, name, surname, email, phone, avatar
        case avatarCompressed = "avatar_compressed"
        case streak
        case streakProgress = "streak_progress"
        case isEmailVerified = "is_email_verified"
        case isPhoneVerified = "is_phone_verified"
        case stripeID = "stripe_id"
        case isPaymentMethodAdded = "is_payment_method_added"
        case isSubscribed = "is_subscribed"
        case subscriptionType = "subscription_type"
        case subObject = "sub_object"
        case activeTopic = "active_topic"
        case notificationSettings = "notification_settings"
        case pushID = "push_id"
        case sendPushNotifications = "send_push_notifications"
    }
}

// MARK: - ActiveTopic
struct ActiveTopic: Codable {
    let isConfessSubmitted, isViewed, isActive: Bool

    enum CodingKeys: String, CodingKey {
        case isConfessSubmitted = "is_confess_submitted"
        case isViewed = "is_viewed"
        case isActive = "is_active"
    }
}

// MARK: - Streak
struct Streak: Codable {
    let uid, title, crownType: String
    let isActive: Bool
    let totalMonths: Int
    let isAchieved: Bool
    let image: String

    enum CodingKeys: String, CodingKey {
        case uid, title
        case crownType = "crown_type"
        case isActive = "is_active"
        case totalMonths = "total_months"
        case isAchieved = "is_achieved"
        case image
    }
}

// MARK: - StreakProgress
struct StreakProgress: Codable {
    let current, goal: Int
    let nextStreak: Streak

    enum CodingKeys: String, CodingKey {
        case current, goal
        case nextStreak = "next_streak"
    }
}

// MARK: - SubObject
struct SubObject: Codable {
    let expiresAt: String
    let createdAt: String
    let isCanceled: Bool
    let plan: String
    let amount: Double

    enum CodingKeys: String, CodingKey {
        case expiresAt = "expires_at"
        case createdAt = "created_at"
        case isCanceled = "is_canceled"
        case plan, amount
    }
}
