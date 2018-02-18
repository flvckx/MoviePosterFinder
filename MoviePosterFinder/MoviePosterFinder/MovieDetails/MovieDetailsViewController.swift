//
//  MovieDetailsViewController.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieCreationDateLabel: UILabel!
    
    var movie: Movie!
    var image: UIImage?
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        moviePosterImageView.image = image
        movieNameLabel.text = movie.name
        
        if let date = movie.releasedDate {
            movieCreationDateLabel.text = dateFormatter.string(from: date as Date)
        }
    }
}
