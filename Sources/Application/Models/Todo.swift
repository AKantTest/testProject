import SwiftKueryORM

public struct Todo: Codable {
    public var id: Int?
    public var user: String?
    public var title: String?
    public var order: Int?
    public var completed: Bool?
    public var url: String?
}

extension Todo: Equatable {
    public static func ==(lhs: Todo, rhs: Todo) -> Bool {
        return lhs.title == rhs.title &&
            lhs.user == rhs.user &&
            lhs.order == rhs.order &&
            lhs.completed == rhs.completed &&
            lhs.url == rhs.url &&
            lhs.id == rhs.id
    }    
}

extension Todo: Model {}
