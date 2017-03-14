import Vapor
//import VaporPostgreSQL


let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}
//
//drop.get("friends") { req in
//    return try JSON(node: ["friends": [
//        ["name":"Sven", "nationality by heart": "where the kivis grow"],
//        ["name":"gregor", "nationality by heart": "shakes & fitches"],
//        ["name":"dustin", "nationality by heart": "RUST"],
//        ["name":"jakob", "nationality by heart": "RICH JEW"],
//        ["name":"max", "nationality by heart": "Belgian Banana Republic"],
//        ["name":"dominik", "nationality by heart": "Zigeuner"],
//        ]
//        ])
//}


drop.get("friends") { req in
    let friends = [Friend(name: "Sven", nationalityByHeart: "Where the Kivis grow", email: "6kiviaday@kiviislife.com"),
        Friend(name: "Dustin", nationalityByHeart: "RUST", email: "rust@rustmyrust.com"),
        Friend(name: "Jakob", nationalityByHeart: "Rich Jew", email: "momoney@moproblems.com"),
        Friend(name: "Gregor", nationalityByHeart: "H-Town", email: "bossplayer@1305plattenbauHunter.com")
    ]

    let friendsNode = try friends.makeNode()
    let nodeDictionary = ["friends": friendsNode]
    return try JSON(node: nodeDictionary)
}


drop.resource("posts", PostController())

drop.run()
