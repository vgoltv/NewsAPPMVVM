//
//  NewsViewModel.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 01/06/2021.
//

import Foundation
import Combine






protocol NewsViewModel {
    func getArticles()
}

class NewsViewModelImpl: ObservableObject, NewsViewModel {

    private let service: NewsService //DI dependes of abstractions not implementation
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: ResultStates = .loading

    //Inject the service - here we could replace this with Any service that conforms the NewsService,
    //so in order to test the viewModel we could create a mock in inject it here.
    init(service: NewsService) {
        self.service = service
    }

    func getArticles() {
        // first please configure and start local server, then edit address
        // for getLocalNews if it is needed
        let useLocalServer = false
        let newsSource:NewsAPI = useLocalServer ? .getLocalNews : .getNews
        let cancellable  = service.request(from: newsSource)
            .sink { operationResult in
                switch operationResult {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    self.state = .failed(error: error)
                }
            } receiveValue: { newsResponse in
                self.articles = newsResponse.articles
            }
        self.cancellables.insert(cancellable)
    }
}
