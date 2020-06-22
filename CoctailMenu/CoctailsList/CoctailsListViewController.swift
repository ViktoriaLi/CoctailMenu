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

    var categories = [Drink]()
    var coctails = [String: [CoctailModel]]()
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
        //getCategories()
        getCoctails(from: "Ordinary Drink")
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
        return coctails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel!.text = "test"
        return cell
    }
    
}

extension CoctailsListViewController: CoctailsListViewDisplayLogic {
    
    func fillCoctailsList(viewModel: CoctailsListView.GetCoctails.ViewModel) {
        self.tableView.separatorStyle = .none
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
