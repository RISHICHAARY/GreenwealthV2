import Foundation
import Supabase

enum Tabel{
    
    static let Users = "Users"
    static let Pickups = "Pickups"
    static let Requests = "Requests"
    
}

enum Defaults{
    
    static let profileImage = "https://firebasestorage.googleapis.com/v0/b/greenwealth-68871.appspot.com/o/Profile.png?alt=media&token=27712235-9bd0-414a-9b70-53125764e872"
    
    static let imageURL = "https://firebasestorage.googleapis.com/v0/b/greenwealth-68871.appspot.com/o/demo.png?alt=media&token=ab43aad1-9825-4e44-b78c-422a231be7cf"
    
}

final class usersModel: ObservableObject{
    
    @Published var users = [getUsers]()
    @Published var usersRanking = [getUsers]()
    @Published var userGlobalRank = 0
    @Published var responseStatus = 200
    @Published var responseMessage = "Something went wrong"
    
    @Published var isLogged = false
    
    let supabase = SupabaseClient(supabaseURL: Secrets.projectURL!, supabaseKey: Secrets.apiKey)

    func loginUser(emailAddress: String, password: String) async throws{
        
        let Users: [getUsers] = try await supabase.database
            .from(Tabel.Users)
            .select()
            .eq("emailAddress", value: emailAddress.lowercased())
            .eq("password", value: password)
            .eq("accountStatus", value: "active")
            .order("fullName",ascending: false)
            .execute()
            .value
        DispatchQueue.main.async {
            if(!Users.isEmpty){
                self.isLogged = true
            }
            self.users = Users
        }
        
    }
    
    func addUser(fullName: String, emailAddress: String, mobileNumber: String, password: String) async throws{
        
        let Users: [getUsers] = try await supabase.database
            .from(Tabel.Users)
            .select()
            .eq("emailAddress", value: emailAddress.lowercased())
            .order("fullName",ascending: false)
            .execute()
            .value
        
        if(!Users.isEmpty){
            self.responseStatus = 404
            self.responseMessage = "Email already registered"
            self.isLogged = false
        }
        else{
            let newUser = addUsers(fullName: fullName, emailAddress: emailAddress.lowercased(), mobileNumber: mobileNumber, accountStatus: "active", deviceToken: "notYetAdded", profileImage: Defaults.profileImage, password: password)
            
            let response = try await supabase.database
                .from(Tabel.Users)
                .insert([newUser])
                .execute()
            
            let addedUser: [getUsers] = try await supabase.database
                .from(Tabel.Users)
                .select()
                .eq("emailAddress", value: emailAddress.lowercased())
                .order("fullName",ascending: false)
                .execute()
                .value
            DispatchQueue.main.async {
                if(!addedUser.isEmpty){
                    self.responseStatus = 200
                    self.responseMessage = "User created successfully"
                    self.isLogged = true
                    self.users = addedUser
                }
            }
        }
        
    }
    
    func getUser(emailAddress: String) async throws{
        
        let Users: [getUsers] = try await supabase.database
            .from(Tabel.Users)
            .select()
            .eq("emailAddress", value: emailAddress.lowercased())
            .order("fullName",ascending: false)
            .execute()
            .value
        DispatchQueue.main.async {
            
            self.responseStatus = 200
            self.responseMessage = "Found user"
            self.users = Users
        }
        
    }
    
    func getStats() async throws{
        
        let Users: [getUsers] = try await supabase.database
            .from(Tabel.Users)
            .select()
            .order("ecoPoints",ascending: false)
            .order("fullName", ascending: true)
            .execute()
            .value
        DispatchQueue.main.async {
            
            self.responseStatus = 200
            self.responseMessage = "Found user"
            self.usersRanking = Users
        }
        
    }
    
    func getGlobalRank(userID: Int) async throws{
        
        let Users: [getUsers] = try await supabase.database
            .from(Tabel.Users)
            .select()
            .order("ecoPoints",ascending: false)
            .order("fullName", ascending: true)
            .execute()
            .value
        DispatchQueue.main.async {
            
            for i in 0...Users.count-1{
                if(Users[i].id == userID){
                    self.userGlobalRank = i+1
                }
            }
            
        }
        
    }
    
}
