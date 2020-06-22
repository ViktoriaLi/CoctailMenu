//
//  ViewController.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

protocol CoctailsListViewDisplayLogic: class {
    func fillCoctailsList(viewModel: CoctailsListView.GetCoctails.ViewModel)
    func showErrorView(viewModel: CoctailsListView.GetErrorView.ViewModel)
    func fillCategories(viewModel: CoctailsListView.GetCategories.ViewModel)
}

class CoctailsListViewController: UITableViewController {

    var categories = [Drink]() {
        didSet {
            if categories.count > 0 {
                getCoctails(from: categories[0].category)
            }
        }
    }
    var coctails = [String: [Coctail]]()
    var interactor: CoctailsListBusinessLogic?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = CoctailsListViewInteractor()
        let presenter = CoctailsListViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCategory = UINib.init(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nibCategory, forCellReuseIdentifier: "filterHeader")
        let nibCoctail = UINib.init(nibName: "CoctailTableViewCell", bundle: nil)
        tableView.register(nibCoctail, forCellReuseIdentifier: "coctailCell")
        getCategories()
    }

    func getCategories() {
        let request = CoctailsListView.GetCategories.Request()
        interactor?.getCategories(request: request)
    }
    
    func getCoctails(from category: String) {
        let request = CoctailsListView.GetCoctails.Request(category: category)
        interactor?.getCoctailsByCategory(request: request)
    }

}


extension CoctailsListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coctails[categories[section].category]?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "filterHeader", for: indexPath) as? CategoryTableViewCell {
                cell.configure(filter: categories[0])
                return cell
                
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "coctailCell", for: indexPath) as? CoctailTableViewCell {
                if let coctail = coctails[categories[0].category] {
                    cell.configure(coctail: coctail[indexPath.row])
                    return cell
                }

            }
        }
        return cell
    }
    
}

extension CoctailsListViewController: CoctailsListViewDisplayLogic {
    
    func fillCoctailsList(viewModel: CoctailsListView.GetCoctails.ViewModel) {
        coctails[viewModel.category] = viewModel.coctails
        self.tableView.separatorStyle = .singleLine
        tableView.reloadData()
    }

    func showErrorView(viewModel: CoctailsListView.GetErrorView.ViewModel) {
        DispatchQueue.main.async {
            self.tableView.backgroundView = SomethingWrong(frame: CGRect(x: self.tableView.frame.minX, y: self.tableView.frame.minY, width: self.tableView.frame.width, height: self.tableView.frame.height))
            self.tableView.separatorStyle = .none
            self.tableView.reloadData()
        }
    }
    
    func fillCategories(viewModel: CoctailsListView.GetCategories.ViewModel) {
        self.categories = viewModel.categories
    }

}
