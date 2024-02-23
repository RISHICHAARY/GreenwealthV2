import Foundation
import Supabase

let supabase = SupabaseClient(supabaseURL: Secrets.projectURL, supabaseKey: Secrets.apiKey)

func fetchUsers() async throws{
    
    let users = try await supabase.database
        .from("Users")
        .select()
        .execute()
        .value
    DispatchQueue.main.async {
        print(users)
    }
    
}
