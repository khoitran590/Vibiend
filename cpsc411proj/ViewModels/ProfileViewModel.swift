//
//  ProfileViewModel.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/5/24.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var isEditingProfile = false
    @Published var tempBio: String = ""
    @Published var selectedImage: String = "person.circle.fill"
    
    private let availableImages = [
        "person.circle.fill",
        "person.crop.circle.fill",
        "person.fill",
        "star.circle.fill",
        "heart.circle.fill",
        "moon.circle.fill",
        "sun.max.circle.fill",
        "cloud.sun.circle.fill"
    ]
    
    init() {
        // Initialize with default user
        self.user = User(
            username: "@johndoe",
            displayName: "John Doe",
            profileImage: "person.circle.fill",
            followers: 1000,
            following: 500,
            bio: "Swift Developer | iOS Enthusiast"
        )
        self.tempBio = user.bio
        self.selectedImage = user.profileImage
    }
    
    func getAvailableImages() -> [String] {
        return availableImages
    }
    
    func updateProfile() {
        var updatedUser = user
        updatedUser.bio = tempBio
        updatedUser.profileImage = selectedImage
        user = updatedUser
        isEditingProfile = false
    }
    
    func cancelEditing() {
        tempBio = user.bio
        selectedImage = user.profileImage
        isEditingProfile = false
    }
}
