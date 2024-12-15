//
//  ProfileView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/2/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var feedViewModel = FeedViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var showingEditProfile = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Profile Header
                    VStack(alignment: .leading, spacing: 12) {
                        // Profile Image
                        Image(systemName: profileViewModel.user.profileImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.blue)
                        
                        Text(profileViewModel.user.displayName)
                            .font(.title2)
                            .bold()
                        
                        Text(profileViewModel.user.username)
                            .foregroundColor(.gray)
                        
                        Text(profileViewModel.user.bio)
                            .padding(.vertical, 4)
                        
                        HStack(spacing: 24) {
                            Text("\(profileViewModel.user.following) Following")
                            Text("\(profileViewModel.user.followers) Followers")
                        }
                        .foregroundColor(.gray)
                    }
                    .padding()
                    
                    // Edit Profile Button
                    Button(action: { showingEditProfile = true }) {
                        HStack {
                            Text("Edit Profile")
                                .fontWeight(.semibold)
                            Image(systemName: "pencil")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                    
                    Divider()
                    
                    // User's posts
                    ForEach(feedViewModel.posts) { post in
                        PostCell(post: post,
                               viewModel: feedViewModel,
                               onLikeTapped: {
                                   feedViewModel.toggleLike(for: post)
                               })
                            .padding()
                        Divider()
                    }
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView(viewModel: profileViewModel)
            }
        }
    }
}
