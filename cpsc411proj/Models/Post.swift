//
//  Post.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/2/24.
//

import Foundation
import SwiftUI

struct Post: Identifiable {
    let id = UUID()
    let author: User
    var content: String
    let timestamp: Date
    var likes: Int
    var isLiked: Bool
    var replies: [Post]
    var comments: [Comment]
    var image: UIImage?  
}
