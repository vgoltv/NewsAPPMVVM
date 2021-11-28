//
//  HomeView.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 01/06/2021.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .scaleEffect(0.8, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle())
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List(articles) { item in
                        NavigationLink(destination: ArticleDetailView(article: item)) {
                            ArticleRowView(article: item)
                        }
                    }
#if os(macOS)
        .toolbar {
            ToolbarItemGroup(placement: .automatic){
                HStack{
                    Spacer()
                        .frame(width:30)
                    Button(action: {
                        URLCache.imageCache.removeAllCachedResponses()
                        viewModel.getArticles()
                    },
                           label: { Image(systemName: "arrow.counterclockwise").imageScale(.large) })
                        .buttonStyle(PlainButtonStyle())
                }

            }
        }
#endif
                    .padding(.leading,6)
                    .padding(.trailing,6)
                    .frame(minWidth: 200,
                           maxWidth: .infinity,
                           minHeight: 200,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    
#if os(iOS)
                    .navigationTitle(Text("News"))
                    .navigationBarTitleDisplayMode(.inline)
#elseif os(tvOS)

#elseif os(macOS)
                    .navigationTitle(Text("News"))
#endif
                    .frame(minWidth: 300)
                    .refreshable{
                        URLCache.imageCache.removeAllCachedResponses()
                        viewModel.getArticles()
                    }

                    // Second view for wide layouts
                    Text("Select an article")
                }
                
            }
        }
        .onAppear(perform: viewModel.getArticles)


    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
