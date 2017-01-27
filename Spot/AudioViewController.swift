//
//  AudioViewController.swift
//  Spot
//
//  Created by george on 27/01/2017.
//  Copyright © 2017 george. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController
{
    var image = UIImage()
    var songTitle = String()
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad()
    {
        background.image = image
        imageView.image = image
        label.text = songTitle
    }
}
