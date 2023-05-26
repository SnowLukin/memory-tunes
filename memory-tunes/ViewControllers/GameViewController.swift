//
//  GameViewController.swift
//  memory-tunes
//
//  Created by Snow Lukin on 25.05.2023.
//

import ReSwift

final class GameViewController: UIViewController {
    
    var collectionView: UICollectionView!
    var loadingIndicator: UIActivityIndicatorView!
    
    var collectionDataSource: CollectionDataSource<CardCollectionViewCell, MemoryCard>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.dispatch(fetchTunes)
        collectionDataSource = CollectionDataSource(cellIdentifier: CardCollectionViewCell.reuseIdentifier, models: [], configureCell: { cell, model in
            cell.configureCell(with: model)
            return cell
        })
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        store.subscribe(self) { sub in
            sub.select { state in
                state.gameState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    fileprivate func setupViews() {
        setupCollectionView()
        setupLoadingIndicator()
    }
    
    fileprivate func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = UIColor(named: "SkyBlue")
        collectionView.delegate = self
        collectionView.dataSource = collectionDataSource
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    fileprivate func setupLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
    }

    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            // Collection view
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Loading indicator
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    fileprivate func showGameFinishedAlert() {
        let alertController = UIAlertController(title: "Congratulations!",
                                                message: "You've finished the game!",
                                                preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate
extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        store.dispatch(FlipCardAction(cardIndexToFlip: indexPath.row))
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the width for 3 cells per row taking into account the layout's minimumInteritemSpacing
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpacing = layout.minimumInteritemSpacing * 2 + layout.sectionInset.left + layout.sectionInset.right
        let width = (collectionView.frame.width - totalSpacing) / 3
        let height = width // Making it square
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - StoreSubscriber
extension GameViewController: StoreSubscriber {
    func newState(state: GameState) {
        collectionDataSource?.models = state.memoryCards
        collectionView.reloadData()
        
        state.showLoading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
        
        if state.gameFinished {
            showGameFinishedAlert()
            store.dispatch(fetchTunes)
        }
    }
}
