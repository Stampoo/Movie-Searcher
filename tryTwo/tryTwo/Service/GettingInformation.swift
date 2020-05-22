//
//  Data.swift
//  filmInfo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//
import Foundation

//TODO: - refactor this class in future

final class GettingInformation {

    //MARK: - Private properties

    private let session = URLSession.shared
    private let mainQueue = DispatchQueue.main
    

    //MARK: - Public methods

    func requestMovieList(link: String, completionHandler: @escaping ([Result]) -> Void, errorHandler: @escaping (ErrorCases) -> Void) {
        guard let url = URL(string: link) else {
            return errorHandler(.badLink)
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, _, _) in
            guard let data = data else {
                return errorHandler(.errorInResponce)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let result = try? decoder.decode(MovieList.self, from: data) else {
                errorHandler(.errorParcing)
                return
            }
            DispatchQueue.main.async {
                completionHandler(result.results)
            }
        })
        task.resume()
    }

    func requestMovie(link: String, completionHandler: @escaping (Movie) -> Void, errorHandler: @escaping (ErrorCases) -> Void) {
        guard let url = URL(string: link) else {
            return errorHandler(.badLink
            )}
        let _ = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, responce, error) in
            guard let data = data else {
                return errorHandler(.errorInResponce)
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let parce: Movie = try decoder.decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(parce)
                }
            } catch {
                DispatchQueue.main.async {
                    errorHandler(.errorParcing)
                    print(error)
                }
            }
        })
        task.resume()
    }

    func requestSearch(link: String, complitionHandler: @escaping ([Result]) -> Void, errorHandler: @escaping (ErrorCases) -> Void) {
        guard let url = URL(string: link) else {
            return errorHandler(.badLink)
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return errorHandler(.errorInResponce)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let result = try? decoder.decode(MovieList.self, from: data) else {
                return errorHandler(.errorParcing)
            }
            DispatchQueue.main.async {
                complitionHandler(result.results)
            }
        }.resume()
    }
    
    func requestCast(link: String, completionHandler: @escaping ([Cast]) -> Void, errorHandler: @escaping (ErrorCases) -> Void) {
        guard let url = URL(string: link) else {
            return errorHandler(.badLink)
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return errorHandler(.errorInResponce)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let result = try? decoder.decode(CastList.self, from: data) else {
                return errorHandler(.errorParcing)
            }
            DispatchQueue.main.async {
                completionHandler(result.cast)
            }
        }.resume()
    }

    func requestActor(link: String, completionHandler: @escaping (Actor) -> Void, errorHandler: @escaping (ErrorCases) -> Void) {
        guard let url = URL(string: link) else {
            return errorHandler(.badLink)
        }
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return errorHandler(.errorInResponce)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let actor = try? decoder.decode(Actor.self, from: data) else {
                return errorHandler(.errorParcing)
            }
            self.mainQueue.async {
                completionHandler(actor)
            }
        }
    }
    
}
