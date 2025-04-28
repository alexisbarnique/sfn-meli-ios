//
//  ArticleDetail.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//
//  A view showing the details for an article.

import SwiftUI

struct ArticleDetail: View {
    @StateObject var viewModel: ArticlesViewModel
    var id: String
    
    var body: some View {
        let article = viewModel.article
        ZStack {
            switch viewModel.state {
            case .success:
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
            case .loading:
                ProgressView()
            case .error(let error):
                VStack {
                    Text("Cant show this article in this moment, Please retry!")
                        .font(.title)
                    Text(error)
                        .font(.footnote)
                    Button(action: {
                        viewModel.loadArticle(id: id)
                    }) {
                        Text("Retry")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }.onAppear {
            viewModel.loadArticle(id: id)
        }
    }
}
