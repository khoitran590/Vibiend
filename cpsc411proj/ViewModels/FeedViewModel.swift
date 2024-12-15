//
//  FeedViewModel.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/2/24.
//

import Foundation
import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    let currentUser = User(username: "@johndoe",
                          displayName: "John Doe",
                          profileImage: "person.circle.fill",
                          followers: 1000,
                          following: 500,
                          bio: "Swift Developer | iOS Enthusiast")
    
    init() {
        loadSamplePosts()
    }
    
    private func loadSamplePosts() {
        posts = [
            Post(author: currentUser,
                 content: "Just launched my first #SwiftUI app! 🚀",
                 timestamp: Date(),
                 likes: 42,
                 isLiked: false,
                 replies: [],
                 comments: [],
                 image: nil)
        ]
    }
    
    func addPost(content: String, image: UIImage? = nil) {
        let newPost = Post(author: currentUser,
                          content: content,
                          timestamp: Date(),
                          likes: 0,
                          isLiked: false,
                          replies: [],
                          comments: [],
                          image: image)
        posts.insert(newPost, at: 0)
    }
    
    func deletePost(_ post: Post) {
        posts.removeAll { $0.id == post.id }
    }
    
    func editPost(_ post: Post, newContent: String) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            var updatedPost = posts[index]
            updatedPost.content = newContent
            posts[index] = updatedPost
        }
    }
    
    func toggleLike(for post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].likes += posts[index].isLiked ? -1 : 1
            posts[index].isLiked.toggle()
        }
    }
    
    func addComment(to post: Post, content: String) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            let newComment = Comment(
                author: currentUser,
                content: content,
                timestamp: Date(),
                isEdited: false
            )
            posts[index].comments.append(newComment)
        }
    }
    
    func editComment(_ comment: Comment, in post: Post, newContent: String) {
        if let postIndex = posts.firstIndex(where: { $0.id == post.id }),
           let commentIndex = posts[postIndex].comments.firstIndex(where: { $0.id == comment.id }) {
            var updatedComment = posts[postIndex].comments[commentIndex]
            updatedComment.content = newContent
            updatedComment.isEdited = true
            posts[postIndex].comments[commentIndex] = updatedComment
        }
    }
    
    func deleteComment(_ comment: Comment, from post: Post) {
        if let postIndex = posts.firstIndex(where: { $0.id == post.id }) {
            posts[postIndex].comments.removeAll { $0.id == comment.id }
        }
    }
}
