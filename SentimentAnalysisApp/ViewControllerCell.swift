//
//  ViewControllerCell.swift
//  SentimentAnalysisApp
//
//  Created by M'haimdat omar on 03-08-2019.
//  Copyright © 2019 M'haimdat omar. All rights reserved.
//

import UIKit

class ViewControllerCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            
            UIView.animate(withDuration: 0.27, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                self.contentView.alpha = self.isHighlighted ? 0.35 : 1
                self.transform = self.isHighlighted ? self.transform.scaledBy(x: 0.96, y: 0.96) : .identity
            })
        }
    }
    
    // MARK: UI
    let sentiment: UILabel = {
        let label = UILabel()
        label.text = "....."
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 1
        
        return label
    }()
    
    let text: UILabel = {
        let label = UILabel()
        label.text = "........................."
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    // MARK: Setup Cell
    fileprivate func setupCell() {
        roundCorner()
        setCellShadow()
        self.addSubview(sentiment)
        self.addSubview(text)
        
        sentiment.anchor(top: safeTopAnchor, left: safeLeftAnchor, bottom: nil, right: safeRightAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        
        text.anchor(top: sentiment.bottomAnchor, left: safeLeftAnchor, bottom: safeBottomAnchor, right: safeRightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: -25, paddingRight: 20)
    }
    
    // MARK: Methods
    func setCellShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 6.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 14
        self.clipsToBounds = false
    }
    
    func roundCorner() {
        self.contentView.layer.cornerRadius = 14
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 3.0
        self.contentView.layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        self.contentView.backgroundColor = .white
    }
    
}

