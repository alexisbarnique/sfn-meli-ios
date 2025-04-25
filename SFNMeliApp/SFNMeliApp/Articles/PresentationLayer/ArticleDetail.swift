//
//  ArticleDetail.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//

import SwiftUI
import Kingfisher

struct ArticleDetail: View {
//    @Environment(ModelData.self) var modelData
    var article: Article

//    var landmarkIndex: Int {
//        modelData.landmarks.firstIndex(where: { $0.id == landmark.id })!
//    }

    var body: some View {
//        @Bindable var modelData = modelData
        let imageUrl = URL(string: article.imageURL)
        ScrollView {
//            MapView(coordinate: landmark.locationCoordinate)
//                .frame(height: 300)
            
            KFImage(imageUrl)
                .resizable()
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(article.title)
                        .font(.title)
                }

                HStack {
                    Text(article.newsSite)
                    Spacer()
                    Text(article.summary)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text("About \(article.featured)")
                    .font(.title2)
                Text(article.publishedAt)
            }
            .padding()
        }
        .navigationTitle(article.url)
        .navigationBarTitleDisplayMode(.inline)
    }
}
