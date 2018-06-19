//
//  APICaller.swift
//  European Stock Option Calculator
//
//  Created by Bojan Simic on 05.11.16.
//  Copyright © 2016 Bojan Simic. All rights reserved.
//

import Foundation

public class APICaller
{
    var api:IAPI
    init(apiInterface:IAPI)
    {
        api = apiInterface
    }
    
    func  callJSON(quote:String) -> String {
        return api.getJSON(quote)
    }
    
}