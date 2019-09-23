//
//  BookTableViewController.swift
//  RealmDataBaseDemo
//
//  Created by Boss on 9/23/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import UIKit
import RealmSwift

class BookTableViewController: UITableViewController {

    
    private var books: Results<BookItem>?

    override func viewDidLoad() {
        super.viewDidLoad()
        books = BookItem.getAll()
        //tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books?.count ?? 0
    }
    
    @IBAction func OnAddButtonClicked(_ sender: Any) {
        showInputBookAlert("Add book name") { name in
            BookItem.add(name: name)
        }
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BookTableViewCell,
            let book = books?[indexPath.row] else{
                return BookTableViewCell()
        }
        cell.configureWith(book) { [weak self]
            book in
            book.toggleCompleted()
            self?.tableView.reloadData()
        }
        
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BookTableViewCell else {
            return
        }
        
        cell.toggleCompleted()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let book = books?[indexPath.row],
            editingStyle == .delete else { return }
        book.delete()
        tableView.reloadData()
    }
    func showInputBookAlert(_ title: String, isSecure: Bool = false, text: String? = nil, callback: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { field in
            field.isSecureTextEntry = isSecure
            field.text = text
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                
                return
            }
            
            callback(text)
        })
        
        let root = UIApplication.shared.keyWindow?.rootViewController
        root?.present(alert, animated: true, completion: nil)
    }
    
}
