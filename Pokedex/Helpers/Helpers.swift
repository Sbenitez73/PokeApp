//
//  Helpers.swift
//  Pokedex
//
//  Created by Santiago Benitez on 10/3/23.
//

import Foundation


extension Bundle {
    
    func decode<T:Decodable>(file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in budle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not find \(file) in budle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not find \(file) in budle.")
        }
        
        return loadedData
    }
    
    func fetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping(T) -> (), failture: @escaping(Error) -> ()) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else {
                if let error = error {
                    failture(error)
                }
                return
            }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
            } catch {
                failture(error)
            }
        }
        
        .resume()
    }
}
