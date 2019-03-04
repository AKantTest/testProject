//
//  Notebook+Extensions.swift
//  Mooskine
//
//  Created by kant on 01.03.2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import CoreData

extension Notebook {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
