//
//  ArticleRow.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//
//  A single row to be displayed in a list of articles.

import SwiftUI

struct ArticleRow: View {
    var article: Article

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: article.imageURL)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .clipShape(.rect(cornerRadius: 10))
            Text(article.title)
                .accessibilityIdentifier("listItem_\(article.title)")
            Spacer()
        }
    }
}
