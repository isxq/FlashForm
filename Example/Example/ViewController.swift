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
    
    var form: FlashForm<FlashFormItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        form = FlashForm(content: [])
        form.separatorColor = .cyan
        form.backgroundColor = .lightGray
        
        view.addSubview(form)
        
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .orange
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(addAction(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            form.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            form.leftAnchor.constraint(equalTo: view.leftAnchor),
            form.rightAnchor.constraint(equalTo: view.rightAnchor),
            button.leftAnchor.constraint(equalTo: view.leftAnchor),
            button.rightAnchor.constraint(equalTo: view.rightAnchor),
            button.topAnchor.constraint(equalTo: form.bottomAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func addAction(_ sender: UIButton) {
        let item = FlashFormTextItem(key: "\(form.content.count)", title: "item\(form.content.count)", content: "hehe")
        form.content.append(item)
    }
}



