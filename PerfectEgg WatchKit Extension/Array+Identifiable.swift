//
//  Array+Identifiable.swift
//  PerfectEgg
//
//  Created by Augusto Spinelli on 01/08/20.
//  Copyright © 2020 Augusto Spinelli. All rights reserved.
//

import Foundation

extension Array where Element : Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}

