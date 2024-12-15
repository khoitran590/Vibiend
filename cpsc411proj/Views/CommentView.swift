//
//  CommentView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/7/24.
//

import SwiftUI

struct CommentView: View {
    let comment: Comment
    let post: Post
    let viewModel: FeedViewModel
    @State private var isEditing = false
    @State private var editedContent: String = ""
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                Image(systemName: comment.author.profileImage)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(comment.author.displayName)
                            .fontWeight(.semibold)
                        Text(comment.author.username)
                            .foregroundColor(.gray)
                        if comment.isEdited {
                            Text("(edited)")
                                .foregroundColor(.gray)
                                .italic()
                        }
                        Spacer()
                        
                        // Show edit/delete options for user's own comments
                        if comment.author.username == viewModel.currentUser.username {
                            Menu {
                                Button(action: {
                                    editedContent = comment.content
                                    isEditing = true
                                }) {
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                                Button(role: .destructive, action: {
                                    showingDeleteAlert = true
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    if isEditing {
                        TextField("Edit comment", text: $editedContent)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .submitLabel(.done)
                            .onSubmit {
                                viewModel.editComment(comment, in: post, newContent: editedContent)
                                isEditing = false
                            }
                    } else {
                        Text(comment.content)
                    }
                    
                    Text(comment.timestamp, style: .relative)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)
        }
        .alert("Delete Comment", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                viewModel.deleteComment(comment, from: post)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this comment?")
        }
    }
}
