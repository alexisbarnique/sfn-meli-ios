//
//  ArticleRow.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//

import SwiftUI
import Kingfisher

struct ArticleRow: View {
    var article: Article

    var body: some View {
        HStack {
            KFImage.url(URL(string:article.imageURL))
                .resizable()
                .frame(width: 50, height: 50)
            Text(article.title)
            
            Spacer()
        }
    }
}
