//
//  HeaderArticle.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 26/04/2025.
//

import SwiftUI

struct HeaderImageArticle: View {
    var article: Article

    var body: some View {
        AsyncImage(url: URL(string: article.imageURL)) { image in
            image.resizable()
                .overlay {
                    TextOverlay(article: article)
                }
        } placeholder: {
            Color.gray
                .overlay {
                    TextOverlay(article: article)
                }
        }
    }
}

struct TextOverlay: View {
    var article: Article

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.title)
                    .bold()
                Text(article.newsSite)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}

