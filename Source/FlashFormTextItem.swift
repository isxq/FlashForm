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
    
    var value: String?
    
    var titleLabel: UILabel!
    var contentLabel: UITextField!
    
    open override var valueDic: [String : FlashFormValue]{
        return [key: value ?? ""]
    }
    
    public override func setValue(with dic: [String : FlashFormValue]) {
        value = dic[key] as? String
        contentLabel.text = value
    }
    
    public convenience init(key: String, title: String?, content: String) {
        self.init(key: key)
        self.title = title
        self.value = content
        configSubviews()
    }
    
    func configSubviews()  {
        titleLabel = UILabel()
        titleLabel?.text = title
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        contentLabel = UITextField()
        contentLabel?.text = value
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
