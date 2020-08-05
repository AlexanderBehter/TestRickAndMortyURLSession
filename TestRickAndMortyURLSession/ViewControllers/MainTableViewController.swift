//
//  MainTableViewController.swift
//  TestRickAndMortyURLSession
//
//  Created by Александр Бехтер on 24.07.2020.
//  Copyright © 2020 Александр Бехтер. All rights reserved.
//

import UIKit


class MainTableViewController: UITableViewController {

    private var character: Character?
    private let urlString = "https://rickandmortyapi.com/api/character"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        
        NetworkManager.shared.fetchData(from: urlString) { character in
            DispatchQueue.main.async {
                self.character = character
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.configure(with: character?.results[indexPath.row])
        
        return cell
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let person = character?.results[indexPath.row]
        let detailVC = segue.destination as! DetailViewController
        detailVC.character = person
    }
}
