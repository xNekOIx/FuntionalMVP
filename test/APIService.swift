//
//  APIService.swift
//  test
//
//  Created by Алексей Демедецкий on 23.01.16.
//  Copyright © 2016 Silicon Valley Insight. All rights reserved.
//

import Foundation

enum APIService {
    static func requestDefinitions(ofWord word: String, callback: String? -> ()) {
        let url = NSURL(string: ""
            + "http://api.wordnik.com:80/v4/"
            + "word.json/\(word)/definitions"
            + "?limit=1"
            + "&includeRelated=false"
            + "&useCanonical=false"
            + "&includeTags=false"
            + "&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5"
        )!
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { data, response, error in
            if  error == nil,
                let data = data,
                let resultOpt = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
                let result = resultOpt as? [AnyObject],
                let element = result.first as? [String : AnyObject],
                let text = element["text"] as? String
            {
                callback(text)
            } else {
                callback(nil)
            }
        }
        
        task.resume()
    }
}