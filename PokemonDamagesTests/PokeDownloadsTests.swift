//
//  PokeDownloadsTests.swift
//  PokemonDamages
//
//  Created by Thiago-Bernardes on 8/18/16.
//  Copyright © 2016 TMB. All rights reserved.
//

import XCTest

@testable import PokemonDamages
class PokeDownloadsTests: XCTestCase {
    var pokemonTypes = [String]()
    
    func testFetchPokemonTypes() {
        
        let asyncExpectation = expectationWithDescription("Running fetchPokemonTypes function")
        
        let completionBlock = { (pokemonTypes: [String]) -> ()  in
            self.pokemonTypes = pokemonTypes
            asyncExpectation.fulfill()
        }
        
        PokeDownloads.fetchPokemonTypes(completionBlock)
        
        waitForExpectationsWithTimeout(5.0){ (error) in
            XCTAssertEqual(self.pokemonTypes.count, 20)
            XCTAssertTrue(self.pokemonTypes.contains("fire"))
            XCTAssertTrue(self.pokemonTypes.contains("normal"))
            XCTAssertTrue(self.pokemonTypes.contains("electric"))
            XCTAssertTrue(self.pokemonTypes.contains("water"))
        }
    }
    
    func testFetchPokemonRelatedDamageTypeAndPokemonType() {
        
        let asyncExpectation = expectationWithDescription("Running fetchPokemonRelatedDamagePokemonType function")
        var pokemonDamageAndPokemonTypes : [String:[String]]!
        
        /// [ DamageType1 : [PokemonType1, PokemonType2], DamageType2: [PokemonType3, PokemonType5], DoubleDamage: [Fire, Normal] ]
        let completionBlock = { (damageAndPokemonTypes : [String:[String]])  in
            pokemonDamageAndPokemonTypes = damageAndPokemonTypes
            asyncExpectation.fulfill()
        }
        
        let pokemonType = "electric"
        
        /**
         *  This is a meta call of the method with following:
         *
         *  @param pokemonType     Can be "fire", "water" and any pokemon type of the last api listed pokemon types
         *  @param completionBlock Block runned after the request in the url: http://pokeapi.co/api/v2/type/"pokemon type name" eg: http://pokeapi.co/api/v2/type/fire. The block have a parameter damageAndPokemonTypes that is the dictionary containing the damage type: DoublaDamage, None, etc. And the pokemon type that provides this damage eg: "fire", "water".  For example water, have a double damage in fire pokemons.
         *
         *  @return Void function
         */
        PokeDownloads.fetchPokemonRelatedDamageTypeAndPokemonType(pokemonType,completionBlock: completionBlock)
        
        waitForExpectationsWithTimeout(5.0){ (error) in
            
            
            XCTAssertTrue(pokemonDamageAndPokemonTypes.keys.count == 6)
            XCTAssertTrue(pokemonDamageAndPokemonTypes.keys.contains("half_damage_from"))
            XCTAssertTrue(pokemonDamageAndPokemonTypes.keys.contains("no_damage_from"))
            XCTAssertTrue(pokemonDamageAndPokemonTypes.keys.contains("half_damage_to"))
            XCTAssertTrue(pokemonDamageAndPokemonTypes.keys.contains("double_damage_from"))
            XCTAssertTrue(pokemonDamageAndPokemonTypes.keys.contains("no_damage_to"))
            XCTAssertTrue(pokemonDamageAndPokemonTypes.keys.contains("double_damage_to"))

            let halfDamageFrom = pokemonDamageAndPokemonTypes["half_damage_from"]! as [String]
            let noDamageFrom = pokemonDamageAndPokemonTypes["no_damage_from"]! as [String]
            let halfDamageTo = pokemonDamageAndPokemonTypes["half_damage_to"]! as [String]
            let doubleDamageFrom = pokemonDamageAndPokemonTypes["double_damage_from"]! as [String]
            let noDamageTo = pokemonDamageAndPokemonTypes["no_damage_to"]! as [String]
            let doubleDamageTo = pokemonDamageAndPokemonTypes["double_damage_to"]! as [String]
            

            XCTAssertTrue(halfDamageFrom.contains("flying"))
            XCTAssertTrue(noDamageFrom.count == 0)
            XCTAssertTrue(halfDamageTo.contains("grass"))
            XCTAssertTrue(doubleDamageFrom.contains("ground"))
            XCTAssertTrue(noDamageTo.contains("ground"))
            XCTAssertTrue(doubleDamageTo.contains("water"))
            
        }
    }
    
    
}
