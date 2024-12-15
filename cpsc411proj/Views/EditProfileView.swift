//
//  EditProfileView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/5/24.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Current Profile Image
                    Image(systemName: viewModel.selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .padding()
                    
                    // Profile Image Selection
                    Text("Choose Profile Picture")
                        .font(.headline)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.getAvailableImages(), id: \.self) { imageName in
                            Image(systemName: imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(viewModel.selectedImage == imageName ? .blue : .gray)
                                .padding(8)
                                .background(
                                    Circle()
                                        .stroke(viewModel.selectedImage == imageName ? Color.blue : Color.clear, lineWidth: 2)
                                )
                                .onTapGesture {
                                    viewModel.selectedImage = imageName
                                }
                        }
                    }
                    .padding()
                    
                    // Bio Editor
                    VStack(alignment: .leading) {
                        Text("Bio")
                            .font(.headline)
                        
                        TextEditor(text: $viewModel.tempBio)
                            .frame(height: 100)
                            .padding(4)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.cancelEditing()
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.updateProfile()
                        dismiss()
                    }
                }
            }
        }
    }
}
