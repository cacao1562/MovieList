//
//  MovieTableViewCell.swift
//  MovieBox
//
//  Created by hwan ung Yu on 12/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var thumb_img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var grade_img: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var reservation_grade: UILabel!
    @IBOutlet weak var reservation_rate: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
