//
//  ViewController.swift
//  TaskToDoApp
//
//  Created by 福島悠樹 on 2020/06/14.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //btnDesign.backgroundColor = .systemPink
        
    }
    
    
    @IBAction func tappedEnterBtn(_ sender: Any) {
        let vc = TaskSelectViewController()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

