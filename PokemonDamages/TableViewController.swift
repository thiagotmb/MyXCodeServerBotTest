//
//  TableViewController.swift
//  PokemonDamages
//
//  Created by Thiago-Bernardes on 8/17/16.
//  Copyright © 2016 TMB. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var pokemonTypes = [String]() {
        didSet{
            pokemonTypes.sortInPlace(<)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PokeDownloads.fetchPokemonTypes { (pokemonTypeNames) in
            self.pokemonTypes = pokemonTypeNames
        }
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonTypes.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let pokemonType = pokemonTypes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("pokemonCell", forIndexPath: indexPath)
        cell.textLabel?.text = pokemonType
        
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
