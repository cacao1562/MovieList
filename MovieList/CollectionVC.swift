//
//  CollectionVC.swift
//  MovieList
//
//  Created by hwan ung Yu on 14/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import Foundation
import UIKit

class CollectionVC : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var movieinfoArr : [MovieInfo] = []
    var thumbImageArr : [UIImage?] = []
    
    @IBOutlet weak var outletCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CollectionCell", bundle: nil)
        outletCollectionView.register(nib, forCellWithReuseIdentifier: "cCell")
        self.navigationItem.title = "예매율"
    }
    
    @IBAction func sortButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "예매율", style: .default, handler: { (action) in
            self.callApi(typeNum: 0)
            self.navigationItem.title = "예매율"
        }))
        alert.addAction(UIAlertAction(title: "큐레이션", style: .default, handler: { (action) in
            self.callApi(typeNum: 1)
            self.navigationItem.title = "큐레이션"
        }))
        alert.addAction(UIAlertAction(title: "개봉일", style: .default, handler: { (action) in
            self.callApi(typeNum: 2)
            self.navigationItem.title = "예매율"
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
   
    func callApi(typeNum type : Int) {
        
        self.movieinfoArr.removeAll()
        self.thumbImageArr.removeAll()
        
        NetworkManager.getMovies(typeNumber : type) { result , error  in
            
            if (error) {
                
                let alert = UIAlertController(title: "알림", message: "데이터를 가져오지 못했습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
            for row in result.movies {
                
                self.movieinfoArr.append(row)
                self.thumbImageArr.append(nil)
                
            }
            self.outletCollectionView.reloadData()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieinfoArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cCell", for: indexPath) as! CollectionCell
        
        DispatchQueue.main.async {
            cell.thumb_img.image = self.getThumbnailImage(indexPath.row)
        }
        let grade = movieinfoArr[indexPath.row].reservation_grade // 예매순위
        let rating = movieinfoArr[indexPath.row].user_rating // 사용자 평점
        let rate = movieinfoArr[indexPath.row].reservation_rate // 예매율
        cell.reservation_info.text = "\(grade)위(\(rating)) / \(rate)% "
        
        cell.title.text = movieinfoArr[indexPath.row].title
        cell.date.text = movieinfoArr[indexPath.row].date
        cell.grade_img.image = UIImage(named: "\(movieinfoArr[indexPath.row].grade)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
        var count = 0
        NetworkManager.getComments(movieId: self.movieinfoArr[indexPath.row].id) { (result, error) in
            
            self.showError(error: error)
            vc.commentsArr = result.comments
            print("comments compleet")
            count += 1
            if (count == 2) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        NetworkManager.getDetail(movieId: self.movieinfoArr[indexPath.row].id) { (result, error) in
            
            self.showError(error: error)
            vc.detailArr = result
            print("detail complet")
            count += 1
            if (count == 2) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (self.view.frame.width - 20 ) / 2, height: (self.view.frame.height - 30 ) / 2 )
    }
    
    
    func getThumbnailImage( _ index : Int) -> UIImage {
        
        var mvo = self.movieinfoArr[index]
        
        if thumbImageArr.isEmpty{
            
            let url : URL! = URL(string: mvo.thumb)
            let imageData = try! Data(contentsOf: url)
            let thumbimg = UIImage(data: imageData)
            thumbImageArr.insert(thumbimg, at: index)
            return thumbimg!
        }else {
            
            if let savedImage = thumbImageArr[index] {
                
                return savedImage
            } else {
                
                let url : URL! = URL(string: mvo.thumb)
                let imageData = try! Data(contentsOf: url)
                let thumbimg = UIImage(data: imageData)
                thumbImageArr.insert(thumbimg, at: index)
                return thumbimg!
            }
        }
        
    }
    
    

    
}
