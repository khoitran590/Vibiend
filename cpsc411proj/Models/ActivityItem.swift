//
//  ActivityItem.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/11/24.
//

import Foundation

enum ActivityType {
    case newPost
    case newFriend
    case liked
    case commented
    case shared
    
    var icon: String {
        switch self {
        case .newPost: return "square.and.pencil"
        case .newFriend: return "person.badge.plus"
        case .liked: return "heart.fill"
        case .commented: return "bubble.right"
        case .shared: return "square.and.arrow.up"
        }
    }
}

struct ActivityItem: Identifiable {
    let id = UUID()
    let user: User
    let type: ActivityType
    let timestamp: Date
    let content: String
    let relatedPost: Post?
    
    // For displaying relative time
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
}
