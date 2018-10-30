//
//  FlashFormItem.swift
//  FlashForm
//
//  Created by ios on 2018/10/15.
//  Copyright © 2018 ios. All rights reserved.
//

import Foundation


public protocol FlashFormValue{}

open class FlashFormItem: UIControl {
    
    static let removeKey: String = "$$FLASHFORMREMOVE##"
    
    public var keys: Set<String>!
    
    public var value: [String: FlashFormValue] = [:]
    
    open var getValue: ((FlashFormItem, [String: FlashFormValue]) throws -> [String: FlashFormValue])?
    
    open var setValue: ((FlashFormItem, [String: FlashFormValue]) -> Void)?
    
    var transformedKeys: [String: String?]?
    //MARK: - Initializations
    
    public convenience init(keys: Set<String>) {
        self.init(frame: .zero)
        self.keys = keys
        backgroundColor = .white
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func transform(_ trans: [(String, String?)]){
        if transformedKeys == nil {
            transformedKeys = [:]
        }
        trans.forEach { transformedKeys!.updateValue($0.1, forKey: $0.0) }
    }
    
    open func setValue(with dic: [String: FlashFormValue]) {
        value = dic
        setValue?(self, dic)
    }
    
    open func itemValue() throws -> [String: FlashFormValue] {
        var dic = try getValue?(self, value) ?? [:]
        transformedKeys?.forEach { (key, newKey) in
            if let newKey = newKey, let value = dic[key] {
                dic.updateValue(value, forKey: newKey)
            }
            dic.removeValue(forKey: key)
        }
        return dic
    }
}

extension String {
    public static func >> (lhs: String, rhs: String?) -> (String, String?) {
        return (lhs, rhs)
    }
}
