//
//  SearchByNameViewModel.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 8/12/23.
//

import Foundation
import Combine
import Alamofire

class SearchByNameViewModel: ObservableObject {
    @Published var searchResponse: SearchResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var clientDetail: ClientDetail? 

    private var cancellables = Set<AnyCancellable>()

    private let apiService = APIService.shared
    private var paginator = Paginator(page: 1, pageSize: 10)

    var filterType : FilterSearchByName = .name
    
    func searchByName(name: String) {
        isLoading = true
        let router = APISearchRouter.searchByName(name: name, paginator: paginator)

        apiService.requestPublisher(router)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (response: SearchResponse) in
                self?.searchResponse = response
            })
            .store(in: &cancellables)
    }

    func searchByDocument(documentType: String, documentNumber: String, digitVerification: String) {
        isLoading = true
        
        let router = APISearchRouter.searchByDocument(documentType: documentType, documentNumber: documentNumber, digitVerification: digitVerification)

        apiService.requestPublisher(router)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] (detalle: ClientDetail) in
                
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.clientDetail = detalle
            })
            .store(in: &cancellables)
    }
}
