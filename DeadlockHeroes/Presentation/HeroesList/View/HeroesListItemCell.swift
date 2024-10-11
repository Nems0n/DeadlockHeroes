//
//  HeroesListItemCell.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import UIKit
import SDWebImage

// MARK: - HeroesListItemCell
class HeroesListItemCell: UICollectionViewCell {
    public static let identifier = "HeroesListCollectionViewCell"
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.sizeToFit()
        label.adjustsFontForContentSizeCategory = true
        label.maximumContentSizeCategory = .accessibilityMedium
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        avatarImageView.image = nil
    }
}

//MARK: - Configure Cell
extension HeroesListItemCell {
    public func configure(heroName: String, avatarUrl: URL?) {
        setupCell(heroName: heroName, avatarUrl: avatarUrl)
    }
}

// MARK: - Setup Cell
private extension HeroesListItemCell {
    func setupCell(heroName: String, avatarUrl: URL?) {
        layer.cornerRadius = 8
        backgroundColor = .lightGray
        layer.masksToBounds = true
        nameLabel.text = heroName
        avatarImageView.sd_setImage(with: avatarUrl)
        
        addSubview(avatarImageView)
        addSubview(nameContainerView)
        nameContainerView.addSubview(nameLabel)
        setupContraints()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameContainerView.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            nameContainerView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -8),
            nameContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            nameContainerView.heightAnchor.constraint(equalToConstant: nameLabel.font.lineHeight + 6),
            nameLabel.centerXAnchor.constraint(equalTo: nameContainerView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: nameContainerView.centerYAnchor)
        ])
    }
}
