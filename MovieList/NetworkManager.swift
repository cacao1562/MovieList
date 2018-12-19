//
//  NetworkManager.swift
//  MovieList
//
//  Created by hwan ung Yu on 13/12/2018.
//  Copyright © 2018 hwan ung Yu. All rights reserved.
//

import UIKit
import Foundation


struct MovieVO : Codable {
    var movies : [MovieInfo]
}
struct MovieInfo : Codable {
    
    var thumb : String
    var id : String
    var reservation_grade : Int
    var title : String
    var grade : Int
    var user_rating : Double
    var reservation_rate : Double
    var date : String
    
//    enum CodingKeys : String, CodingKey {
//        case thumb = "thumb"
//        case id = "id"
//        case reservation_grade = "reservation_grade"
//        case title = "title"
//        case grade = "grade"
//        case user_rating = "user_rating"
//        case reservation_rate = "reservation_rate"
//        case date = "date"
//    }
    
    
}

struct DetailVO : Codable {
    
    var audience : Int    //총 관람객수
    var actor : String  //  배우진
    var duration : Int   // 영화 상영 길이
    var director : String   // 감독
    var synopsis : String  //  줄거리
    var genre : String  //  영화 장르
    var grade : Int  //  관람등급
    var image : String //   포스터 이미지 주소
    var reservation_grade : Int //   예매순위
    var title : String  //  영화제목
    var reservation_rate : Double //   예매율
    var user_rating : Double  //  사용자 평점
    var date : String  //  개봉일
    var id : String  //  영화 고유 ID
    
   
    
    
}


struct CommentsVO : Codable {
    var comments : [CommentsInfo]
}

struct CommentsInfo : Codable {
    
    var rating : Double  //  평점
    var timestamp : Double    //작성일시 UNIX Timestamp 값
    var writer : String    //작성자
    var movie_id : String   // 영화 고유ID
    var contents : String  //  한줄평 내용
}




class NetworkManager {
    
    static var initdetail = DetailVO(audience: 0, actor: "a", duration: 0, director: "d", synopsis: "s", genre: "g", grade: 0, image: "i", reservation_grade: 0, title: "t", reservation_rate: 0.0, user_rating: 0.0, date: "d", id: "i")
    
    static func getMovies(typeNumber type: Int, completion : @escaping (_ result : MovieVO , Bool )-> () ) {
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        
        let mUrl = "http://connect-boxoffice.run.goorm.io/movies?order_type=\(type)"
//        print("movies url = " + mUrl )
        
        guard let url = URL(string: "\(mUrl)") else {
            print("Movies URL is nil")
            return
        }
        
        // Request
        let request = URLRequest(url: url)
        
        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            // getting Data Error
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                let decoder = JSONDecoder();
                do {
                    let result = try decoder.decode(MovieVO.self, from: data)
                  
                    DispatchQueue.main.async {
                        completion(result , false)
                    }
                    
                }catch {
                   
                    completion( MovieVO(movies: [MovieInfo]()), true)
                    print("Movies error = \(error)")
                }
                // 원하는 작업
            }
            
        }
        
        dataTask.resume()
    }
    
    
    
    static func getDetail(movieId id: String, completion : @escaping (_ result : DetailVO , Bool )-> () ) {
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        
        let mUrl = "http://connect-boxoffice.run.goorm.io/movie?id=\(id)"
//        print("derail url = " + mUrl )
        
        guard let url = URL(string: "\(mUrl)") else {
            print("Detail URL is nil")
            return
        }

        // Request
        let request = URLRequest(url: url)

        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            // getting Data Error
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }

            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                let decoder = JSONDecoder();
                do {
                    let result = try decoder.decode(DetailVO.self, from: data)
                  
                    DispatchQueue.main.async {
                        completion(result, false)
                    }

                }catch {
                    completion(initdetail , true)
                    print("Detail error = \(error)")
                }
                
            }

        }

        dataTask.resume()
    }
    
    
    
    static func getComments(movieId id: String, completion : @escaping (_ result : CommentsVO , Bool )-> () ) {
        // 세션 생성, 환경설정
        let defaultSession = URLSession(configuration: .default)
        
        let mUrl = "http://connect-boxoffice.run.goorm.io/comments?movie_id=\(id)"
//        print("comments url = " + mUrl )
        
        guard let url = URL(string: "\(mUrl)") else {
            print("Comments URL is nil")
            return
        }
        
        // Request
        let request = URLRequest(url: url)
        
        // dataTask
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            // getting Data Error
            guard error == nil else {
                print("Error occur: \(String(describing: error))")
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                let decoder = JSONDecoder();
                do {
                    let result = try decoder.decode(CommentsVO.self, from: data)

                    DispatchQueue.main.async {
                        completion(result, false)
                    }
                    
                }catch {
                    completion(CommentsVO(comments: [CommentsInfo]()), true)
                    print("Comments error = \(error)")
                }
              
            }
            
        }
        
        dataTask.resume()
    }
    
    
}


