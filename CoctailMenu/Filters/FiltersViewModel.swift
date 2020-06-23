//
//  FiltersViewModel.swift
//  CoctailMenu
//
//  Created by Mac Developer on 23.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import Foundation

enum FiltersView {
    
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

