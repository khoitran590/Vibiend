//
//  User.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/2/24.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let username: String
    let displayName: String
    var profileImage: String
    var followers: Int
    var following: Int
    var bio: String
    var isFriend: Bool = false
}
