//
//  CoctailsListDataModel.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

enum CoctailsListView {

    enum GetCoctails {
        
        struct Request {
            let category: String
        }
        
        struct Response {
            let coctails: [Coctail]
        }
        
        struct ViewModel {
            let coctails: [Coctail]
        }
    }
    
    enum GetCategories {
        
        struct Request {
        }
        
        struct Response {
            let categories: [Drink]
        }
        
        struct ViewModel {
            let categories: [Drink]
        }
    }

    enum GetErrorView {
        struct Request {
        }
        
        struct Response {
            let error: ApiResponse
        }
        
        struct ViewModel {
        }
    }
}
