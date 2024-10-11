//
//  ItemDetailsVC.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import UIKit

// MARK: - ItemDetailsVC
class ItemDetailsVC: UIViewController {
    private let viewModel: ItemDetailsVMLogic
    
    private lazy var itemDetailsView: ItemDetailsView = {
        let view = ItemDetailsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - VC Lifecycle
    init(viewModel: ItemDetailsVMLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup View
private extension ItemDetailsVC {
    func setup() {
        view.addSubview(itemDetailsView)
        setupObservers()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            itemDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupObservers() {
        viewModel.item
            .done { [weak self] item in
                self?.itemDetailsView.configure(iconURL: URL(string: item.image ?? ""),
                                                itemName: item.name ?? "",
                                                itemType: item.itemSlotType?.rawValue ?? "")
            }
            .catch { error in
                print("Failed to fetch item: \(error.localizedDescription)")
            }
    }
}
