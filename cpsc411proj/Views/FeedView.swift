//
//  FeedView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/2/24.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    @State private var showNewPostSheet = false
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                PostCell(post: post,
                        viewModel: viewModel,
                        onLikeTapped: {
                            viewModel.toggleLike(for: post)
                        })
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showNewPostSheet.toggle() }) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $showNewPostSheet) {
                NewPostView(viewModel: viewModel)
            }
        }
    }
}
