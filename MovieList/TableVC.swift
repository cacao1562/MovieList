//
//  ViewController.swift
//  MovieList
//
//  Created by hwan ung Yu on 13/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import UIKit

class TableVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate {

    @IBOutlet weak var outletTableView: UITableView!
    
    var movieinfoArr : [MovieInfo] = []
    var thumbImageArr : [UIImage?] = []

    var tabcheck = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self

        callApi(typeNum: 0)
    
        outletTableView.delegate = self
        outletTableView.dataSource = self
        
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        outletTableView.register(nib, forCellReuseIdentifier: "tCell")
        
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
            self.navigationItem.title = "개봉일"
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    
    func callApi(typeNum type : Int) {
        
        self.movieinfoArr.removeAll()
        self.thumbImageArr.removeAll()
        
        NetworkManager.getMovies(typeNumber : type) { result, error  in
            
            self.showError(error: error)
                for row in result.movies {
                
                    self.movieinfoArr.append(row)
                    self.thumbImageArr.append(nil)
                
                }
                self.outletTableView.reloadData()
            
        }
        
    }
    
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieinfoArr.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath) as! MovieCell
        cell.title.text = movieinfoArr[indexPath.row].title
        cell.rating.text = "평점 : " + String(describing: movieinfoArr[indexPath.row].user_rating)
        cell.reservation_grade.text = "예매순위 : " + String(describing: movieinfoArr[indexPath.row].reservation_grade)
        cell.reservation_rate.text = "예매율 : " + String(describing: movieinfoArr[indexPath.row].reservation_rate)
        cell.date.text = "개봉일 : " + movieinfoArr[indexPath.row].date
        cell.grade_img.image = UIImage(named: "\(movieinfoArr[indexPath.row].grade)") 
        DispatchQueue.main.async {
            cell.thumb_img.image = self.getThumbnailImage(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
    
    
    func getThumbnailImage( _ index : Int) -> UIImage {
        
        let mvo = self.movieinfoArr[index]
        
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
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if (tabcheck) {
            print("should select = \(tabBarController.selectedIndex)" )
            if (tabBarController.selectedIndex == 1) {
                
                let nav = viewController as! UINavigationController
                if let vc = nav.topViewController as? CollectionVC {
                    vc.movieinfoArr = self.movieinfoArr
                    vc.thumbImageArr = self.thumbImageArr
                    print("vc = \(vc.movieinfoArr.count)")
                    tabcheck = false
                }
                
                
            }
        }
        
        
    }
    
    
    
  

}

extension UIViewController {
    
    func showError(error : Bool) {
        
        if (error) {
            let alert = UIAlertController(title: "알림", message: "데이터를 가져오지 못했습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
