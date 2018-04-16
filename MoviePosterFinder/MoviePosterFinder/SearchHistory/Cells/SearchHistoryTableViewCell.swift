//
//  SearchHistoryTableViewCell.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var searchDetails: UILabel!
    
    var searchMovieName: String? {
        didSet {
            searchDetails?.text = searchMovieName
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        searchDetails?.text = nil
    }
}
