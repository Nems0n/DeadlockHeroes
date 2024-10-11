//
//  HeroesListView.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 09/10/2024.
//

import UIKit

// MARK: - HeroesListView
class HeroesListView: UIView {

    private lazy var heroesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.allowsSelection = true
        view.register(HeroesListItemCell.self, forCellWithReuseIdentifier: HeroesListItemCell.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - CollectionView Setup
extension HeroesListView {
    func provideCollectionView(with dataSource: UICollectionViewDataSource) {
        heroesCollectionView.dataSource = dataSource
    }
    
    func reloadCollectionViewData() {
        heroesCollectionView.reloadData()
    }
}


// MARK: - View Setup
private extension HeroesListView {
    func setup() {
        backgroundColor = .white
        heroesCollectionView.delegate = self
        
        addSubview(heroesCollectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heroesCollectionView.topAnchor.constraint(equalTo: topAnchor),
            heroesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HeroesListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16 * 3) / 2
        return CGSize(width: width, height: width)
    }
}
