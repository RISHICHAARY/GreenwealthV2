import SwiftUI
import MapKit

struct CurrentPickup: View {
    
    @Binding var pageState: String
    @ObservedObject var pickupModel: pickupsModel
    
    @State private var isPageLoading: Bool = false
    @State var isToastPresented: Bool = false
    @State var toastMessage: String = ""
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    
    @State private var isLogged: Bool = UserDefaults.standard.bool(forKey: "LoginState")
    @State private var loggedUserID: String = UserDefaults.standard.string(forKey: "LoggedUserID") ?? ""
    @State private var loggedUserName: String = UserDefaults.standard.string(forKey: "LoggedUserName") ?? ""
    @State private var loggedUserEmail: String = UserDefaults.standard.string(forKey: "LoggedUserEmail") ?? ""
    
    func loader(){
        
        if(isLogged){
            let latitude = Double((pickupModel.activePickups.first!.lattitude as NSString).doubleValue)
            let longitude = Double((pickupModel.activePickups.first!.longitude as NSString).doubleValue)
            
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
        else{
            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
        
    }
    
    func cancelOrder() async{
        
        isPageLoading.toggle()
        
        try! await pickupModel.cancelPickup(pickupID: pickupModel.activePickups.first!.id!)
        
        if(pickupModel.responseStatus == 200){
            try! await pickupModel.getActivePickups(userId: Int(loggedUserID)!)
            try! await pickupModel.getPickups(userId: Int(loggedUserID)!)
            if(pickupModel.responseStatus == 200){
                pageState = "DashboardPage"
            }
            else{
                isPageLoading.toggle()
                isToastPresented.toggle()
                toastMessage = pickupModel.responseMessage
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                    withAnimation{
                        isToastPresented.toggle()
                    }
            }
        }
        else{
            isPageLoading.toggle()
            isToastPresented.toggle()
            toastMessage = pickupModel.responseMessage
            try? await Task.sleep(nanoseconds: 2_000_000_000)
                withAnimation{
                    isToastPresented.toggle()
                }
        }
        
    }
    
    var body: some View {
        VStack{
            if(isPageLoading){
                LoadingPage()
            }
            else{
                ZStack{
                    if(isToastPresented){
                        VStack{
                            Text("\(toastMessage)")
                                .font(.system(size: 14,weight: .regular))
                                .foregroundColor(.white)
                        }
                        .padding(.vertical,5)
                        .padding(.horizontal,20)
                        .background(.red.opacity(0.8))
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.red.opacity(0.8),lineWidth:4)
                        )
                        .padding(.horizontal,20)
                        .zIndex(1)
                        .offset(y:-360)
                    }
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
                            Text("Your ongoing order")
                                .font(.system(size: 17,weight: .bold))
                                .padding(.vertical,10)
                            Spacer()
                        }
                        .padding(.horizontal,40)
                        VStack{
                            ZStack{
                                VStack{
                                    Map(coordinateRegion: $region)
                                                .frame(height: 220)
                                }
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("PrimaryGreen"),lineWidth:2)
                                )
                                Button(action:{}){
                                    VStack(spacing:5){
                                        Text("2 5 4 7")
                                            .font(.system(size: 14,weight: .bold))
                                        Text("OTP")
                                            .font(.system(size: 12,weight: .regular))
                                    }
                                    .foregroundColor(.black)
                                }
                                .frame(width: 88,height: 54)
                                .background(.white)
                                .cornerRadius(5)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color("PrimaryGreen"),lineWidth:2)
                                )
                                .offset(x:-123,y:65)
                            }
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                            ScrollView{
                                HStack{
                                    Button(action:{}){
                                        VStack(spacing:5){
                                            Image(systemName: "phone")
                                                .symbolRenderingMode(.hierarchical)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(Color.primaryGreen)
                                            Text("Call")
                                                .foregroundColor(.black)
                                                .font(.system(size: 17, weight: .regular))
                                        }
                                        .frame(width: 85, height: 70)
                                        .background(.white)
                                        .cornerRadius(10)
                                    }
                                    Button(action:{}){
                                        VStack(spacing:5){
                                            Image(systemName: "pencil")
                                                .symbolRenderingMode(.hierarchical)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(Color.primaryGreen)
                                            Text("Modify")
                                                .foregroundColor(.black)
                                                .font(.system(size: 17, weight: .regular))
                                        }
                                        .frame(width: 85, height: 70)
                                        .background(.white)
                                        .cornerRadius(10)
                                    }
                                    Button(action:{}){
                                        VStack(spacing:5){
                                            Image(systemName: "bubble")
                                                .symbolRenderingMode(.hierarchical)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(Color.primaryGreen)
                                            Text("Help")
                                                .foregroundColor(.black)
                                                .font(.system(size: 17, weight: .regular))
                                        }
                                        .frame(width: 85, height: 70)
                                        .background(.white)
                                        .cornerRadius(10)
                                    }
                                    Button(action:{
                                        Task{
                                            await cancelOrder()
                                        }
                                        
                                    }){
                                        VStack(spacing:5){
                                            Image(systemName: "x.circle")
                                                .symbolRenderingMode(.hierarchical)
                                                .font(.system(size: 17, weight: .semibold))
                                                .foregroundColor(Color.primaryGreen)
                                            Text("Cancel")
                                                .foregroundColor(.black)
                                                .font(.system(size: 17, weight: .regular))
                                        }
                                        .frame(width: 85, height: 70)
                                        .background(.white)
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(.horizontal,20)
                                VStack(spacing:20){
                                    HStack{
                                        Image(systemName: "camera")
                                            .symbolRenderingMode(.hierarchical)
                                            .foregroundColor(Color.primaryGreen)
                                            .font(.system(size: 17,weight: .medium))
                                        Text("Approx 5 kgs")
                                            .font(.system(size: 17, weight: .medium))
                                        Spacer()
                                        if(isLogged){
                                            AsyncImage(url: URL(string: pickupModel.activePickups.first!.imageURL)) { image in
                                                image.resizable()
                                            } placeholder: {
                                            ProgressView()
                                        }
                                                .frame(width: 50,height: 50)
                                                .cornerRadius(5)
                                        }
                                        else{
                                            Image("demo")
                                                .frame(width: 50,height: 50)
                                                .cornerRadius(5)
                                        }
                                    }
                                    Divider()
                                    HStack{
                                        Image(systemName: "trash")
                                            .symbolRenderingMode(.hierarchical)
                                            .foregroundColor(Color.primaryGreen)
                                            .font(.system(size: 17,weight: .medium))
                                        if(isLogged){
                                            Text("\(pickupModel.activePickups.first!.categories)")
                                                .font(.system(size: 17, weight: .medium))
                                        }
                                        else{
                                            Text("Paper,Plastic")
                                                .font(.system(size: 17, weight: .medium))
                                        }
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Image(systemName: "location")
                                            .symbolRenderingMode(.hierarchical)
                                            .foregroundColor(Color.primaryGreen)
                                            .font(.system(size: 17,weight: .medium))
                                        if(isLogged){
                                            Text("\(pickupModel.activePickups.first!.address)")
                                                .font(.system(size: 17, weight: .medium))
                                        }
                                        else{
                                            Text("SRM University")
                                                .font(.system(size: 17, weight: .medium))
                                        }
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Image(systemName: "calendar")
                                            .symbolRenderingMode(.hierarchical)
                                            .foregroundColor(Color.primaryGreen)
                                            .font(.system(size: 17,weight: .medium))
                                        HStack(spacing:5){
                                            if(isLogged){
                                                Text(pickupModel.activePickups.first!.date.formatted(date: .abbreviated,time: .omitted))
                                                Text(",")
                                                Text(pickupModel.activePickups.first!.startTime.formatted(date:.omitted,time: .shortened))
                                                Text("to")
                                                Text(pickupModel.activePickups.first!.endTime.formatted(date:.omitted,time: .shortened))
                                            }
                                            else{
                                                Text(Date.now.formatted(date: .abbreviated,time: .omitted))
                                                Text(",")
                                                Text(Date.now.formatted(date:.omitted,time: .shortened))
                                                Text("to")
                                                Text(Date.now.formatted(date:.omitted,time: .shortened))
                                            }
            //                                Spacer()
                                        }
                                        .font(.system(size: 17, weight: .medium))
            //                            Text("Jan 23, 9:40am to 11:40am")
            //                                .font(.system(size: 17, weight: .medium))
                                        Spacer()
                                    }
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.horizontal,20)
                                HStack{
                                    Text("Estimated price you receive")
                                    Spacer()
                                    HStack{
                                        Image(systemName: "indianrupeesign")
                                            .symbolRenderingMode(.hierarchical)
                                        Text("200")
                                    }
                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .padding(.horizontal,20)
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
        .task {
            loader()
        }
    }
}

struct previewCurrentPickup: View {
    
    @State var selectedItems: String = ""
    
    @StateObject var pickupData = pickUp()
    @StateObject var pickupModel = pickupsModel()
    
    var body: some View {
        CurrentPickup(pageState: $selectedItems, pickupModel: pickupModel)
    }
}

#Preview {
    previewCurrentPickup()
}
