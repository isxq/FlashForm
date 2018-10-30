//
//  FlashForm.swift
//  FlashForm
//
//  Created by ios on 2018/10/15.
//  Copyright © 2018 ios. All rights reserved.
//

import Foundation
import UIKit

public class FlashForm<Element>: UIControl  {
    
    //MARK: - Properties
    
    //UIComponents
    
    fileprivate var scrollView: UIScrollView!
    var contentView: UIView!
    
    public var _rowHeight: CGFloat = 44
    public var _headerHeight: CGFloat = 20
    
    // Values
    fileprivate var itemMap: [Set<String>: FlashFormItem] = [:]
    var separatorMap: [Set<String>: UIView] = [:]
    var content: [Element]!
    
    var separatorColor: UIColor? {
        didSet {
            separatorMap.values.forEach{$0.backgroundColor = separatorColor}
        }
    }
    
    //MARK: - Initializations
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setter
    subscript(keys: Set<String>) -> FlashFormItem? {
        get {
            return itemMap[keys]
        }
        set {
            itemMap[keys] = newValue
        }
    }
    
    //MARK: - Setup subviews
    
    func setupSubviews() {
        createBackground()
    }
    
    /// create warrap view
    func createBackground() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        addSubview(scrollView)
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        let defaultHeightConstraint = contentView.heightAnchor.constraint(equalTo: heightAnchor)
        defaultHeightConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            defaultHeightConstraint
            ])
    }
    
}

public extension FlashForm where Element == FlashFormItem {
    
    public var headerHeight: CGFloat {
        get {
            return _headerHeight
        }
        set {
            _headerHeight = newValue
            layoutContents()
        }
    }
    
    public var rowHeight: CGFloat {
        get {
            return _rowHeight
        }
        set {
            _rowHeight = newValue
            layoutContents()
        }
    }
    
    public convenience init(content: [Element], frame: CGRect = .zero) {
        self.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.content = content
        setupSubviews()
        createContent()
    }
    
    func createContent() {
        content.forEach{
            itemMap[$0.keys] = $0
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
            let separator = UIView()
            separatorMap[$0.keys] = separator
            separator.backgroundColor = .lightGray
            $0.addSubview(separator)
        }
        layoutContents()
    }
    
    func layoutContents() {
        NSLayoutConstraint.deactivate(contentView.constraints)
        var temp: UIView?
        content.forEach { (item) in
            
            let separator = separatorMap[item.keys]!
            NSLayoutConstraint.activate([
                separator.leftAnchor.constraint(equalTo: item.leftAnchor),
                separator.rightAnchor.constraint(equalTo: item.rightAnchor),
                separator.bottomAnchor.constraint(equalTo: item.bottomAnchor),
                separator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
                ])
            
            if item != content.first {
                NSLayoutConstraint.activate([
                    item.topAnchor.constraint(equalTo: temp!.bottomAnchor)
                    ])
            } else {
                NSLayoutConstraint.activate([
                    item.topAnchor.constraint(equalTo: contentView.topAnchor)
                    ])
            }
            
            if item == content.last {
                NSLayoutConstraint.activate([
                    item.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                    ])
            }
            
            let heightConstraint = item.heightAnchor.constraint(equalToConstant: _rowHeight)
            heightConstraint.priority = .defaultLow
            
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                item.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                heightConstraint
                ])
            
            temp = item
        }
    }
    
    public func valueDic() throws -> [String: FlashFormValue] {
        var dic: [String: FlashFormValue] = [:]
        
        try itemMap.values.forEach { (item) in
            try item.itemValue().forEach{dic.updateValue($1, forKey: $0)}
        }
        return dic
    }
    
    public func setValue(_ dic: [String: FlashFormValue]) {
        itemMap.forEach { (keys, item) in
            var values: [String: FlashFormValue] = [:]
            keys.forEach({ key in
                if let value = dic[key] {
                    values.updateValue(value, forKey: key)
                }
            })
            item.setValue(with: values)
        }
    }
}

public extension FlashForm where Element == FlashFormItemGroup {
    
