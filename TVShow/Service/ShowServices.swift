//
//  ShowServices.swift
//  TVShow
//
//  Created by Arunraj on 04/08/21.
//

import Foundation
import Alamofire



class ShowService {
    
    
    static let shared = ShowService()

    
    func getListData(input: Int, completionHandler: @escaping (Swift.Result<[ShowModel], Error>) -> ()) {
        
        
        let url = "https://api.tvmaze.com/shows?page=\(input)"
            
        AF.request(url).responseData{ response in
                        
            switch response.result{
            
            case .success(let data):
                do{
                    print(data)

                    let result = try JSONDecoder().decode([ShowModel].self, from: data)
                    print(result)
                    
                    completionHandler(.success(result))
                }
                catch let error{
                    
                    print("Parsing Error")
                    completionHandler(.failure(error))

                }
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        }
        
        
    }
    
    func getShowDetails(input: Int, completionHandler: @escaping (Swift.Result<ShowModel, Error>) -> ()) {
        
        
        let url = "https://api.tvmaze.com/shows/\(input)"
            
        AF.request(url).responseData{  response in
                        
            switch response.result{
            
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode(ShowModel.self, from: data)
                    print(result)
                    
                    completionHandler(.success(result))
                }
                catch let error{
                    
                    print("Parsing Error")
                    completionHandler(.failure(error))

                }
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        }
        
        
    }
    
    func getShowSeason(input: Int, completionHandler: @escaping (Swift.Result<[SeasonModel], Error>) -> ()) {
        
        
        let url = "https://api.tvmaze.com/shows/\(input)/seasons"
            
        AF.request(url).responseData{  response in
                        
            switch response.result{
            
            case .success(let data):
                do{
                    let result = try JSONDecoder().decode([SeasonModel].self, from: data)
                    print(result)
                    
                    completionHandler(.success(result))
                }
                catch let error{
                    
                    print("Parsing Error")
                    completionHandler(.failure(error))

                }
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        }
        
        
    }
    
    func searchListData(input: String, completionHandler: @escaping (Swift.Result<[ShowModel], Error>) -> ()) {
        
        
        let url = "https://api.tvmaze.com/search/shows?q=\(input)"
            
        AF.request(url).responseData{ response in
                        
            switch response.result{
            
            case .success(let data):
                do{
                    print(data)
                    let result = try JSONDecoder().decode([ShowModel].self, from: data)
                    print(result)
                    
                    completionHandler(.success(result))
                }
                catch let error{
                    
                    print("Parsing Error")
                    completionHandler(.failure(error))

                }
            case .failure(let error):
                completionHandler(.failure(error))
                print(error)
            }
        }
        
        
    }
    
    
}


