//
//  GameCell.swift
//  memory-tunes
//
//  Created by Snow Lukin on 26.05.2023.
//

import UIKit
import Kingfisher

final class CardCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "game-view-controller-cell"
    
    var cardImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "VibrantYellow")
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        setupCardImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCardImageView() {
        cardImageView = UIImageView(frame: contentView.bounds)
        cardImageView.contentMode = .scaleAspectFit
        cardImageView.clipsToBounds = true
        contentView.addSubview(cardImageView)
    }
    
    func configureCell(with cardState: MemoryCard) {
        let url = URL(string: cardState.imageUrl)
        cardImageView.kf.setImage(with: url)
        cardImageView.alpha = cardState.isAlreadyGuessed || cardState.isFlipped ? 1 : 0
    }
}
