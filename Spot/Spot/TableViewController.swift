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
    var posts = [Post]()
    
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
                if let items = tracks["items"] as? [JSONStandard]
                {
                    for i in 0 ..< items.count
                    {
                        let item = items[i]
                        //print(item)
                        let name = item["name"] as! String
                        
                        if let album = item["album"] as? JSONStandard
                        {
                            if let images = album["images"] as? [JSONStandard]
                            {
                                let imageInfo = images[0]
                                let imageUrl = URL(string: imageInfo["url"] as! String)
                                let imageData = NSData(contentsOf: imageUrl!) as! Data
                                let image = UIImage(data: imageData)
                                
                                posts.append(Post.init(image: image, name: name))
                                self.tableView.reloadData()
                            }
                        }
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
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let imageView = cell?.viewWithTag(2) as! UIImageView
        let labelView = cell?.viewWithTag(1) as! UILabel
        
        imageView.image = posts[indexPath.row].image
        labelView.text = posts[indexPath.row].name
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! AudioViewController
        vc.image = posts[indexPath!].image
        vc.songTitle = posts[indexPath!].name
        
    }
}
