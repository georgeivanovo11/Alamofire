//
//  AudioViewController.swift
//  Spot
//
//  Created by george on 27/01/2017.
//  Copyright © 2017 george. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController
{
    var post: Post! = nil
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad()
    {
        background.image = post.image
        imageView.image = post.image
        label.text = post.name
        button.setTitle("Pause", for: .normal)
        
        downloadFileFromUrl(url: URL(string: post.previewUrl)!)
    }
    
    func downloadFileFromUrl(url: URL)
    {
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler:
        {
            customURL, response, error in
            self.playSong(url: customURL!)
        })
        downloadTask.resume()
    }
    
    func playSong(url: URL)
    {
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
        }
        catch{
            print(error)
        }
    }
    
    @IBAction func playOrPause(_ sender: AnyObject)
    {
        if player.isPlaying
        {
            player.pause()
            button.setTitle("Play", for: .normal)
        }
        else
        {
            player.play()
            button.setTitle("Pause", for: .normal)
        }
    }
}
