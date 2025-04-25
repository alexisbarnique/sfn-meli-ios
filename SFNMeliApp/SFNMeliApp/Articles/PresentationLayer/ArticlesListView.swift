//
//  ArticlesListView.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 24/04/2025.
//

import SwiftUI

struct ArticlesListView: View {
    @StateObject private var viewModel = ArticlesViewModel()

    var body: some View {
        VStack {
            
            if viewModel.isLoading {
                ProgressView("Loading...") // Loading indicator
            } else if let errorMessage = viewModel.errorMessage {
                // Error message view
                VStack {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Retry") {
                        viewModel.loadArticles()
                    }
                }
            } else {
                // List of articles
                ForEach(viewModel.articles) { art in
                    VStack(alignment: .leading) {
                        Text(art.title)
                            .font(.headline)
                        Text(art.summary)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
            }
        
        }
        .background(Color.green)
        .onAppear {
            viewModel.loadArticles() // Load data when the view appears
        }
        
    }
}

#Preview {
    ArticlesListView()
}
