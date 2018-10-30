//
//  FlashFormTextItem.swift
//  FlashForm
//
//  Created by ios on 2018/10/16.
//  Copyright © 2018 ios. All rights reserved.
//

import Foundation

open class FlashFormTextItem: FlashFormItem {
    
    var title: String? {
        didSet {
             titleLabel.text = title
        }
    }
    
    var content: String? {
        didSet {
            contentLabel.text = content
        }
    }
    
    var titleLabel: UILabel!
    var contentLabel: UITextField!
    
    public convenience init(key: String, title: String?, content: String) {
        self.init(keys: [key])
        self.title = title
        self.content = content
        configSubviews()
        
        self.setValue = { item, dic in
            let item = item as! FlashFormTextItem
            item.content = dic[key] as? String
        }
        
        self.getValue = { item, dic in
            return [key: content]
        }
    }
    
    func configSubviews()  {
        titleLabel = UILabel()
        titleLabel?.text = title
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        contentLabel = UITextField()
        contentLabel?.text = content
        contentLabel?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.3),
            
            contentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            contentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.7)
        ])
    }
    
}

extension String: FlashFormValue {}
