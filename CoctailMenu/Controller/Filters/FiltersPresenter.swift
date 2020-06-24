//
//  FiltersPresenter.swift
//  CoctailMenu
//
//  Created by Mac Developer on 23.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol FiltersViewPresentationLogic: class {
    func processingError(response:FiltersView.GetErrorView.Response)
    func processingCategories(response: FiltersView.GetCategories.Response)
}

class FiltersViewPresenter: FiltersViewPresentationLogic {
    
    weak var viewController: FiltersViewDisplayLogic?
    
    func processingError(response: FiltersView.GetErrorView.Response) {
        switch response.error {
        case .success:
            break
        default:
            let viewModel = FiltersView.GetErrorView.ViewModel()
            viewController?.showErrorView(viewModel: viewModel)
        }
    }
    
    func processingCategories(response: FiltersView.GetCategories.Response) {
        let viewModel = FiltersView.GetCategories.ViewModel(categories: response.categories)
        viewController?.fillCategories(viewModel: viewModel)
    }
}

