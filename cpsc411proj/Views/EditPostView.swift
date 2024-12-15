//
//  EditPostView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/5/24.
//

import SwiftUI

struct EditPostView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var editedContent: String
    let post: Post
    let viewModel: FeedViewModel
    
    init(post: Post, viewModel: FeedViewModel) {
        self.post = post
        self.viewModel = viewModel
        _editedContent = State(initialValue: post.content)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $editedContent)
                    .frame(height: 100)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()
                
                Spacer()
            }
            .navigationTitle("Edit Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.editPost(post, newContent: editedContent)
                        dismiss()
                    }
                    .disabled(editedContent.isEmpty)
                }
            }
        }
    }
}
