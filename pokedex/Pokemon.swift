//
//  Pokemon.swift
//  pokedex
//
//  Created by Mofizur Rahman on 4/1/17.
//  Copyright © 2017 Mofizur Rahman. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolution: String!
    private var _nextEvolutionID: String!
    
    private var _pokemonURL: String!
    
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var nextEvolution: String {
        if _nextEvolution == nil {
            _nextEvolution = "No Evolution Available"
        }
        return _nextEvolution
    }
    
    var nextEvolutionID: String{
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    
    
    
    init(name:String, pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
        
        
        
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        Alamofire.request(self._pokemonURL).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0{
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    if types.count > 1{
                        for x in 1..<types.count{
                            if let name = types[x]["name"]{
                                self._type! += " / \(name.capitalized)"
                            }
                        }
                    }
                    
                }else{
                    self._type = "None"
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count>0{
                    self._nextEvolution = ""
                    if let to = evolutions[0]["to"] as? String{
                        if !to.contains("mega"){
                            self._nextEvolution! += "Next Evolution: \(to) "
                            if let level = evolutions[0]["level"] as? Int{
                                self._nextEvolution! += "LVL \(level)"
                            }
                            if let evoUri = evolutions[0]["resource_uri"] as? String{
                                let newStr = evoUri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                self._nextEvolutionID = newStr.replacingOccurrences(of: "/", with: "")
                            }
                        }else{
                            self._nextEvolution! += "No Evolution Available"
                        }
                    }

                }
                
                if let descArray = dict["descriptions"] as? [Dictionary<String,String>] , descArray.count > 0 {
                    if let url = descArray[0]["resource_uri"]{
                        let descURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descURL).responseJSON { (response) in
                            if let desc = response.result.value as? Dictionary<String, AnyObject>{
                                if let description = desc["description"] as? String{
                                    self._description = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                }
                                print (self._description)
                            }
                            completed()
                        }
                    }
                }
//                print (self._weight)
//                print (self._height)
//                print (self._attack)
//                print (self._defense)
            }
            completed()
        }
    }
    
}
