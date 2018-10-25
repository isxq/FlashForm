//
//  FlashFormItem.swift
//  FlashForm
//
//  Created by ios on 2018/10/15.
//  Copyright © 2018 ios. All rights reserved.
//

import Foundation


public protocol FlashFormValue{}

public protocol  FlashShadowProtocol {
    func getValue() throws -> [String: FlashFormValue]
    func setValue(with value: FlashFormValue)
}

open class FlashFormItem: UIControl, FlashShadowProtocol {
    
    private var separator: UIView!
    
    private var topline: UIView?
    
    private var separatorConstraint: NSLayoutConstraint!
    
    public var separatorLeading: CGFloat? {
        didSet {
            if let leading = separatorLeading {
                separatorConstraint.constant = leading
            }
        }
    }
    
    public var separatorColor: UIColor? {
        didSet {
            separator.backgroundColor = separatorColor
        }
    }
    
    public var isToplineShow: Bool? = false {
        didSet {
            if let isToplineShow = isToplineShow {
                if let topLine = topline {
                    topLine.isHidden = isToplineShow
                } else if isToplineShow == true {
                    topline = createTopLine()
                }
            }
        }
    }
    
    public var key: String!
    
    open var _value: FlashFormValue?
    //MARK: - Initializations
    
    public convenience init(key: String = "") {
        self.init(frame: .zero)
        self.key = key
        backgroundColor = .white
        setupSubviews()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupSubviews
    
    final func setupSubviews() {
        separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .lightGray
        addSubview(separator)
        separatorConstraint = separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        NSLayoutConstraint.activate([
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorConstraint,
            separator.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
        
    }
    
    func createTopLine() -> UIView {
        let topline = UIView()
        topline.translatesAutoresizingMaskIntoConstraints = false
        topline.backgroundColor = .gray
        addSubview(topline)
        NSLayoutConstraint.activate([
            topline.topAnchor.constraint(equalTo: topAnchor),
            topline.trailingAnchor.constraint(equalTo: trailingAnchor),
            topline.leadingAnchor.constraint(equalTo: leadingAnchor),
            topline.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale)
        ])
        return topline
    }
    
    open func setValue(with value: FlashFormValue) {
        
    }
    
    open func getValue() throws -> [String : FlashFormValue] {
        if let value = _value {
            return [key: value]
        } else {
            return [:]
        }
    }
}

