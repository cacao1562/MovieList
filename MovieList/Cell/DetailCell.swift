//
//  DetailCell.swift
//  MovieList
//
//  Created by hwan ung Yu on 16/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var m_image: UIImageView!
    @IBOutlet weak var grade_image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var genre_duration: UILabel!
    @IBOutlet weak var reservation_info: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var audience: UILabel!
    @IBOutlet weak var synopsis: UITextView!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actor: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
