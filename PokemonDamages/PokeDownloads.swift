//
//  PokeDownloads.swift
//  PokemonDamages
//
//  Created by Thiago-Bernardes on 8/17/16.
//  Copyright © 2016 TMB. All rights reserved.
//

import UIKit

class PokeDownloads: NSObject {
    
    
    class func fetchPokemonTypes(completionBlock: (pokemonTypeNames: [String]) -> Void) {
        
        let requestURL: NSURL = NSURL(string: "http://pokeapi.co/api/v2/type/")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                print("Everyone is fine, file downloaded successfully.")
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as! NSDictionary
                    let names = self.parsePokemonTypes(json)
                    completionBlock(pokemonTypeNames: names)
                }catch {
                    print("Error with Json: \(error)")
                }
                
            }
        }
        
        task.resume()
        
    }

    
    class func parsePokemonTypes(json: NSDictionary) -> [String] {
        
        var pokemonNames = [String]()
        if let pokemonTypes = json["results"]  as? NSArray{
            for pokemonType in pokemonTypes {
                if let name = pokemonType["name"]  as? String {
                    pokemonNames.append(name)
                }
            }
        }
        
        return pokemonNames
    }
    
    
}
