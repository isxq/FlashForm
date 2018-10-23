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
    var value: FlashFormValue? { get set }
    var valueDic: [String: FlashFormValue] { get }
}

public protocol FlashFormItemProtocol: FlashShadowProtocol {
    associatedtype ValueType: FlashFormValue
}

open class FlashFormItem: UIControl {
    
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
    public var isToplineShow: Bool = false {
        didSet {
            if let topLine = topline {
                topLine.isHidden = isToplineShow
            } else if isToplineShow == true {
                topline = createTopLine()
            }
        }
    }
    
    public var key: String!
    var _value: Any?
    
    //MARK: - Initializations
    
    public convenience init(key: String) {
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
        separator.backgroundColor = .gray
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
}
