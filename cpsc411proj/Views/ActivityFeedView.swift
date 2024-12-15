//
//  ActivityFeedView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/11/24.
//

import SwiftUI

struct ActivityFeedView: View {
    @ObservedObject var viewModel: FriendsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.activityFeed) { activity in
                ActivityRow(activity: activity)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct ActivityRow: View {
    let activity: ActivityItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header with user info and time
            HStack {
                Image(systemName: activity.user.profileImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(activity.user.displayName)
                        .font(.headline)
                    Text(activity.timeAgo)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: activity.type.icon)
                    .foregroundColor(.blue)
            }
            
            // Activity content
            Text(activity.content)
                .font(.subheadline)
            
            // Related post if exists
            if let post = activity.relatedPost {
                PostPreview(post: post)
            }
        }
        .padding(.vertical, 4)
    }
}

struct PostPreview: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.content)
                .font(.subheadline)
                .lineLimit(2)
            
            if let image = post.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            HStack(spacing: 16) {
                Label("\(post.likes)", systemImage: "heart")
                Label("\(post.comments.count)", systemImage: "bubble.right")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
