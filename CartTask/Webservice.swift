//
//  Webservice.swift
//  CartTask
//
//  Created by Sumeet  Jain on 30/10/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import Foundation

class Webservice{
    
    static let sharedInstance = Webservice()
    
    private init(){
    }
    
    func requestCategories(_ completionHandler: @escaping (Data?, Error?) -> ()){
        if let url = URL(string: "http://demo4308233.mockable.io/all") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
//                    if let jsonString = String(data: data, encoding: .utf8) {
//                        print(jsonString)
//                    }
                    completionHandler(data, nil)
                }else{
                    completionHandler(nil, error)
                }
            }.resume()
        }
    }
}
