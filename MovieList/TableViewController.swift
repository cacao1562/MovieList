//
//  TableViewController.swift
//  MovieList
//
//  Created by hwan ung Yu on 15/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import UIKit

class TableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    

    @IBOutlet var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.register(UINib(nibName: "TCell", bundle: nil), forCellReuseIdentifier: "tcell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tcell", for: indexPath) as! TCell
        if(indexPath.row % 2 == 0) {
            cell.textview.text = "aaaaaaaaaaaaaa"
        }
        
        return cell
    }
    
    
    
    
    // MARK: - Table view data source

}
