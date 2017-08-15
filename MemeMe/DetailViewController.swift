//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Safeen Azad on 8/15/17.
//  Copyright © 2017 SafeenAzad. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var memDetail : Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        self.tabBarController?.tabBar.isHidden = true
        
        self.imageView!.image = memDetail.memedImage
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
