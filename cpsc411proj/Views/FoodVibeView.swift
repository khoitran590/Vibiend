//
//  FoodVibeView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/9/24.
//

import SwiftUI

struct FoodVibeView: View {
    @StateObject private var viewModel = RecipeViewModel()
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Search bar
                    SearchBar(text: $searchText, placeholder: "Search recipes...")
                        .padding()
                        .onChange(of: searchText) { newValue in
                            if !newValue.isEmpty {
                                viewModel.fetchRecipes(query: newValue)
                            }
                        }
                    
                    if viewModel.isLoading {
                        ProgressView("Loading recipes...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let error = viewModel.errorMessage {
                        VStack {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                            Text(error)
                                .multilineTextAlignment(.center)
                                .padding()
                            Button("Try Again") {
                                viewModel.fetchRecipes()
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.recipes) { recipe in
                                    RecipeCard(recipe: recipe)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Food Vibe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchRecipes()
        }
    }
}

// Search Bar Component
struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

// Recipe Card Component
struct RecipeCard: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            // Recipe Image
            AsyncImage(url: URL(string: recipe.image)) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .aspectRatio(16/9, contentMode: .fit)
                        .overlay(ProgressView())
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(16/9, contentMode: .fit)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .aspectRatio(16/9, contentMode: .fit)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        )
                @unknown default:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .aspectRatio(16/9, contentMode: .fit)
                }
            }
            .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(recipe.title)
                    .font(.headline)
                    .lineLimit(2)
                
                HStack {
                    if let readyInMinutes = recipe.readyInMinutes {
                        Label("\(readyInMinutes) min", systemImage: "clock")
                    }
                    Spacer()
                    if let servings = recipe.servings {
                        Label("\(servings) servings", systemImage: "person.2")
                    }
                }
                .font(.caption)
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
