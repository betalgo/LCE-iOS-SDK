//
//  ViewController.swift
//  LaserCatEyes
//
//  Created by HakkiYigitYener on 11/24/2020.
//  Copyright (c) 2020 HakkiYigitYener. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendRequestButtonTouched(_ sender: Any) {
        AF.request("https://example.com/foo/bar.json").response { (data: AFDataResponse<Data?>) in
            return
        }
    }

}

