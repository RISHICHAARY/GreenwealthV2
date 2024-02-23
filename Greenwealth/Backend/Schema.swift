import Foundation

struct getUsers: Decodable, Identifiable, Hashable{
    
    var id: Int?
    var fullName: String
    var emailAddress: String
    var mobileNumber: String
    var accountStatus: String
    var deviceToken: String
    var profileImage: String
    var password: String
    var ecoPoints: Int?
    var carbonFootprints:Float?
    var totalAmount: Float?
    var treesSaved: Float?
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, fullName, emailAddress, mobileNumber, accountStatus, deviceToken, profileImage, password, ecoPoints, carbonFootprints, totalAmount, treesSaved, createdAt
    }
    
}

struct addUsers: Encodable, Identifiable, Hashable{
    
    var id: Int?
    var fullName: String
    var emailAddress: String
    var mobileNumber: String
    var accountStatus: String
    var deviceToken: String
    var profileImage: String
    var password: String
    var ecoPoints: Int?
    var carbonFootprints:Float?
    var totalAmount: Float?
    var treesSaved: Float?
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, fullName, emailAddress, mobileNumber, accountStatus, deviceToken, profileImage, password, ecoPoints, carbonFootprints, totalAmount, treesSaved, createdAt
    }
    
}

struct getPickUp: Decodable, Identifiable, Hashable{
    
    var id: Int?
    var userId: Int
    var imageURL: String
    var categories: String
    var address: String
    var lattitude: String
    var longitude: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var estimatePrice: Float
    var providerId: Int
    var collectorId: Int
    var status: String
    var rating: Int
    var ecoPoints: Int
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, userId, imageURL, categories, address, lattitude, longitude, date, startTime, endTime, estimatePrice, providerId, collectorId, status, rating, ecoPoints, createdAt
    }
    
}

struct addPickUp: Encodable, Identifiable, Hashable{
    
    var id: Int?
    var userId: Int
    var imageURL: String
    var categories: String
    var address: String
    var lattitude: String
    var longitude: String
    var date: Date
    var startTime: Date
    var endTime: Date
    var estimatePrice: Float
    var providerId: Int
    var collectorId: Int
    var status: String
    var rating: Int
    var ecoPoints: Int
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, userId, imageURL, categories, address, lattitude, longitude, date, startTime, endTime, estimatePrice, providerId, collectorId, status, rating, ecoPoints, createdAt
    }
    
}

struct addRequest: Encodable, Identifiable, Hashable{
    
    var id: Int?
    var userID: Int
    var userEmail: String
    var category: String
    var detail: String
    var status: String
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, userID, userEmail, category, detail, status, createdAt
    }
    
}


struct getRequest: Decodable, Identifiable, Hashable{
    
    var id: Int?
    var userID: Int
    var userEmail: String
    var category: String
    var detail: String
    var status: String
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, userID, userEmail, category, detail, status, createdAt
    }
    
}
