import Foundation

class pickUp: ObservableObject{
    
    @Published var image: String
    @Published var items: String
    @Published var address: String
    @Published var date: Date
    @Published var fromTime: Date
    @Published var toTime: Date
    @Published var estimatedPrice: Double
    
    @Published var pickupViewed: Bool
    
    init(){
        self.image = ""
        self.items = ""
        self.address = ""
        self.date = Date.now
        self.fromTime = Date.now
        self.toTime = Calendar.current.date(byAdding: .hour, value: 2, to: Date.now)!
        self.estimatedPrice = 0.0
        
        self.pickupViewed = false
    }
    
}
