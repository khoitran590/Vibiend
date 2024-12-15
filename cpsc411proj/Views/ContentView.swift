//
//  ContentView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingVibeSelection = false
    
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            // Vibe Button
            Button(action: {
                showingVibeSelection.toggle()
            }) {
                VStack {
                    Image(systemName: "sparkles")
                        .font(.system(size: 24))
                    Text("Vibe")
                }
            }
            .tabItem {
                Image(systemName: "sparkles")
                Text("Vibe")
            }
            
            FriendsView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Friends")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .sheet(isPresented: $showingVibeSelection) {
            VibeSelectionView()
        }
    }
}
