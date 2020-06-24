//
//  FiltersViewController.swift
//  CoctailMenu
//
//  Created by Mac Developer on 22.06.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

protocol FiltersViewDisplayLogic: class {
    func showErrorView(viewModel: FiltersView.GetErrorView.ViewModel)
    func fillCategories(viewModel: FiltersView.GetCategories.ViewModel)
}

class FiltersViewController: UIViewController {

    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    var categories = [Drink]()
    var updateFilters: (([Drink]) -> ())? = nil
    
    var interactor: FiltersBusinessLogic?
    
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
        let interactor = FiltersViewInteractor()
        let presenter = FiltersViewPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationView.addGrayShadow()
        addFooterToTableView()
        getCategories()
    }
    
    private func addFooterToTableView() {
        let height = view.frame.size.height - (applyButton.frame.size.height + applyButton.frame.origin.y) + 20
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: height))
        tableView.tableFooterView = view
    }
    
    private func getCategories() {
        let request = FiltersView.GetCategories.Request()
        interactor?.getCategories(request: request)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyButtonTapped(_ sender: UIButton) {
        let filtereCategories = categories.filter {$0.isSelected == true}
        updateFilters?(filtereCategories)
        self.navigationController?.popViewController(animated: true)
    }
}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.configure(filter: categories[indexPath.row], cellIndex: indexPath)
        return cell
    }
}

extension FiltersViewController: CheckMarkStatus {
    func changeCheckMarkVisibility(cellIndex: IndexPath, visibility: Bool) {
        categories[cellIndex.row].isSelected = visibility
    }
}

extension FiltersViewController: FiltersViewDisplayLogic {
    
    func showErrorView(viewModel: FiltersView.GetErrorView.ViewModel) {
        DispatchQueue.main.async {
            self.tableView.backgroundView = SomethingWrong(delegate: self, frame: CGRect(x: self.tableView.frame.minX, y: self.tableView.frame.minY, width: self.tableView.frame.width, height: self.tableView.frame.height))
            self.applyButton.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func fillCategories(viewModel: FiltersView.GetCategories.ViewModel) {
        categories = viewModel.categories
        applyButton.isHidden = false
        tableView.reloadData()
    }
}

extension FiltersViewController: ErrorViewDelegate {
    
    func tryAgain() {
        getCategories()
    }
}
