//
//  CommentsView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/7/24.
//

import SwiftUI

struct CommentsView: View {
    let post: Post
    @ObservedObject var viewModel: FeedViewModel
    @State private var newComment: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        // Original post
                        VStack(alignment: .leading, spacing: 8) {
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
                            }
                            
                            Text(post.content)
                                .font(.body)
                        }
                        .padding()
                        
                        Divider()
                        
                        // Comments
                        ForEach(post.comments) { comment in
                            CommentView(comment: comment, post: post, viewModel: viewModel)
                            Divider()
                        }
                    }
                }
                
                // New comment input
                VStack {
                    Divider()
                    HStack {
                        TextField("Add a comment...", text: $newComment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .submitLabel(.send)
                        
                        Button(action: submitComment) {
                            Image(systemName: "arrow.up.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                        }
                        .disabled(newComment.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding()
                }
            }
            .navigationTitle("Comments")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func submitComment() {
        let trimmedComment = newComment.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedComment.isEmpty {
            viewModel.addComment(to: post, content: trimmedComment)
            newComment = ""
        }
    }
}
