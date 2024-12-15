//
//  RecipeViewModel.swift
//  cpsc411proj
//
//  Created by Peter Tran on 12/9/24.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiKey = "88f4b6d609mshf130b82cf4778f5p15a889jsn0ca5697cb566"
    private let baseURL = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    
    func fetchRecipes(query: String = "side salad") {
        isLoading = true
        errorMessage = nil
        
        // Create URL components
        guard let url = URL(string: "\(baseURL)/recipes/complexSearch") else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }
        
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Add headers
        request.addValue("88f4b6d609mshf130b82cf4778f5p15a889jsn0ca5697cb566", forHTTPHeaderField: "X-RapidAPI-Key")
        request.addValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "X-RapidAPI-Host")
        
        // Add query parameters
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "number", value: "10")
        ]
        
        if let finalURL = components?.url {
            request.url = finalURL
        }
        
        print("Fetching URL: \(request.url?.absoluteString ?? "nil")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    print("Network error: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self?.errorMessage = "Invalid response type"
                    return
                }
                
                print("Response status code: \(httpResponse.statusCode)")
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                // Print raw response for debugging
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Raw response: \(responseString)")
                }
                
                do {
                    let decoder = JSONDecoder()
                    let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                    self?.recipes = recipeResponse.results
                    print("Successfully decoded \(recipeResponse.results.count) recipes")
                } catch {
                    self?.errorMessage = "Decoding error: \(error.localizedDescription)"
                    print("Decoding error: \(error)")
                    
                    // Additional debug information
                    if let decodingError = error as? DecodingError {
                        switch decodingError {
                        case .dataCorrupted(let context):
                            print("Data corrupted: \(context)")
                        case .keyNotFound(let key, let context):
                            print("Key not found: \(key), context: \(context)")
                        case .typeMismatch(let type, let context):
                            print("Type mismatch: \(type), context: \(context)")
                        case .valueNotFound(let type, let context):
                            print("Value not found: \(type), context: \(context)")
                        @unknown default:
                            print("Unknown decoding error")
                        }
                    }
                }
            }
        }
        
        task.resume()
    }
}
