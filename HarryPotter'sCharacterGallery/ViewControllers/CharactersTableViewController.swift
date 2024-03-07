//
//  ViewController.swift
//  HarryPotter'sCharacterGallery
//
//  Created by Антон Баландин on 6.03.24.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    //MARK: Private properties
    private var charactersArray: [Character] = []
    private let url = URL(string: "https://hp-api.onrender.com/api/characters")
    private let networkManager = NetworkManager.shared
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        tableView.backgroundColor = .white
        
        fetchCharacters()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = charactersArray[indexPath.row]
        guard let detailVC = segue.destination as? CharacterDetailsViewController else { return }
        detailVC.character = character
    }
    
    // MARK: - Private methods
    private func fetchCharacters() {
        networkManager.fetch([Character].self, from: url) { [weak self] result in
            switch result {
            case .success(let character):
                self?.charactersArray = character
                self?.tableView.reloadData()
                print(character)
            case .failure(let error):
                print(error)
            }
        }
    }
}


// MARK: - Table view data source
extension CharactersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let cell = cell as? TableViewCell else {
            return UITableViewCell()
        }
        
        let character = charactersArray[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
}
