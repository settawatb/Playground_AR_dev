//
//  MainPage.swift
//  Playground_AR
//
//  Created by Settawat Buddhakanchana on 4/12/2566 BE.
//

import SwiftUI

struct MainPage: View {
    // Current Tab
    @State var currentTab: Tab = .Home
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    // Animation Namespace
    @Namespace var animation
    
    //Hiding Tab Bar
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            // Tab View
            TabView(selection: $currentTab) {
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                FavoritePage()
                    .environmentObject(sharedData)
                    .tag(Tab.Favorite)
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
                ProfilePage()
                    .tag(Tab.Profile)
            }
            Divider()
                .background(Color.black.opacity(0.4))
            //Custom Tab Bar
            HStack(spacing :0){
                ForEach(Tab.allCases,id: \.self){tab in
                    Button {
                        //updating tab
                        currentTab = tab
                    } label: {
                        
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            // Background Tab icon
                            .background(
                                Color(red: 125/255, green: 122/255, blue: 255/255)
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    // blur
                                    .blur(radius:5)
                                    // size icon big
                                    .padding(-7)
                                    .opacity(currentTab == tab ?
                                             1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ?
                                             Color(red: 125/255, green: 122/255, blue: 255/255):Color.black.opacity(0.35))
                    }
                }
            }
            .padding(.top, 23)
            .padding(.bottom)
        }
        .background(Color(.white).ignoresSafeArea())
        .overlay(
            ZStack{
                // Detail Page
                if let product = sharedData.detailProduct, sharedData.showDetailProduct{
                    
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                    
                    // adding transitions
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}


// Case Interatable
//Tab Basses
enum Tab: String,CaseIterable {
    
    //Image in asset
    case Home = "Home"
    case Favorite = "Favorite"
    case Cart = "Cart"
    case Profile = "Profile"
}


#Preview {
    MainPage()
}
