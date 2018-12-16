//
//  CollectionCell.swift
//  MovieList
//
//  Created by hwan ung Yu on 14/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {

    @IBOutlet weak var thumb_img: UIImageView!
    @IBOutlet weak var grade_img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var reservation_info: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
