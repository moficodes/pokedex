//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Mofizur Rahman on 4/1/17.
//  Copyright © 2017 Mofizur Rahman. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalized
        mainImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        currentEvoImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        pokedexLbl.text = "\(self.pokemon.pokedexId)"
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }
    
    func updateUI(){
        typeLbl.text = self.pokemon.type
        heightLbl.text = self.pokemon.height
        weightLbl.text = self.pokemon.weight
        attackLbl.text = self.pokemon.attack
        defenseLbl.text = self.pokemon.defense
        evoLbl.text = self.pokemon.nextEvolution
        nextEvoImage.image = UIImage(named: "\(self.pokemon.nextEvolutionID)")
        descriptionLbl.text = self.pokemon.description
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
