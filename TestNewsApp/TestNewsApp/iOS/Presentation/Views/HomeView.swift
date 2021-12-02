//
//  HomeView.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 01/06/2021.
//

import SwiftUI



struct HomeView: View {
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    @State var isEmpty: Bool = false
    @State var navigationViewIsActive: Bool = false
    @State var selectedFeaturedArticle : Article? = nil
    
    var body: some View {
        
        return Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .scaleEffect(0.8, anchor: .center)
                    .progressViewStyle(CircularProgressViewStyle())
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List {
                        let topNews = Array(articles.choose(3))
                        ArticlesPager(articles: topNews, onCardSelected: { articleItem, isSet in
                            isEmpty = false
                            navigationViewIsActive = isSet
                            selectedFeaturedArticle = articleItem
                        })
                            .aspectRatio(3 / 2, contentMode: .fit)
                            .listRowInsets(EdgeInsets())
                            .listRowSeparator(.hidden)
                        
                        VStack {
                            if let item = selectedFeaturedArticle {
                                NavigationLink(destination: ArticleDetailView(article: item), isActive: $navigationViewIsActive){
                                    EmptyView()
                                }
                            }
                        }.hidden()
                        
                        let popular = Array(articles.choose(8))
                        CategoryRow(name: "POPULAR", items: popular, thumbWidth: 90, thumbHeight: 90)
                            .listRowSeparator(.hidden)
                        
                        let newest = Array(articles.choose(8))
                        CategoryRow(name: "NEWEST", items: newest, thumbWidth: 90, thumbHeight: 90)
                            .listRowSeparator(.hidden)
                        
                        let recent = Array(articles.choose(8))
                        CategoryRow(name: "RECENT", items: recent, thumbWidth: 90, thumbHeight: 90)
                            .listRowSeparator(.hidden)
                        
                        /*
                        ForEach(articles, id: \.self) {article in
                            NavigationLink(destination: ArticleDetailView(article: article)) {
                                ArticleRowView(article: article)
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        */
                    }
                    .frame(minWidth: 200,
                           maxWidth: .infinity,
                           minHeight: 200,
                           maxHeight: .infinity,
                           alignment: .topLeading)
                    .navigationTitle(Text("News"))
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
