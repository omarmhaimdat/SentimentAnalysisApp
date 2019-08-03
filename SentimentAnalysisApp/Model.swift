//
//  Model.swift
//  SentimentAnalysisApp
//
//  Created by M'haimdat omar on 03-08-2019.
//  Copyright © 2019 M'haimdat omar. All rights reserved.
//

import Foundation
import UIKit

struct Model {
    var text: String
    var color: UIColor
    var sentiment: String
    
    init(text: String, color: UIColor, sentiment: String) {
        self.text = text
        self.color = color
        self.sentiment = sentiment
    }
}
