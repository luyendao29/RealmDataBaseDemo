//
//  BookTableViewCell.swift
//  RealmDataBaseDemo
//
//  Created by Boss on 9/23/19.
//  Copyright © 2019 LuyệnĐào. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private var onToggleCompleted: ((BookItem) -> Void)?
    private var book: BookItem?
    
    func configureWith(_ book: BookItem, onToggleCompleted: ((BookItem) -> Void)? = nil) {
        self.book = book
        self.onToggleCompleted = onToggleCompleted
        self.textLabel?.text = book.name
        self.accessoryType = book.isCompleted ? .checkmark : .none
    }
    
    func toggleCompleted() {
        guard let book = book else { fatalError("Không tìm thấy sách") }
        
        onToggleCompleted?(book)
    }

}
