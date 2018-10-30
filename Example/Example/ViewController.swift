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
        let item = FlashFormTextItem(key: "key", title: "批次号", content: "PC18090001")
        item.transform(["key" >> "key1"])
        
        let flashGroup0 = FlashFormItemGroup([
            item,
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元")
        ])
        flashGroup0.title = "aaa"
        flashGroup0.footer = "bbb"
        
        let flashGroup1 = FlashFormItemGroup([
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元")
            ])
        flashGroup1.title = "afsdfasdfasdf"
        
        let flashGroup2 = FlashFormItemGroup([
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元")
            ])
        flashGroup2.title = "fsdfsf"
        
        let flashGroup3 = FlashFormItemGroup([
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元"),
            FlashFormTextItem(key: "key2", title: "装车总运费", content: "2089元")
            ])
        flashGroup3.title = "fasdfsa"
        
        let form = FlashForm(content: [
            flashGroup0,
            flashGroup1,
            flashGroup2,
            flashGroup3
            ])
        form.separatorColor = .cyan
        form.backgroundColor = .lightGray
        print(try! form.valueDic())
        view.addSubview(form)
        NSLayoutConstraint.activate([
            form.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            form.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            form.leftAnchor.constraint(equalTo: view.leftAnchor),
            form.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

}



