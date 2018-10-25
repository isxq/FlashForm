//
//  ViewController.swift
//  Example
//
//  Created by ios on 2018/10/15.
//  Copyright © 2018 ios. All rights reserved.
//

import UIKit
import FlashForm

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let flashGroup0 = FlashFormItemGroup([
            FlashFormTextItem(key: "key", title: "批次号", content: "PC18090001"),
            FlashFormTextItem(key: "key", title: "装车总运费", content: "2089元"),
            FlashFormItem(key: "2")
            ])
        
        let flashGroup1 = FlashFormItemGroup([
            FlashFormItem(key: "3"),
            FlashFormItem(key: "2")])
        
        
        let form = FlashForm(content: [
            flashGroup0,
            flashGroup1
            ])
        
        form.backgroundColor = UIColor.lightGray
        
        view.addSubview(form)
        NSLayoutConstraint.activate([
            form.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            form.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            form.leftAnchor.constraint(equalTo: view.leftAnchor),
            form.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }

}



