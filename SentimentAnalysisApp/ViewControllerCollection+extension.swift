//
//  ViewControllerCollection+extension.swift
//  SentimentAnalysisApp
//
//  Created by M'haimdat omar on 03-08-2019.
//  Copyright © 2019 M'haimdat omar. All rights reserved.
//

import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ViewControllerCell
        
        cell.sentiment.text = "\(self.cells[indexPath.row].sentiment)"
        cell.text.text = self.cells[indexPath.row].text
        cell.contentView.layer.borderColor = self.cells[indexPath.row].color.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = round((view.frame.width - 40) / 2.0)*2
        
        let height = self.cells[indexPath.row].text.heightWithConstrainedWidth(width: width, font: UIFont.boldSystemFont(ofSize: 12)) + 90
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 0, bottom: 25, right: 0)
    }
}


extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
