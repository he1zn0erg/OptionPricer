//
//  MarkitAPI.swift
//  European Stock Option Calculator
//
//  Created by Bojan Simic on 05.11.16.
//  Copyright © 2016 Bojan Simic. All rights reserved.
//

import Foundation

class MarkitAPI:IAPI
{
    func getJSON(quote: String) -> String {
        var stockPrice = ""
        let markitOnDemandURL = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol=" + quote
        let url = NSURL(string: markitOnDemandURL)
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        //let task = session.dataTaskWithRequest(request) {(data, response, error) in
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error == nil
            {
                let swiftyJSON = JSON(data: data!)
                stockPrice = swiftyJSON["LastPrice"].stringValue
            }
                
            else
            {
                print("error")
            }
        })
        task.resume()
        return stockPrice
    }
}