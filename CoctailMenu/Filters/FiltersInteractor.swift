//
//  FiltersInteractor.swift
//  CoctailMenu
//
//  Created by Mac Developer on 23.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol FiltersBusinessLogic {
    func getCategories(request: FiltersView.GetCategories.Request)
}

class FiltersViewInteractor: FiltersBusinessLogic {
    
    var presenter: FiltersViewPresentationLogic?
    private var networkManager = NetworkManager()
    
    func getCategories(request: FiltersView.GetCategories.Request) {
        networkManager.getData(target: .filters, completion: { (result: Result<FilterModel, ApiResponse>) in
            switch result {
            case .failure:
                let response = FiltersView.GetErrorView.Response(error: .failed)
                self.presenter?.processingError(response: response)
            case .success(let categories):
                let response = FiltersView.GetCategories.Response(categories: categories.drinks)
                print(categories)
                self.presenter?.processingCategories(response: response)
            }
        })
    }
    
}

