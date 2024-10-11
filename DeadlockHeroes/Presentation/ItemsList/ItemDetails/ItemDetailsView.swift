//
//  ItemDetailsView.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import UIKit
import SDWebImage

// MARK: - ItemDetailsView
class ItemDetailsView: UIView {

    private lazy var itemImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var itemTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure content
extension ItemDetailsView {
    func configure(iconURL: URL?, itemName: String, itemType: String) {
        itemImageView.sd_setImage(with: iconURL, placeholderImage: UIImage(systemName: "dollarsign.circle"))
        itemNameLabel.text = itemName
        itemTypeLabel.text = itemType
    }
}

// MARK: - Setup View
private extension ItemDetailsView {
    func setupView() {
        backgroundColor = .white
        
        addSubview(itemImageView)
        addSubview(itemNameLabel)
        addSubview(itemTypeLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            itemImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 100),
            itemImageView.widthAnchor.constraint(equalToConstant: 100),
            itemNameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 16),
            itemNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            itemNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            itemTypeLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 16),
            itemTypeLabel.centerXAnchor.constraint(equalTo: itemNameLabel.centerXAnchor)
        ])
    }
}
