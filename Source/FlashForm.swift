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
    
    fileprivate var _rowHeight: CGFloat = 44
    fileprivate var _headerHeight: CGFloat = 15
    fileprivate var _separatorColor: UIColor?
    
    // Values
    fileprivate var itemMap: [String: FlashFormItem] = [:]
    var content: [Element]!
    
    //MARK: - Initializations
    
    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setter
    subscript(key: String) -> FlashFormItem? {
        get {
            return itemMap[key]
        }
        set {
            itemMap[key] = newValue
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
    
    var rowHeight: CGFloat {
        get {
            return _rowHeight
        }
        set {
            _rowHeight = newValue
            layoutContents()
        }
    }
    
    var separatorColor: UIColor? {
        get {
            return _separatorColor
        }
        set {
            _separatorColor = newValue
            content.forEach { (item) in
                item.separatorColor = newValue
            }
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
            itemMap[$0.key] = $0
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        layoutContents()
    }
    
    func layoutContents() {
        NSLayoutConstraint.deactivate(contentView.constraints)
        var temp: UIView?
        content.forEach { (item) in
            
            if item != content.first {
                item.isToplineShow = false
                NSLayoutConstraint.activate([
                    item.topAnchor.constraint(equalTo: temp!.bottomAnchor)
                    ])
            } else {
                item.isToplineShow = true
                NSLayoutConstraint.activate([
                    item.topAnchor.constraint(equalTo: contentView.topAnchor)
                    ])
            }
            
            if item == content.last {
                item.separatorLeading = 0
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
    
    public func valueDic() -> [String: FlashFormValue] {
        var dic: [String: FlashFormValue] = [:]
        itemMap.values.forEach { (item) in
           item.valueDic.forEach{dic.updateValue($1, forKey: $0)}
        }
        return dic
    }
}

public extension FlashForm where Element == FlashFormItemGroup {
    
    var rowHeight: CGFloat {
        get {
            return _rowHeight
        }
        set {
            _rowHeight = newValue
            layoutContents()
        }
    }
    
    var separatorColor: UIColor? {
        get {
            return _separatorColor
        }
        set {
            _separatorColor = newValue
            content.forEach { (item) in
                item.items.forEach({ (item) in
                    item.separatorColor = newValue
                })
            }
        }
    }
    
    var headerHeight: CGFloat {
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
                itemMap[$0.key] = $0
                $0.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview($0)
            }
        }
        layoutContents()
    }
    
    func layoutContents() {
        NSLayoutConstraint.deactivate(contentView.constraints)
        var temp: UIView?
        content.forEach{ group in
            group.items.forEach{ item in
                
                let heightConstraint = item.heightAnchor.constraint(equalToConstant: _rowHeight)
                heightConstraint.priority = .defaultLow
                
                NSLayoutConstraint.activate([
                    item.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    item.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    heightConstraint
                ])
                
                if item != group.items.first {
                    item.isToplineShow = false
                    NSLayoutConstraint.activate([
                        item.topAnchor.constraint(equalTo: temp!.bottomAnchor)
                        ])
                } else {
                    item.isToplineShow = true
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
                    item.separatorLeading = 0
                    
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
    
    public func valueDic() -> [String: FlashFormValue] {
        var dic: [String: FlashFormValue] = [:]
        content.forEach{$0.dic().forEach{dic.updateValue($1, forKey: $0)}}
        return dic
    }
}
