//
//  FriendsViewModel.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/11/24.
//

import Foundation

class FriendsViewModel: ObservableObject {
    @Published var friends: [User] = []
    @Published var suggestedFriends: [User] = []
    @Published var searchResults: [User] = []
    @Published var activityFeed: [ActivityItem] = []
    @Published var isSearching = false
    
    init() {
        loadSampleData()
    }
    
    private func loadSampleData() {
        // Sample friends
        friends = [
            User(username: "@sarah_dev",
                 displayName: "Sarah Wilson",
                 profileImage: "person.circle.fill",
                 followers: 342,
                 following: 267,
                 bio: "iOS Developer | Coffee Lover",
                 isFriend: true),
            User(username: "@mike_swift",
                 displayName: "Mike Johnson",
                 profileImage: "person.circle.fill",
                 followers: 521,
                 following: 403,
                 bio: "SwiftUI Enthusiast",
                 isFriend: true),
            User(username: "@lisa_code",
                 displayName: "Lisa Chen",
                 profileImage: "person.circle.fill",
                 followers: 892,
                 following: 445,
                 bio: "Full Stack Developer | Tech Blogger",
                 isFriend: true),
            User(username: "@david_tech",
                 displayName: "David Brown",
                 profileImage: "person.circle.fill",
                 followers: 673,
                 following: 389,
                 bio: "Mobile Developer | Coffee Addict",
                 isFriend: true)
        ]
        
        // Sample suggested friends
        suggestedFriends = [
            User(username: "@emma_code",
                 displayName: "Emma Davis",
                 profileImage: "person.circle.fill",
                 followers: 234,
                 following: 198,
                 bio: "Full Stack Developer",
                 isFriend: false),
            User(username: "@alex_tech",
                 displayName: "Alex Thompson",
                 profileImage: "person.circle.fill",
                 followers: 432,
                 following: 345,
                 bio: "Tech Enthusiast | Gamer",
                 isFriend: false)
        ]
        
        loadSampleActivityFeed()
    }
    
    private func loadSampleActivityFeed() {
        let swiftUIPost = Post(author: friends[0],
                             content: "Just finished building my first iOS app with SwiftUI! The learning curve was worth it. Who else is loving SwiftUI? 🚀 #SwiftUI #iOSDev",
                             timestamp: Date().addingTimeInterval(-3600),
                             likes: 45,
                             isLiked: false,
                             replies: [],
                             comments: [],
                             image: nil)
        
        let coffeePost = Post(author: friends[3],
                            content: "Found this amazing new coffee shop downtown! Perfect coding spot with great wifi and even better espresso ☕️ #CodingLife #CoffeeLover",
                            timestamp: Date().addingTimeInterval(-7200),
                            likes: 28,
                            isLiked: false,
                            replies: [],
                            comments: [],
                            image: nil)
        
        let techEventPost = Post(author: friends[2],
                               content: "Amazing tech conference today! Met so many brilliant developers and learned about the future of AI in mobile development. Can't wait to implement these new ideas! 🤖 #TechConference #AI",
                               timestamp: Date().addingTimeInterval(-14400),
                               likes: 89,
                               isLiked: false,
                               replies: [],
                               comments: [],
                               image: nil)
        
        let debuggingPost = Post(author: friends[1],
                               content: "Pro tip: Spent 2 hours debugging only to find it was a missing semicolon. Sometimes the simplest bugs are the hardest to find 😅 #Programming #DebuggingLife",
                               timestamp: Date().addingTimeInterval(-28800),
                               likes: 156,
                               isLiked: false,
                               replies: [],
                               comments: [],
                               image: nil)
        
        activityFeed = [
            ActivityItem(user: friends[0],
                        type: .newPost,
                        timestamp: Date().addingTimeInterval(-3600),
                        content: "Shared a new post about SwiftUI development",
                        relatedPost: swiftUIPost),
            
            ActivityItem(user: friends[3],
                        type: .newPost,
                        timestamp: Date().addingTimeInterval(-7200),
                        content: "Found a new coding-friendly coffee spot",
                        relatedPost: coffeePost),
            
            ActivityItem(user: friends[1],
                        type: .liked,
                        timestamp: Date().addingTimeInterval(-10800),
                        content: "Liked Sarah's SwiftUI post",
                        relatedPost: swiftUIPost),
            
            ActivityItem(user: friends[2],
                        type: .newPost,
                        timestamp: Date().addingTimeInterval(-14400),
                        content: "Shared insights from today's tech conference",
                        relatedPost: techEventPost),
            
            ActivityItem(user: friends[0],
                        type: .commented,
                        timestamp: Date().addingTimeInterval(-18000),
                        content: "Commented: 'Great find! Need to check this place out!' on David's coffee shop post",
                        relatedPost: coffeePost),
            
            ActivityItem(user: friends[1],
                        type: .newPost,
                        timestamp: Date().addingTimeInterval(-28800),
                        content: "Shared a debugging story",
                        relatedPost: debuggingPost),
            
            ActivityItem(user: friends[2],
                        type: .liked,
                        timestamp: Date().addingTimeInterval(-32400),
                        content: "Liked Mike's debugging post",
                        relatedPost: debuggingPost),
            
            ActivityItem(user: friends[3],
                        type: .newFriend,
                        timestamp: Date().addingTimeInterval(-86400),
                        content: "Became friends with Lisa Chen",
                        relatedPost: nil)
        ]
    }
    
    // Rest of the methods remain the same...
    func searchUsers(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        searchResults = suggestedFriends.filter {
            $0.username.localizedCaseInsensitiveContains(query) ||
            $0.displayName.localizedCaseInsensitiveContains(query)
        }
    }
    
    func toggleFriend(_ user: User) {
        if let index = friends.firstIndex(where: { $0.id == user.id }) {
            friends.remove(at: index)
            suggestedFriends.append(user)
            
            let activity = ActivityItem(user: user,
                                     type: .newFriend,
                                     timestamp: Date(),
                                     content: "Removed from friends",
                                     relatedPost: nil)
            activityFeed.insert(activity, at: 0)
        } else if let index = suggestedFriends.firstIndex(where: { $0.id == user.id }) {
            var updatedUser = user
            updatedUser.isFriend = true
            friends.append(updatedUser)
            suggestedFriends.remove(at: index)
            
            let activity = ActivityItem(user: updatedUser,
                                     type: .newFriend,
                                     timestamp: Date(),
                                     content: "Became friends",
                                     relatedPost: nil)
            activityFeed.insert(activity, at: 0)
        }
    }
}
