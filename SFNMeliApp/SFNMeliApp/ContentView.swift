//
//  ContentView.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 23/04/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArticlesViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button {
                viewModel.loadArticles()
            } label: {
                Text("Articles")
            }
            
        }
        .padding()
//        .onAppear {
//            viewModel.loadArticles()
//        }
    }
}

#Preview {
    ContentView()
}
