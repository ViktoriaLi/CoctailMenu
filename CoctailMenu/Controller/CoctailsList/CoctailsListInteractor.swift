//
//  CoctailsListInteractor.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol CoctailsListBusinessLogic {
    func getCoctailsByCategory(request: CoctailsListView.GetCoctails.Request)
    func getCategories(request: CoctailsListView.GetCategories.Request)
}

class CoctailsListViewInteractor: CoctailsListBusinessLogic {
    
    var presenter: CoctailsListViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getCoctailsByCategory(request: CoctailsListView.GetCoctails.Request) {
        networkManager.getData(target: .coctails(category: request.category), completion: { (result: Result<CoctailModel, ApiResponse>) in
            switch result {
            case .failure:
                let response = CoctailsListView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            case .success(let coctails):
                let response = CoctailsListView.GetCoctails.Response(category: request.category, coctails: coctails.drinks)
                self.presenter?.processingCoctails(response: response)
            }
        })
    }
    
    func getCategories(request: CoctailsListView.GetCategories.Request) {
        networkManager.getData(target: .filters, completion: { (result: Result<FilterModel, ApiResponse>) in
            switch result {
            case .failure:
                let response = CoctailsListView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            case .success(let categories):
                let response = CoctailsListView.GetCategories.Response(categories: categories.drinks)
                self.presenter?.processingCategories(response: response)
            }
        })
    }
}
