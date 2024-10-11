//
//  ItemsListVC.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 05/10/2024.
//

import UIKit

// MARK: - ItemsListVC
class ItemsListVC: UIViewController {
    
    private let viewModel = ItemsListVM()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        return controller
    }()
    
    private lazy var itemsListView: ItemsListView = {
        let view = ItemsListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup
private extension ItemsListVC {
    func setup() {
        view.backgroundColor = .white
        itemsListView.provideTableView(with: self)
        itemsListView.delegate = self
        
        view.addSubview(itemsListView)
        setupSearchController()
        setupObservers()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemsListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemsListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemsListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemsListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupObservers() {
        viewModel.items
            .done { [weak self] _ in
                self?.itemsListView.reloadTableViewData()
            }
            .catch { error in
                print("Failed to fetch items: \(error.localizedDescription)")
            }
        viewModel.onItemsUpdated = { [weak self] in
            self?.itemsListView.reloadTableViewData()
        }
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Item"
        
        navigationItem.searchController = searchController
        definesPresentationContext = false
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: - UITableViewDataSource
extension ItemsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let inSearchMode = viewModel.inSearchMode(isActive: searchController.isActive, searchBarText: searchController.searchBar.text ?? "")
        return inSearchMode ? viewModel.filteredItems[section].items.count : viewModel.items.value?[section].items.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let inSearchMode = viewModel.inSearchMode(isActive: searchController.isActive, searchBarText: searchController.searchBar.text ?? "")
        return inSearchMode ? viewModel.filteredItems.count : viewModel.items.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemsListItemCell.identifier, for: indexPath) as? ItemsListItemCell else {
            fatalError("Failed to dequeue \(ItemsListItemCell.self)")
        }
        let inSearchMode = viewModel.inSearchMode(isActive: searchController.isActive, searchBarText: searchController.searchBar.text ?? "")
        let sectionedItem = inSearchMode ? viewModel.filteredItems[indexPath.section] : viewModel.items.value?[indexPath.section]
        let item = sectionedItem?.items[indexPath.row]
        cell.configure(itemName: item?.name ?? "", price: item?.cost ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.items.value?[section].type.rawValue.uppercased()
    }
}

// MARK: - ItemsListViewDelegate
extension ItemsListVC: ItemsListViewDelegate {
    func didSelectItem(with indexPath: IndexPath) {
        let inSearchMode = viewModel.inSearchMode(isActive: searchController.isActive, searchBarText: searchController.searchBar.text ?? "")
        guard let id = inSearchMode ? viewModel.filteredItems[indexPath.section].items[indexPath.row].id : viewModel.items.value?[indexPath.section].items[indexPath.row].id else {
            return
        }
        let detailVC = ItemDetailsVC(viewModel: ItemDetailsVM(id: id))
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension ItemsListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.viewModel.updateSearchController(searchBarText: searchController.searchBar.text)
    }
}
