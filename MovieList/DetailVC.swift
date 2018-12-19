//
//  DetailVC.swift
//  MovieList
//
//  Created by hwan ung Yu on 15/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import Foundation
import UIKit

class DetailVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    
    @IBOutlet weak var tableview: UITableView!
    
    var detailArr : DetailVO!
    var commentsArr : [CommentsInfo] = []
    var movieImage : UIImage?
    var starImage : [UIImage] = []
    var commentStarImage : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "dCell")     //0번째 셀
        tableview.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "comCell") //한줄평 셀
        setStarimg(rating: detailArr.user_rating)
        self.navigationItem.title = detailArr.title
        self.navigationController?.navigationBar.tintColor = .white
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArr.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (indexPath.row == 0) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "dCell", for: indexPath) as! DetailCell
            
            DispatchQueue.main.async {
                cell.m_image.image = self.getThumbnailImage()
            }
            cell.grade_image.image = UIImage(named: "\(detailArr.grade)")
            cell.title.text = detailArr.title
            cell.date.text = detailArr.date + "개봉"
            cell.genre_duration.text = detailArr.genre + " / \(detailArr.duration)분"
            cell.reservation_info.text = "\(detailArr.reservation_grade)위 " + "\(detailArr.reservation_rate)%"
            cell.rating.text = "\(detailArr.user_rating)"
            cell.audience.text = "\(detailArr.audience)"
            cell.synopsis.text = detailArr.synopsis
            cell.director.text = detailArr.director
            cell.actor.text = detailArr.actor
            cell.actor.sizeToFit()
        
            cell.star1.image = starImage[0]
            cell.star2.image = starImage[1]
            cell.star3.image = starImage[2]
            cell.star4.image = starImage[3]
            cell.star5.image = starImage[4]
            
            
            return cell
            
        }else {
            
            commentSetStarimg(rating: commentsArr[indexPath.row - 1].rating)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "comCell", for: indexPath) as! CommentsCell
            
            cell.writer.text = commentsArr[indexPath.row - 1].writer
            cell.timestamp.text = commentsArr[indexPath.row - 1].timestamp.toDayTime
            cell.star1.image = commentStarImage[0]
            cell.star2.image = commentStarImage[1]
            cell.star3.image = commentStarImage[2]
            cell.star4.image = commentStarImage[3]
            cell.star5.image = commentStarImage[4]
            cell.contents.text = commentsArr[indexPath.row - 1].contents
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func setStarimg(rating : Double)  {
        
        let value = Int(rating)
        let a = value / 2
        let b = value % 2
       
        if(b == 0) {
            for _ in 0..<a {
                starImage.append(UIImage(named: "star1")!)
            }
            for _ in 0..<5-a {
                starImage.append(UIImage(named: "star2")!)
            }
        }else {
            for _ in 0..<a {
                starImage.append(UIImage(named: "star1")!)
            }
            starImage.append(UIImage(named: "star3")!)
            for _ in 0..<5 - a + 1 {
                starImage.append(UIImage(named: "star2")!)
            }
        }
        
    }
    
    
    
    func commentSetStarimg(rating : Double)  {
        
        commentStarImage.removeAll()
        
        let value = Int(rating)
        let a = value / 2
        let b = value % 2
       
        if(b == 0) {
            for _ in 0..<a {
                commentStarImage.append(UIImage(named: "star1")!)
            }
            for _ in 0..<5-a {
                commentStarImage.append(UIImage(named: "star2")!)
            }
        }else {
            for _ in 0..<a {
                commentStarImage.append(UIImage(named: "star1")!)
            }
            commentStarImage.append(UIImage(named: "star3")!)
            for _ in 0..<5 - a + 1 {
                commentStarImage.append(UIImage(named: "star2")!)
            }
        }
        
    }
    
    
    func getThumbnailImage() -> UIImage {
        
        let imgUrl = self.detailArr.image
            
        if let savedImage = movieImage {
                
            return savedImage
            
        } else {
                
            let url : URL! = URL(string: imgUrl)
            let imageData = try! Data(contentsOf: url)
            movieImage = UIImage(data: imageData)
            
            return movieImage!
        }
    }
    
    
    
}


extension Double {
    
    var toDayTime : String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date(timeIntervalSince1970: self)
        
        return dateFormatter.string(from: date)
    }
}
