//
//  ViewController.swift
//  DeadlockHeroes
//
//  Created by Vlad Todorov on 05/10/2024.
//

import UIKit

// MARK: - HeroesListVC
class HeroesListVC: UIViewController {
    
    private let viewModel = HeroesListVM()
    
    private lazy var heroesListView: HeroesListView = {
        let view = HeroesListView()
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
private extension HeroesListVC {
    func setup() {
        heroesListView.provideCollectionView(with: self)
        
        view.addSubview(heroesListView)
        setupObservers()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heroesListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            heroesListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroesListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroesListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupObservers() {
        viewModel.heroes
            .done { [weak self] _ in
                self?.heroesListView.reloadCollectionViewData()
            }
            .catch { error in
                print("Failed to fetch heroes: \(error.localizedDescription)")
            }
    }
}

// MARK: UICollectionViewDataSource
extension HeroesListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.heroes.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesListItemCell.identifier, for: indexPath) as? HeroesListItemCell else {
            fatalError("Failed to dequeue \(HeroesListItemCell.self)")
        }
        let hero = viewModel.heroes.value?[indexPath.row]
        cell.configure(heroName: hero?.name ?? "", avatarUrl: URL(string: hero?.images.portrait ?? ""))
        return cell
    }
    
}
