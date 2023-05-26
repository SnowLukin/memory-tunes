//
//  MenuTableViewController.swift
//  memory-tunes
//
//  Created by Snow Lukin on 25.05.2023.
//

import ReSwift

final class MenuViewController: UIViewController {
    
    let gameButton = UIButton(type: .system)
    let categoriesButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "SkyBlue")
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.dispatch(RoutingAction(destination: .menu))
    }
    
    private func setupButtons() {
        gameButton.setTitle("Game", for: .normal)
        gameButton.setTitleColor(.black, for: .normal)
        gameButton.backgroundColor = UIColor(named: "VibrantYellow")
        gameButton.layer.cornerRadius = 5
        gameButton.clipsToBounds = true
        gameButton.addTarget(self, action: #selector(didTapGameButton), for: .touchUpInside)
        gameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        categoriesButton.setTitle("Categories", for: .normal)
        categoriesButton.setTitleColor(.black, for: .normal)
        categoriesButton.backgroundColor = UIColor(named: "VibrantYellow")
        categoriesButton.layer.cornerRadius = 5
        categoriesButton.clipsToBounds = true
        categoriesButton.addTarget(self, action: #selector(didTapCategoriesButton), for: .touchUpInside)
        categoriesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [gameButton, categoriesButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    @objc private func didTapGameButton() {
        store.dispatch(RoutingAction(destination: .game))
    }
    
    @objc private func didTapCategoriesButton() {
        store.dispatch(RoutingAction(destination: .categories))
    }
}