    public var rowHeight: CGFloat {
        get {
            return _rowHeight
        }
        set {
            _rowHeight = newValue
            layoutContents()
        }
    }
    
    public var headerHeight: CGFloat {
        get {
            return _headerHeight
        }
        set {
            _headerHeight = newValue
            layoutContents()
        }
    }
    
    public convenience init(content: [FlashFormItemGroup], frame: CGRect = .zero) {
        self.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.content = content
        setupSubviews()
        createContent()
    }
    
    func createContent() {
        content.forEach{
            $0.items.forEach{
                itemMap[$0.keys] = $0
                $0.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview($0)
                let separator = UIView()
                separator.translatesAutoresizingMaskIntoConstraints = false
                separator.backgroundColor = .lightGray
                separatorMap[$0.keys] = separator
                $0.addSubview(separator)
            }
        }
        layoutContents()
    }
    
    func layoutContents() {
        NSLayoutConstraint.deactivate(contentView.constraints)
        var temp: UIView?
        content.forEach{ group in
            group.items.forEach{ item in
                
                let separator = separatorMap[item.keys]!
                NSLayoutConstraint.activate([
                    separator.leftAnchor.constraint(equalTo: item.leftAnchor),
                    separator.rightAnchor.constraint(equalTo: item.rightAnchor),
                    separator.bottomAnchor.constraint(equalTo: item.bottomAnchor),
                    separator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
                    ])
                
                let heightConstraint = item.heightAnchor.constraint(equalToConstant: _rowHeight)
                heightConstraint.priority = .defaultLow
                
                NSLayoutConstraint.activate([
                    item.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    item.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    heightConstraint
                ])
                
                if item != group.items.first {
                    NSLayoutConstraint.activate([
                        item.topAnchor.constraint(equalTo: temp!.bottomAnchor)
                        ])
                } else {
                    if let header = group.headerView {
                        contentView.addSubview(header)
                        NSLayoutConstraint.activate([
                            header.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                            header.rightAnchor.constraint(equalTo: contentView.rightAnchor)
                        ])
                        if group != content.first {
                            NSLayoutConstraint.activate([
                                header.topAnchor.constraint(equalTo: temp!.bottomAnchor),
                                item.topAnchor.constraint(equalTo: header.bottomAnchor)
                                ])
                        } else {
                            NSLayoutConstraint.activate([
                                header.topAnchor.constraint(equalTo: contentView.topAnchor),
                                item.topAnchor.constraint(equalTo: header.bottomAnchor)
                                ])
                        }
                    } else {
                        if group != content.first {
                            NSLayoutConstraint.activate([
                                item.topAnchor.constraint(equalTo: temp!.bottomAnchor, constant: group.headerHeight ?? _headerHeight)
                                ])
                        } else {
                            NSLayoutConstraint.activate([
                                item.topAnchor.constraint(equalTo: contentView.topAnchor, constant: group.headerHeight ?? _headerHeight)
                                ])
                        }
                    }
                }
                
                if item == group.items.last {
                    if let footer = group.footerView {
                        contentView.addSubview(footer)
                        NSLayoutConstraint.activate([
                            footer.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                            footer.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                            footer.topAnchor.constraint(equalTo: item.bottomAnchor)
                        ])
                        if group == content.last {
                            NSLayoutConstraint.activate([
                                footer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                                ])
                        }
                        temp = footer
                    } else {
                        if group == content.last {
                            NSLayoutConstraint.activate([
                                item.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                                ])
                        }
                        temp = item
                    }
                    
                } else {
                    temp = item
                }
            }
        }
    }
    
    public func valueDic() throws -> [String: FlashFormValue] {
        var dic: [String: FlashFormValue] = [:]
        try content.forEach{ try $0.dic().forEach{dic.updateValue($1, forKey: $0) }}
        return dic
    }
    
    public func setValue(_ dic: [String: FlashFormValue]) {
        itemMap.forEach { (keys, item) in
            var values: [String: FlashFormValue] = [:]
            keys.forEach({ key in
                if let value = dic[key] {
                    values.updateValue(value, forKey: key)
                }
            })
            item.setValue(with: values)
        }
    }
}
