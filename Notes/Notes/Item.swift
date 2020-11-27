//
//  Item.swift
//  Notes
//
//  Created by Офелия Баширова on 26.11.2020.
//

import Foundation
import RealmSwift

class Item: Object {
   @objc dynamic var id: Int = 0
   @objc dynamic var name: String = ""
}
