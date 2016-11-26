//
//  KTRequest.swift
//  Pods
//
//  Created by Kohei Totani on 2016/11/26.
//
//

import UIKit

public struct KTRequest {
    
    static public func GET(urlString: String, params: Dictionary<String, String>, success: ((NSURLResponse, AnyObject) -> Void), failure: ((NSError) -> Void)) {
        
        let url = NSURL(string: getUriWithQueryString(urlString, params: params))
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let request = NSMutableURLRequest(URL: url!)
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            if ((error == nil)) {
                success(response!, NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            } else {
                failure(error!)
            }
        })
        task.resume()
    }
    
    static public func POST(urlString: String, params: Dictionary<String, AnyObject>, success: ((NSURLResponse, AnyObject) -> Void), failure: ((NSError) -> Void)) {
        
        let url = NSURL(string: urlString)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let request = NSMutableURLRequest(URL: url!)
        
        let data:NSData! =  NSKeyedArchiver.archivedDataWithRootObject(params)
        request.HTTPMethod = "POST"
        request.HTTPBody = data
        
        let task = session.dataTaskWithRequest(request, completionHandler: {
            (data, response, error) in
            if ((error == nil)) {
                success(response!, NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            } else {
                failure(error!)
            }
        })
        task.resume()
    }
    
    static private func getUriWithQueryString(url: String, params: Dictionary<String, String>) -> String {
        var paramString = ""
        
        for (key, value) in params {
            let query = key + "=" + value
            paramString = (paramString == "") ? "?" + query : paramString + "&" + query
        }
        
        return url + paramString;
    }
}
