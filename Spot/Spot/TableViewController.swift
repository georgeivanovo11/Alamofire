//
//  ViewController.swift
//  Spot
//
//  Created by george on 26/01/2017.
//  Copyright © 2017 george. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController
{
    var searchUrl = "https://api.spotify.com/v1/search?q=Adele&type=track"
    typealias JSONStandard = [String: AnyObject]
    var names = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        callAlamo(url: searchUrl)
    }

    func callAlamo(url: String)
    {
        Alamofire.request(url).responseJSON(completionHandler:
        {
            response in
            self.parseData(JSONData: response.data!)
        })
        
    }
    
    func parseData(JSONData: Data)
    {
        do
        {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as!  JSONStandard
            //print(readableJSON)
            if let tracks = readableJSON["tracks"] as? JSONStandard
            {
                if let items = tracks["items"]
                {
                    for i in 0 ..< items.count
                    {
                        let item = items[i] as! JSONStandard
                        let name = item["name"] as! String
                        names.append(name)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        catch
        {
            print(error)
        }
    }
}

//MARK:- Table
extension TableViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = names[indexPath.row]
        return cell!
    }
}
