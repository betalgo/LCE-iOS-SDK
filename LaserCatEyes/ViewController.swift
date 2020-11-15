//
//  ViewController.swift
//  LaserCatEyes
//
//  Created by Hakkı Yiğit Yener on 2.11.2020.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func sendRequestButtonTouched(_ sender: Any) {
        AF.request("https://example.com/foo/bar.json").response { (data: AFDataResponse<Data?>) in
            return
        }
//        LaserCatManager.shared.sendDeviceInfoToServer()
    }
    
    
    

}

