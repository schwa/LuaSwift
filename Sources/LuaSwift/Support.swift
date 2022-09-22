//
//  File.swift
//  File
//
//  Created by Jonathan Wight on 9/6/21.
//

import Foundation

public class WeakBox<Element> where Element: AnyObject {
    weak var element: Element?
    init(_ element: Element? = nil) {
        self.element = element
    }
}
