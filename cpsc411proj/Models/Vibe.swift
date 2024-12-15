//
//  Vibe.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/9/24.
//

import Foundation

enum VibeType: String, CaseIterable {
    case music = "Music"
    case food = "Food"
    case activity = "Activity"
    case justChatting = "Just Chatting"
    case therapy = "Therapy"
    
    var icon: String {
        switch self {
        case .music: return "music.note"
        case .food: return "fork.knife"
        case .activity: return "figure.run"
        case .justChatting: return "bubble.left.and.bubble.right"
        case .therapy: return "heart.circle"
        }
    }
    
    var description: String {
        switch self {
        case .music: return "Share and discover music with others"
        case .food: return "Find food recommendations and share experiences"
        case .activity: return "Find people for activities and hobbies"
        case .justChatting: return "Connect and chat with others"
        case .therapy: return "Get support and share experiences"
        }
    }
}
