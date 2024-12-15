//
//  VibeSelectionView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/9/24.
//

import SwiftUI

struct VibeSelectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedVibe: VibeType?
    @State private var showingFoodVibe = false
    
    var body: some View {
        NavigationView {
            List(VibeType.allCases, id: \.self) { vibe in
                Button(action: {
                    selectedVibe = vibe
                    if vibe == .food {
                        showingFoodVibe = true
                    }
                }) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: vibe.icon)
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(vibe.rawValue)
                                .font(.headline)
                            
                            Text(vibe.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Choose Your Vibe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showingFoodVibe) {
            FoodVibeView()
        }
    }
}
