import Foundation
import Supabase

final class requestsModel: ObservableObject{
    
    @Published var responseStatus = 404
    @Published var responseMessage = "Something went wrong"
    
    @Published var requests = [getRequest]()
    
    let supabase = SupabaseClient(supabaseURL: Secrets.projectURL!, supabaseKey: Secrets.apiKey)
    
    func addNewRequest(userID: Int, userEmail: String, category: String, detail: String) async throws{
        
        let newRequest = addRequest(userID: userID, userEmail: userEmail, category: category, detail: detail, status: "added")
        
        let response = try await supabase.database
            .from(Tabel.Requests)
            .insert(newRequest)
            .execute()
        print(response.status)
        self.responseStatus = 200
        self.responseMessage = "Added Request"
    }
    
}
