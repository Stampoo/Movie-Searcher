//
//  Data.swift
//  filmInfo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//
import Foundation

//MARK: - Class implements load and translate data in structs Model and MovieList
final class GetData {
    
    // Complition closer for transfer data, ifError for handling error at parsing or load
    func request(link: String, onComplete: @escaping ([Result]) -> Void, ifError: @escaping (StuckMoment) -> Void) {
        guard let url = URL(string: link) else {
            return ifError(.badLink)
        }
        //Create task for connect session
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, _, _) in
            guard let data = data else {
                return ifError(.errorResponce)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let result = try? decoder.decode(MovieList.self, from: data) else {
                ifError(.errorParcing)
                return
            }
            DispatchQueue.main.async {
                onComplete(result.results)
            }
        })
        //start up task
        task.resume()
    }
    
    // Complition closer for transfer data, ifError for handling error at parsing or load
    func request(link: String, complition: @escaping (Movie) -> Void, ifError: @escaping (StuckMoment) -> Void) {
        guard let url = URL(string: link) else {
            return ifError(.badLink
            )}
        let _ = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, responce, error) in
            guard let data = data else {
                return ifError(.errorResponce)
            }
            //let queue = DispatchQueue.global(qos: .utility)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                //try translate recive data to struct
                let parce: Movie = try decoder.decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    complition(parce)
                }
            } catch {
                DispatchQueue.main.async {
                    ifError(.errorParcing)
                    print(error)
                }
            }
        })
        //Create task for connect session
        task.resume()
    }
    
    func searchRequest(link: String, onComplete: @escaping ([Result]) -> Void, onError: @escaping (StuckMoment) -> Void) {
        guard let url = URL(string: link) else {
            return onError(.badLink)
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return onError(.errorResponce)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let result = try? decoder.decode(MovieList.self, from: data) else {
                return onError(.errorParcing)
            }
            DispatchQueue.main.async {
                onComplete(result.results)
            }
        }.resume()
    }
    
}
