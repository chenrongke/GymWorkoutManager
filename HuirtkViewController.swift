//
//  HuirtkViewController.swift
//  LazyGuitar
//
//  Created by 陈荣科 on 2019/5/29.
//  Copyright © 2019 Daniel Song. All rights reserved.
//

import UIKit

class HuirtkViewController: UIViewController {

    var goalVw:UIWebView?
    var usrty:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let size = UIScreen.main.bounds.size
        
        goalVw = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        view.addSubview(goalVw!)
        goalVw?.sizeToFit()
        goalVw?.scrollView.bounces = false
        
        goalVw?.loadRequest(URLRequest.init(url: URL.init(string: usrty!)!))
    }

}
