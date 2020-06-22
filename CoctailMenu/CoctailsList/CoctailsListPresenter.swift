//
//  CoctailsListPresenter.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

protocol CoctailsListViewPresentationLogic: class {
    func processingError(response: CoctailsListView.GetErrorView.Response)
    func processingCoctails(response: CoctailsListView.GetCoctails.Response)
    func processingCategories(response: CoctailsListView.GetCategories.Response)

}

class CoctailsListViewPresenter: CoctailsListViewPresentationLogic {
    
    weak var viewController: CoctailsListViewDisplayLogic?
    
    func processingError(response: CoctailsListView.GetErrorView.Response) {
        switch response.error {
        case .success:
            break
        default:
            let viewModel = CoctailsListView.GetErrorView.ViewModel()
            viewController?.showErrorView(viewModel: viewModel)
        }
    }
    
    func processingCoctails(response: CoctailsListView.GetCoctails.Response) {
        let viewModel = CoctailsListView.GetCoctails.ViewModel(coctails: response.coctails)
        viewController?.fillCoctailsList(viewModel: viewModel)
    }
    
    func processingCategories(response: CoctailsListView.GetCategories.Response) {

        let viewModel = CoctailsListView.GetCategories.ViewModel(categories: response.categories)
        viewController?.fillCategories(viewModel: viewModel)
    }
    
}
