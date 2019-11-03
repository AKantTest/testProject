//
//  Persistence.swift
//  Application
//
//  Created by kant on 23/08/2019.
//

import Foundation
import SwiftKueryORM
import SwiftKueryPostgreSQL

class Persistence {
    static func setup() {
        let pool = PostgreSQLConnection.createPool(
            host: "localhost",
            port: 5432,
            options: [
                .databaseName("quizdb")
            ],
            poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50)
        )
        
        Database.default = Database(pool)
    }
}
