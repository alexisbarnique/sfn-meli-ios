//
//  ArticleDetail.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//

import SwiftUI

struct ArticleDetail: View {
    @StateObject private var viewModel = ArticlesViewModel()
    var id: String
    
    var body: some View {
        let article = viewModel.article
        ScrollView {
            if let article = viewModel.article {
                HeaderImageArticle(article: article)
                    .frame(height: 200)
            

                VStack(alignment: .leading) {
                    Text(article.publishedAt)
                        .font(.caption)
                        .padding(.bottom, 20)
                    
                    Text(article.summary)
                        .font(.body)
                        .padding(.bottom, 20)
                    
                    Divider()
                    Spacer()
                    
                    if let link = URL(string: article.url) {
                        HStack(alignment: .center) {
                            Spacer()
                            Link("Open Website", destination: link)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .padding()
                            Spacer()
                        }
                    }
                    
                }
                .padding()
            
            }
        }
        .navigationTitle(article?.newsSite ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadArticle(id: id)
        }
    }
}
