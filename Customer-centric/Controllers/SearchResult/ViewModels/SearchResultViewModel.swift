//
//  SearchResultViewModel.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 11/12/23.
//

import Foundation
import Combine

class SearchResultViewModel: ObservableObject {
    @Published var clients: [Client] = []
    @Published var textToSearch: String = String()
    
    @Published var searchResponse: SearchResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService = APIService.shared
    var paginator = Paginator(page: 1, pageSize: 10)
    
    var typeFilter : FilterSearchByName!
    var isSortedAscending = false
    
    func searchByName(name: String) {
        isLoading = true
        if errorMessage != nil {
            errorMessage = nil
        }
        self.textToSearch = name
        let router = APISearchRouter.searchByName(name: name, paginator: paginator)

        apiService.requestPublisher(router)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    DispatchQueue.main.async {
                        self?.errorMessage = error.localizedDescription
                    }
                }
            }, receiveValue: { [weak self] (response: SearchResponse) in
                guard let strongSelf = self else {
                    return
                }
                DispatchQueue.main.async {
                    strongSelf.searchResponse = response
                    strongSelf.isLoading = false
                    strongSelf.clients = (strongSelf.clients + response.clientes)
                    strongSelf.clients = strongSelf.clients.unique {$0.numeroDocumento}
                }
            })
            .store(in: &cancellables)
    }
    
    func loadMoreResults() {
        guard !isLoading else { return }

        isLoading = true
        paginator.incrementPage()
        searchByName(name: self.textToSearch)
    }
    
    func sortClients(clients: inout [Client], ascending: Bool = true) {
        clients.sort {
            if ascending {
                return $0.nombreCompleto < $1.nombreCompleto
            } else {
                return $0.nombreCompleto > $1.nombreCompleto
            }
        }
    }

    func resetSearch() {
        paginator = Paginator(page: 1, pageSize: 10)
        clients = []
        textToSearch = String()
        errorMessage = nil
    }
}
