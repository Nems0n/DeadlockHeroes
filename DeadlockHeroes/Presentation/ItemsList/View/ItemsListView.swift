//
//  ItemsListView.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import UIKit

// MARK: - ItemsListViewDelegate
protocol ItemsListViewDelegate: AnyObject {
    func didSelectItem(with indexPath: IndexPath)
}

// MARK: - ItemsListView
class ItemsListView: UIView {
    
    weak var delegate: ItemsListViewDelegate?

    private lazy var itemsTableView: UITableView = {
        let view = UITableView()
        view.register(ItemsListItemCell.self, forCellReuseIdentifier: ItemsListItemCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableView Setup
extension ItemsListView {
    func provideTableView(with dataSource: UITableViewDataSource) {
        itemsTableView.dataSource = dataSource
    }
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.itemsTableView.reloadData()
        }
    }
}

// MARK: - View Setup
private extension ItemsListView {
    func setup() {
        backgroundColor = .white
        itemsTableView.delegate = self
        
        addSubview(itemsTableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemsTableView.topAnchor.constraint(equalTo: topAnchor),
            itemsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemsTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemsTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate
extension ItemsListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(with: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
