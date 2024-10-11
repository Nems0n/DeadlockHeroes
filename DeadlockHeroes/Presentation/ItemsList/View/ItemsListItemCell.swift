//
//  ItemsListItemCell.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 10/10/2024.
//

import UIKit

// MARK: - ItemsListItemCell
class ItemsListItemCell: UITableViewCell {
    public static let identifier: String = "ItemListItemCell"
    
    private lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.sizeToFit()
        label.adjustsFontForContentSizeCategory = true
        label.maximumContentSizeCategory = .extraExtraLarge
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var coinImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "dollarsign.circle")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var itemPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.sizeToFit()
        label.textColor = .darkGray
        label.textAlignment = .right
        label.adjustsFontForContentSizeCategory = true
        label.maximumContentSizeCategory = .extraExtraLarge
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemLabel.text = nil
        itemPriceLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - Configure Cell
extension ItemsListItemCell {
    func configure(itemName: String, price: Int) {
        setupCell(itemName: itemName, price: price)
    }
}

// MARK: - Setup Cell
private extension ItemsListItemCell {
    func setupCell(itemName: String, price: Int) {
        backgroundColor = .white
        itemLabel.text = itemName
        itemPriceLabel.text = String(price)
        
        addSubview(coinImageView)
        addSubview(itemPriceLabel)
        addSubview(itemLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            coinImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            coinImageView.widthAnchor.constraint(equalToConstant: coinImageView.frame.width),
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            itemPriceLabel.trailingAnchor.constraint(equalTo: coinImageView.leadingAnchor, constant: -8),
            itemPriceLabel.centerYAnchor.constraint(equalTo: coinImageView.centerYAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            itemLabel.widthAnchor.constraint(lessThanOrEqualToConstant: frame.width - (coinImageView.frame.width + itemPriceLabel.frame.width)),
            itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
