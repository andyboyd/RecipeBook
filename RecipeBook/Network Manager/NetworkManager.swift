//
//  RecipePuppyAPI.swift
//  RecipeBook
//
//  Created by Andrew Boyd on 29/08/2017.
//  Copyright © 2017 Andy Boyd. All rights reserved.
//

import Foundation

// This class is responsible for actually making network requests.
// Just using vanilla URLSession for speed of implementation,
// but would probably use Alamofire if it was to expland beyond a single API call.
class NetworkManager {
    
    // Download Recipe Data from the Recipe Puppy API for a specified string query.
    // Returns JSON data in a Dictionary format, or an error if something goes wrong.
    class func getRecipes(for query: String,
                          success: @escaping (_ json: [String: Any]) -> Void,
                          failure: @escaping (_ error: Error?) -> Void) {
        // Need to percent encode the query, otherwise spaces will break the API
        guard let percentEncodedQuery = NSString(string: query).addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            failure(nil)
            return
        }
        
        NetworkManager.getData(at: "http://www.recipepuppy.com/api/?q=\(percentEncodedQuery)", success: { (data) in
            do {
                if let decodedJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    // We have data of the expected type, success!
                    success(decodedJSON)
                } else {
                    // The data couldn't be decoded to a JSON object of the expected type, we've failed!
                    failure(nil)
                }
            } catch {
                // The data wasn't actually JSON, call the failure block
                failure(error)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    // Utility function to asynchronously download Data from an arbitrary string path.
    // If the path is not a valid URL, if no data is returned, or if an error is returned, the failure block will be called.
    class func getData(at path: String,
                       success: @escaping (_ data: Data) -> Void,
                       failure: @escaping (_ error: Error?) -> Void) {
        guard let url = URL(string: path) else {
            failure(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data, error == nil {
                success(data)
            } else {
                failure(error)
            }
        }).resume()
    }
}
