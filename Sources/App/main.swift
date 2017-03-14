import Vapor
import VaporPostgreSQL


let drop = Droplet()

// We add Friend.self to our Droplet’s preparations so that we can use our model with the database
drop.preparations.append(Friend.self)

//drop.addProvider(VaporPostgreSQL.Provider.self) adds our provider to the droplet so that the database is available
do {
    try drop.addProvider(VaporPostgreSQL.Provider.self)
} catch {
    assertionFailure("Error adding provider \(error)")
}


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
//    let friends = [Friend(name: "Sven", nationalityByHeart: "Where the Kivis grow", email: "6kiviaday@kiviislife.com"),
//        Friend(name: "Dustin", nationalityByHeart: "RUST", email: "rust@rustmyrust.com"),
//        Friend(name: "Jakob", nationalityByHeart: "Rich Jew", email: "momoney@moproblems.com"),
//        Friend(name: "Gregor", nationalityByHeart: "H-Town", email: "bossplayer@1305plattenbauHunter.com")
//    ]
    
    let friends = try Friend.all().makeNode()
    let friendsDictionary = ["friends": friends]
    return try JSON(node: friendsDictionary)
}

drop.post("friend") { req in
    var friend = try Friend(node: req.json)
    //to save the instance to the database
    try friend.save()
    return try friend.makeJSON()
}

drop.resource("posts", PostController())

drop.run()
