//
//  ViewController.swift
//  CircleProgressViewSample
//
//  Created by viewdidload soft on 2020/04/27.
//  Copyright © 2020 ViewDidLoad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var circleProgressView: CircleProgressView!
    var percent: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // circleProgressView 설정 및 적용 방법
        percent += 5
        if percent > 100 { percent = 0 }
        print("touchesBegan \(percent)")
        circleProgressView.progressUpdate(percent: percent)
    }

}

