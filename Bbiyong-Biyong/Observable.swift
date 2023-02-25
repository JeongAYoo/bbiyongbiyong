//
//  Observable.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/24.
//

import Foundation

class Observable<T> {
    private var listener: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
