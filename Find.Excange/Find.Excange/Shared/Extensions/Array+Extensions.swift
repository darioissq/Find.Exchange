//
//  Array+Extensions.swift
//  Find.Excange
//
//  Created by Dario Langella on 18/10/2018.
//  Copyright © 2018 Dario Langella. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    func indexes(of element: Element) -> [Int] {
        return self.enumerated().filter({ element == $0.element }).map({ $0.offset })
    }
}
