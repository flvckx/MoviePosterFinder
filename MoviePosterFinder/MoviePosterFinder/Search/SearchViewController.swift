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
    
    private let movieNetwork: MovieNetworkManager = MovieNetwork()
    
    private var movieDetails: (Movie, UIImage?)?
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    @IBAction func searchTouched(_ sender: Any) {
        movieNameTextField.endEditing(true)
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let searchQuery = movieNameTextField.text, !searchQuery.isEmpty else {
            activityIndicator.stopAnimating()
            showAlert("The field cannot be empty!")
            return
        }
        
        movieNetwork.search(searchQuery) { (movie, image, error) in
            if let error = error as NSError? {
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    
                    if let errorMessage = error.userInfo["Error"] as? String {
                        self?.showAlert(errorMessage)
                    } else {
                        self?.showAlert("Error: \(error), \(error.userInfo)")
                    }
                }
            } else if let movie = movie {
                self.movieDetails = (movie, image)
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.performSegue(withIdentifier: "showMovieDetails", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let movieDetailsViewController = segue.destination as? MovieDetailsViewController,
            let movieDetails = movieDetails {
            movieDetailsViewController.movie = movieDetails.0
            movieDetailsViewController.image = movieDetails.1
        }
    }
}

