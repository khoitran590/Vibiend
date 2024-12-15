//
//  SearchView.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/2/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<5) { _ in
                    Text("Trending Topic")
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchText)
        }
    }
}
