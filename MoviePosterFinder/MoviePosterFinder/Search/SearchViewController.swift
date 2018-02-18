//
//  ViewController.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var movieNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func searchTouched(_ sender: Any) {
        movieNameTextField.endEditing(true)
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        // request
        // stopAnimating()
        
        performSegue(withIdentifier: "showMovieDetails", sender: self)
    }
}

