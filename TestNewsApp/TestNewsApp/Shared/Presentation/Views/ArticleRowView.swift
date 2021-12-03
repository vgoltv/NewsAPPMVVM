//
//  ArticleRowView.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 01/06/2021.
//

import SwiftUI
import CachedAsyncImage

struct ArticleRowView: View {
    
    let article: Article
    
    var body: some View {
        HStack {
            if let imageURL = article.media, let url = URL(string: imageURL) {
                CachedAsyncImage(
                    url: url, urlCache: .imageCache
                ) { phase in
                    HStack(alignment:.center) {
                        switch phase {
                        case .empty:
                            ProgressView()
                                .scaleEffect(0.8, anchor: .center)
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(width: PlaceholderImageView.size.width, height: PlaceholderImageView.size.height)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: PlaceholderImageView.size.width, height: PlaceholderImageView.size.height)
                                .addBorder( Color.separatorColor,
                                            width: 4,
                                            cornerRadius: 10)
                        case .failure:
                            PlaceholderImageView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 5)
                    .frame(width: PlaceholderImageView.size.width + 20)
                }
            } else {
                HStack(alignment:.center) {
                    PlaceholderImageView()
                }
                .padding(.top, 5)
                .padding(.bottom, 5)
                .frame(width: PlaceholderImageView.size.width + 20)
            }
            
            VStack(alignment: .leading, spacing: 2)   {
                
                HStack {
                    Text(article.title ?? "")
                        .font(.subheadline)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                HStack {
                    Text(article.cleanURL ?? "")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .padding(.top, 5)
            .padding(.bottom, 5)
            .padding(.trailing, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background( Color.secondarySystemBackground )
    }
    
    
}


