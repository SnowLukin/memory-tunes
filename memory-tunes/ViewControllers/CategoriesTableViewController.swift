//
//  CategoriesTableViewController.swift
//  memory-tunes
//
//  Created by Snow Lukin on 25.05.2023.
//

import ReSwift

final class CategoriesTableViewController: UITableViewController {
    let cellIdentifier = "categories-table-view-controller-cell"
    
    var tableDataSource: TableDataSource<UITableViewCell, Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "SkyBlue")
        tableView = UITableView(frame: tableView.frame, style: .insetGrouped)
        tableView.backgroundColor = UIColor(named: "SkyBlue")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) { subsctiption in
            subsctiption.select { state in
                state.categoriesState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        store.dispatch(ChangeCategoryAction(categoryIndex: indexPath.row))
    }
}

extension CategoriesTableViewController: StoreSubscriber {
    func newState(state: CategoriesState) {
        tableDataSource = TableDataSource(
            cellIdentifier: cellIdentifier, models: state.categories
        ) {cell, model in
            cell.backgroundColor = UIColor(named: "BubblegumPink")
            cell.textLabel?.text = model.rawValue
            cell.textLabel?.textColor = .black
            cell.accessoryType = (state.currentCategorySelected == model) ? .checkmark : .none
            return cell
        }
        
        self.tableView.dataSource = tableDataSource
        self.tableView.reloadData()
    }
}
