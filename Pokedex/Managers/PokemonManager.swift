//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Santiago Benitez on 10/3/23.
//

import Foundation

class PokemonManager {
    
    func getPokemon() -> [Pokemon] {
        let data: PokemonPage = Bundle.main.decode(file: "pokemon.json")
        let pokemon: [Pokemon] = data.results
        return pokemon
    }
    
    
    func getDetailedPokemon(id: Int, completionHandler:@escaping (DetailPokemon) -> ()) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            if let error = error {
                print("Error: \(error)")
            }
            
            if let data = data,
               let detailedPokemon = try? JSONDecoder().decode(DetailPokemon.self, from: data) {
                completionHandler(detailedPokemon)
            }
                
        })
        
        task.resume()
        
    }
        
}
                                              
                                              
