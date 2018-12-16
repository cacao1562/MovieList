//
//  CommentsCell.swift
//  MovieList
//
//  Created by hwan ung Yu on 16/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var writer: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var contents: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
