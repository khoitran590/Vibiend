//
//  FriendsView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/11/24.
//

import SwiftUI

struct FriendsView: View {
    @StateObject private var viewModel = FriendsViewModel()
    @State private var searchText = ""
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack {
                // Custom segmented control
                Picker("View", selection: $selectedTab) {
                    Text("Friends").tag(0)
                    Text("Activity").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedTab == 0 {
                    // Friends List View
                    List {
                        Section(header: Text("Your Friends")) {
                            if viewModel.friends.isEmpty {
                                Text("No friends yet")
                                    .foregroundColor(.gray)
                                    .italic()
                            } else {
                                ForEach(viewModel.friends) { friend in
                                    FriendRow(user: friend, isFriend: true) {
                                        viewModel.toggleFriend(friend)
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("Suggested Friends")) {
                            ForEach(viewModel.suggestedFriends) { user in
                                FriendRow(user: user, isFriend: false) {
                                    viewModel.toggleFriend(user)
                                }
                            }
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search users")
                    .onChange(of: searchText) { oldValue, newValue in
                        viewModel.searchUsers(query: newValue)
                        viewModel.isSearching = !newValue.isEmpty
                    }
                    .overlay {
                        if viewModel.isSearching {
                            List(viewModel.searchResults) { user in
                                FriendRow(user: user, isFriend: user.isFriend) {
                                    viewModel.toggleFriend(user)
                                }
                            }
                            .background(Color(.systemBackground))
                        }
                    }
                } else {
                    // Activity Feed View
                    ActivityFeedView(viewModel: viewModel)
                }
            }
            .navigationTitle(selectedTab == 0 ? "Friends" : "Activity")
        }
    }
}

struct FriendRow: View {
    let user: User
    let isFriend: Bool
    let action: () -> Void
    
    var body: some View {
        HStack {
            // Profile Image
            Image(systemName: user.profileImage)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            // User Info
            VStack(alignment: .leading, spacing: 2) {
                Text(user.displayName)
                    .font(.headline)
                Text(user.username)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Friend/Add Button
            Button(action: action) {
                if isFriend {
                    Label("Remove", systemImage: "person.badge.minus")
                        .foregroundColor(.red)
                } else {
                    Label("Add", systemImage: "person.badge.plus")
                        .foregroundColor(.blue)
                }
            }
            .labelStyle(.iconOnly)
        }
        .padding(.vertical, 4)
    }
}
