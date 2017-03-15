//
//  Friend.swift
//  vapor-testEnv
//
//  Created by Felix E. C. Klemke on 13/03/2017.
//
//

import Foundation
import Vapor

struct Friend: Model {
    
    var exists: Bool = false
    var id: Node?
    let name: String
    let nationalityByHeart: String
    let email: String
    
    init(name: String, nationalityByHeart: String, email: String) {
        self.name = name
        self.nationalityByHeart = nationalityByHeart
        self.email = email
    }
    
    //NodeInitializable
    init(node: Node, in context: Context) throws {
        dump(node)
        id = try node.extract("id")
        
//        if let val: Int = try? node.extract("id"){
//            print(val)
//        }else{
//            print("ging nicht")
//        }
//        do{
//            id = try node.extract("id")
//            print("indicator")
//        } catch {
//            print("indicatorXXX")
//            id = 0
//        }
//        name = "gregor"
//        nationalityByHeart = "korean"
//        email = "shakes@fitches.com"
        
        
        name = try node.extract("name")
        nationalityByHeart = try node.extract("nationalitybyheart")
        email = try node.extract("email")
    }
    
    //NodeRepresentable
    func makeNode(context: Context) throws -> Node {
        return try Node(node: ["id":id,
                               "name":name,
                               "nationalityByHeart": nationalityByHeart,
                               "email": email
            ])
    }
    
    //preparation
    static func prepare(_ database: Database) throws {
        try database.create("friends"){ friends in
            friends.id()
            friends.string("name")
            friends.string("nationalityByHeart")
            friends.string("email")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("friends")
    }
}
