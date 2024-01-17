import SwiftUI

struct LaunchPage: View {
    
    @State var pageStat: String
    
    var body: some View {
        Text("Hello")
    }
}

struct previewLaunchPage: View {
    
    @State var pageState: String = "LaunchPage"
    
    var body: some View {
        LaunchPage(pageStat: pageState)
    }
}

#Preview {
    previewLaunchPage()
}
