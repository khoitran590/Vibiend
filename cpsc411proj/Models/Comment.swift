//
//  Comment.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/7/24.
//

import Foundation

struct Comment: Identifiable {
    let id = UUID()
    let author: User
    var content: String
    let timestamp: Date
    var isEdited: Bool
}
