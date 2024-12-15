//
//  PostCell.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/2/24.
//

import SwiftUI

struct PostCell: View {
    let post: Post
    let viewModel: FeedViewModel
    let onLikeTapped: () -> Void
    @State private var showingEditSheet = false
    @State private var showingDeleteAlert = false
    @State private var showingComments = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Author info
            HStack {
                Image(systemName: post.author.profileImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(post.author.displayName)
                        .font(.headline)
                    Text(post.author.username)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                if post.author.username == viewModel.currentUser.username {
                    Menu {
                        Button(action: { showingEditSheet.toggle() }) {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        Button(action: { showingDeleteAlert.toggle() }) {
                                                    Label("Delete", systemImage: "trash")
                                                        .foregroundColor(.red)
                                                }
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundColor(.gray)
                    }
                }
            }
            
            // Post content
            if !post.content.isEmpty {
                Text(post.content)
                    .font(.body)
            }
            
            // Post image if exists
            if let image = post.image {
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.vertical, 4)
            }
            
            // Engagement buttons
            HStack(spacing: 32) {
                Button(action: onLikeTapped) {
                    HStack {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .foregroundColor(post.isLiked ? .red : .gray)
                        Text("\(post.likes)")
                            .foregroundColor(.gray)
                    }
                }
                
                Button(action: { showingComments.toggle() }) {
                    HStack {
                        Image(systemName: "bubble.right")
                        Text("\(post.comments.count)")
                    }
                    .foregroundColor(.gray)
                }
                
                Button(action: {}) {
                    Image(systemName: "arrow.rectanglepath")
                        .foregroundColor(.gray)
                }
                
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 4)
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $showingEditSheet) {
            EditPostView(post: post, viewModel: viewModel)
        }
        .sheet(isPresented: $showingComments) {
            CommentsView(post: post, viewModel: viewModel)
        }
        .alert("Delete Post", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.deletePost(post)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this post? This action cannot be undone.")
        }
    }
}
