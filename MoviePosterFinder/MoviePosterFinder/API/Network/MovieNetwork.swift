//
//  MovieNetworkProvider.swift
//  MoviePosterFinder
//
//  Created by Serhii Palash on 18/02/2018.
//  Copyright © 2018 Serhii Palash. All rights reserved.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

class MovieNetwork {
    
    private let movieProvider = MovieProvider()
    
    private let baseUrl = URL(string: "http://www.omdbapi.com/")!
    private var parameters: [String: Any] = [:]
    
    func search(_ name: String, completion: @escaping (_ movie: Movie?, _ image: UIImage?, _ error: Error?) -> Void) {
        guard let url = urlPath(name) else {
            return
        }
        
        if let movie = movieProvider.findInStorage(url.absoluteString) {
            guard let image = movie.image, let imageURL = URL(string: image) else {
                completion(movie, nil, nil)
                return
            }
            
            getImage(imageURL, completion: { (image, error) in
                completion(movie, image, error)
            })
        } else {
            getMovie(url, completion: { (movie, error) in
                guard let image = movie?.image, let imageURL = URL(string: image) else {
                    completion(movie, nil, nil)
                    return
                }
                
                self.getImage(imageURL, completion: { (image, error) in
                    completion(movie, image, error)
                })
            })
        }
        
    }
    
    private func getMovie(_ url: URL, completion: @escaping (_ movie: Movie?, _ error: Error?) -> Void) {
        downloadData(url: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            do {
                let movie = try self.movieProvider.decodeToStorage(data, urlPath: url.absoluteString)
                completion(movie, nil)
            } catch let error {
                completion(nil, error)
            }
        }
    }
    
    private func getImage(_ url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            downloadData(url: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                } else if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                }
            }
        }
    }
    
    private func urlPath(_ title: String) -> URL? {
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: "t", value: title)
        ]
        
        return urlComponents?.url
    }
    
    private func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
            completion(data, response, error)
        }
        .resume()
    }
}
