//
//  ViewController.swift
//  SentimentAnalysisApp
//
//  Created by M'haimdat omar on 03-08-2019.
//  Copyright © 2019 M'haimdat omar. All rights reserved.
//

import UIKit
import CoreML
import NaturalLanguage

class ViewController: UIViewController {
    
    let cellId = "cellId"
    var cells = [Model]()
    var selectArray : [IndexPath] = []
    
    var newCollection: UICollectionView = {
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.backgroundColor = UIColor.clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsVerticalScrollIndicator = false
        collection.allowsMultipleSelection = true
        
        return collection
    }()
    
    var dictionarySelectedIndexPath: [IndexPath: Bool] = [:]
    
    enum Mode {
        case view
        case select
    }
    
    var mMode: Mode = .view {
        didSet {
            switch mMode {
            case .view:
                for (key, value) in dictionarySelectedIndexPath {
                    if value {
                        self.newCollection.deselectItem(at: key, animated: true)
                    }
                }
                
                dictionarySelectedIndexPath.removeAll()
                self.navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .edit, target: self, action: #selector(editCell(_:)))
                newCollection.allowsMultipleSelection = false
                self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addCell(_:)))
            case .select:
                self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelCell(_:)))
                self.navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked(_:)))
                newCollection.allowsMultipleSelection = true
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTabBar()
        self.setupCollection()
        self.setupCollectionView()
    }
    
    
    func setupTabBar() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "IMDB Reviews"
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = .lightText
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.barStyle = .default
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addCell(_:)))
        self.navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .edit, target: self, action: #selector(editCell(_:)))
    }
    
    func setupCollection() {
        
        self.view.addSubview(newCollection)
        
        newCollection.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        newCollection.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        newCollection.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        newCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        newCollection.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        newCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
    }
    
    func setupCollectionView() {
        newCollection.backgroundColor = .white
        newCollection.register(ViewControllerCell.self, forCellWithReuseIdentifier: cellId)
        newCollection.alwaysBounceVertical = true
        newCollection.delegate = self
        newCollection.dataSource = self
        
    }
    
    @objc func addCell(_ sender: UIBarButtonItem) {
        
        let model = IMDBReviewClassifier()
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Review"
        }
        let confirmAction = UIAlertAction(title: "Sentiment analysis", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
            if let text = textField.text {
                do {
                    let prediction = try model.prediction(text: text)
                    if prediction.label == "Positive" {
                        let cell = Model(text: text, color: UIColor.green, sentiment: prediction.label)
                        self.cells.append(cell)
                        self.newCollection.reloadData()
                    } else {
                        let cell = Model(text: text, color: UIColor.red, sentiment: prediction.label)
                        self.cells.append(cell)
                        self.newCollection.reloadData()
                    }
                } catch {
                    print(error)
                }
            }
        }
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
     @objc func editCell(_ sender: UIBarButtonItem) {
        mMode = mMode == .view ? .select : .view
    }
    
    @objc func didDeleteButtonClicked(_ sender: UIBarButtonItem) {
        var deleteNeededIndexPaths: [IndexPath] = []
        for (key, value) in dictionarySelectedIndexPath {
            if value {
                deleteNeededIndexPaths.append(key)
            }
        }
        
        for i in deleteNeededIndexPaths.sorted(by: { $0.item > $1.item }) {
            cells.remove(at: i.item)
        }
        
        newCollection.deleteItems(at: deleteNeededIndexPaths)
        dictionarySelectedIndexPath.removeAll()
    }
    @objc func cancelCell(_ sender: UIBarButtonItem) {
        mMode = mMode == .select ? .view : .select
    }

}

