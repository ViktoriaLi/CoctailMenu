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

class CoctailsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationView: UIView!
    
    var categories = [Drink]() {
        didSet {
            if categories.count > 0 {
                if let index = categories.firstIndex(where: { $0.isSelected == true }) {
                    getCoctails(from: categories[index].category)
                } else {
                    coctails.removeAll()
                    tableView.reloadData()
                }
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
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationView.addGrayShadow()
        
        let nibCategory = UINib.init(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nibCategory, forCellReuseIdentifier: "filterHeader")
        let nibCoctail = UINib.init(nibName: "CoctailTableViewCell", bundle: nil)
        tableView.register(nibCoctail, forCellReuseIdentifier: "coctailCell")
        //tableView.tableFooterView?.isHidden = true
        getCategories()
    }

    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Filters", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "filtersVC") as? FiltersViewController {
            vc.updateFilters = { filteredCategories in
                self.coctails.removeAll()
                self.categories = filteredCategories
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
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

extension CoctailsListViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let coctails = coctails[categories[section].category]?.count {
            return coctails + 1
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.section, indexPath.row)
        if indexPath.row == 0 {
            if indexPath.section < categories.count, let cell = tableView.dequeueReusableCell(withIdentifier: "filterHeader", for: indexPath) as? CategoryTableViewCell {
                cell.configure(filter: categories[indexPath.section])
                return cell
                
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "coctailCell", for: indexPath) as? CoctailTableViewCell {
                if indexPath.section < categories.count, let coctail = coctails[categories[indexPath.section].category] {
                    cell.configure(coctail: coctail[indexPath.row - 1])
                    return cell
                }

            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section < categories.count, let categoryCoctails = coctails[categories[indexPath.section].category], indexPath.row == categoryCoctails.count - 1 {
            print("will display last row")
            if indexPath.section + 1 < categories.count, coctails[categories[indexPath.section + 1].category] == nil {
                var nextCategory = indexPath.section + 1
                let startIndex = indexPath.section + 1
                for i in startIndex..<categories.count {
                    if categories[i].isSelected == true {
                        nextCategory = i
                        break
                    }
                }
                getCoctails(from: categories[nextCategory].category)
            }
            if indexPath.section == categories.count - 1, let categoryCoctails = coctails[categories[indexPath.section].category], indexPath.row == categoryCoctails.count - 1   {
                let view = TableViewFooter(delegate: self, frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
                tableView.tableFooterView = view
            }
        }
    }
    
    /*func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == categories.count - 1, let coctails = coctails[categories[section].category]?.count, tableView.visibleCells.count == coctails
 {
            let view = TableViewFooter(delegate: self, frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
            return view
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == categories.count - 1, let coctails = coctails[categories[section].category]?.count, tableView.visibleCells.count == coctails - 1 {
            return 50
        }
        return 0
    }*/
}

extension CoctailsListViewController: CoctailsListViewDisplayLogic {
    
    func fillCoctailsList(viewModel: CoctailsListView.GetCoctails.ViewModel) {
        coctails[viewModel.category] = viewModel.coctails
        tableView.reloadData()
    }

    func showErrorView(viewModel: CoctailsListView.GetErrorView.ViewModel) {
       DispatchQueue.main.async {
            self.tableView.backgroundView = SomethingWrong(delegate: self, frame: CGRect(x: self.tableView.frame.minX, y: self.tableView.frame.minY, width: self.tableView.frame.width, height: self.tableView.frame.height))
            self.tableView.reloadData()
        }
    }
    
    func fillCategories(viewModel: CoctailsListView.GetCategories.ViewModel) {
        self.categories = viewModel.categories
    }

}

extension CoctailsListViewController: ErrorViewDelegate {
    
    func tryAgain() {
        getCategories()
    }
}

extension CoctailsListViewController: ScrollToTopDelegate {
    
    func returnToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
