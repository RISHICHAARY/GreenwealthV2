import SwiftUI

struct PastOrders: View {
    
    @Binding var pageState: String
    @ObservedObject var pickupModel: pickupsModel
    
    @State var searchText: String = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(action:{
                    withAnimation{
                        pageState = "DashboardPage"
                    }
                }){
                    Image(systemName: "chevron.left")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(Color.primaryGreen)
                        .font(.system(size: 17,weight: .semibold))
                }
                Spacer()
                Text("Previous orders")
                    .font(.system(size: 17,weight: .bold))
                    .padding(.vertical,10)
                Spacer()
            }
            .padding(.horizontal,40)
//            HStack{
//                Image(systemName: "magnifyingglass")
//                    .symbolRenderingMode(.hierarchical)
//                    .font(.system(size: 17,weight: .semibold))
//                TextField("Search...",text: $searchText)
//                    .symbolRenderingMode(.hierarchical)
//                    .font(.system(size: 17,weight: .semibold))
//
//            }
//            .padding(10)
//            .background(.white)
//            .cornerRadius(10)
//            .padding(.horizontal,20)
            if(pickupModel.hasPickups){
                ScrollView{
                    
//                    ForEach( pickupModel.activePickups, id: \.id ){ pickup in
//                        VStack(spacing:15){
//                            HStack{
//                                Text("#"+"\(pickup.id!)")
//                                Spacer()
//                                Text("\(pickup.status)".capitalized)
//                                    .foregroundColor(Color.primaryGreen)
//                            }
//                            .font(.system(size: 17,weight: .medium))
//                            Divider()
//                            HStack{
//                                Image("demo")
//                                    .resizable()
//                                    .frame(width: 50,height: 50)
//                                    .cornerRadius(5)
//                                VStack(alignment:.leading){
//                                    Text("5 kgs")
//                                    HStack(spacing:5){
//                                        Text(pickup.date.formatted(date: .abbreviated,time: .omitted))
//                                        Text(",")
//                                        Text(pickup.startTime.formatted(date:.omitted,time: .shortened))
//                                        Text("to")
//                                        Text(pickup.endTime.formatted(date:.omitted,time: .shortened))
////        //                                Spacer()
//                                    }
//                                }
//                                .font(.system(size: 17,weight: .medium))
//                                Spacer()
//                            }
//                            Divider()
//                            HStack{
//                                HStack{
//                                    Text("Rate:")
//                                    Image(systemName: "star")
//                                        .symbolRenderingMode(.hierarchical)
//                                    Image(systemName: "star")
//                                        .symbolRenderingMode(.hierarchical)
//                                    Image(systemName: "star")
//                                        .symbolRenderingMode(.hierarchical)
//                                    Image(systemName: "star")
//                                        .symbolRenderingMode(.hierarchical)
//                                }
//                                Spacer()
//                                HStack{
//                                    Text("-- Pts")
//                                }
//                            }
//                            .font(.system(size: 17,weight: .medium))
//                        }
//                        .padding(10)
//                        .background(.white)
//                        .cornerRadius(10)
//                        .padding(.horizontal,20)
//                    }
                    
                    ForEach( pickupModel.Pickups, id: \.id ){ pickup in
                        VStack(spacing:15){
                            HStack{
                                Text("#"+"\(pickup.id!)")
                                Spacer()
                                if(pickup.status == "canceled"){
                                    Text("\(pickup.status)".capitalized)
                                        .foregroundColor(.red)
                                }
                                else{
                                    Text("\(pickup.status)".capitalized)
                                        .foregroundColor(Color.primaryGreen)
                                }
                            }
                            .font(.system(size: 17,weight: .medium))
                            Divider()
                            HStack{
                                Image("demo")
                                    .resizable()
                                    .frame(width: 50,height: 50)
                                    .cornerRadius(5)
                                VStack(alignment:.leading){
                                    Text("5 kgs")
                                    HStack(spacing:5){
                                        Text(pickup.date.formatted(date: .abbreviated,time: .omitted))
                                        Text(",")
                                        Text(pickup.startTime.formatted(date:.omitted,time: .shortened))
                                        Text("to")
                                        Text(pickup.endTime.formatted(date:.omitted,time: .shortened))
//        //                                Spacer()
                                    }
                                }
                                .font(.system(size: 17,weight: .medium))
                                Spacer()
                            }
                            Divider()
                            HStack{
                                HStack{
                                    Text("Rate:")
                                    Image(systemName: "star")
                                        .symbolRenderingMode(.hierarchical)
                                    Image(systemName: "star")
                                        .symbolRenderingMode(.hierarchical)
                                    Image(systemName: "star")
                                        .symbolRenderingMode(.hierarchical)
                                    Image(systemName: "star")
                                        .symbolRenderingMode(.hierarchical)
                                }
                                Spacer()
                                HStack{
                                    Text("-- Pts")
                                }
                            }
                            .font(.system(size: 17,weight: .medium))
                        }
                        .padding(10)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal,20)
                    }
                    
                }
                .background(Color.primaryBackground)
                .transition(.move(edge: .leading))
                .animation(.easeInOut(duration: 0.7))
            }
            else{
                EmptyPage()
            }
        }
    }
}

struct previewHistoryPage: View {
    
    @State var selectedItems: String = ""
    
    @StateObject var pickupData = pickUp()
    @StateObject private var pickupModel = pickupsModel()
    
    func test() async{
        try? await pickupModel.getPickups(userId: 1)
        try? await pickupModel.getActivePickups(userId: 1)
    }
    
    var body: some View {
        PastOrders(pageState: $selectedItems, pickupModel: pickupModel)
            .task {
                do{
                    try await test()
                }
                catch{
                    print(error)
                }
            }
    }
}

#Preview {
    previewHistoryPage()
}
