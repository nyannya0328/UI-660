//
//  Home.swift
//  UI-660
//
//  Created by nyannyan0328 on 2022/09/04.
//

import SwiftUI
import Charts

struct Home: View {
    var props : Properties
    @Namespace var animation
    @State var currentTab : String = "Home"
    
    @State var showSide : Bool = false
    var body: some View {
        HStack(spacing:0){
            
            if props.isAdaptable{
                
                ViewThatFits {
                    SideBar()
                    
                    ScrollView(.vertical,showsIndicators: false){
                        
                        SideBar()
                        
                        
                    }
                    .background{
                        
                        Color.white
                            .ignoresSafeArea()
                    }
                    .onAppear{
                        
                        withAnimation(.easeInOut){
                            showSide = false
                        }
                    }
                }
                
            }
            
            
            ScrollView(.vertical,showsIndicators: false){
                
                
                VStack{
                    
                    HeaderView()
                    
                    InfoCardView()
                    
                    ScrollView(.horizontal,showsIndicators: false){
                        
                        HStack(spacing:20){
                            
                            GraphView()
                            PieChartView()
                        }
                        .padding(.horizontal,15)
                    }
                    .padding(.horizontal,-15)
                    
                    
                    TrendingItemView()
                }
                .padding(15)
                
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .leading)
        .background{
            
            Color.black.opacity(0.05).ignoresSafeArea()
        }
        .overlay(alignment:.leading){
            
            
            
            ViewThatFits {
                SideBar()
                ScrollView(.vertical,showsIndicators: false){
                    
                    SideBar()
                    
                    
                   
                    
                    
                    
                }
                .background{
                    
                    Color.white.ignoresSafeArea()
                }
                
            }
            .offset(x:showSide ? 0 : -100)
            .frame(maxWidth: .infinity,alignment: .leading)
            .background{
                
                Color.black
                    .opacity(showSide ? 0.25 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.easeIn){
                            
                            showSide.toggle()
                        }
                    }
            }
            
        }
        
        
    }
    @ViewBuilder
    func TrendingItemView ()->some View{
        
        VStack(alignment:.leading,spacing: 10){
            
         
              Text("Trending Dishes")
                .font(.title2.weight(.semibold))
              .frame(maxWidth: .infinity,alignment: .leading)
            
            let isAdaptable = props.isIpad && !props.isMaxSprit
            
            let columns = Array(repeating: GridItem(.flexible(),spacing: props.isAdaptable ? 20 : 15), count: isAdaptable ? 2 : 1)
            
            LazyVGrid(columns: columns,spacing: 13) {
                
                
                ForEach(trendingDishes){item in
                    
                    HStack(spacing: 10) {
                        
                        Image(item.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                         .frame(width: 35,height: 35)
                         .padding(20)
                         .background{
                          
                             RoundedRectangle(cornerRadius: 10, style: .continuous)
                                 .fill(Color("Orange").opacity(0.05))
                         }
                        
                        VStack(alignment:.leading,spacing: 10){
                            
                         
                            Text(item.title)
                                .fontWeight(.heavy)
                                .lineLimit(1)
                            
                            Label {
                                
                                Text(item.title)
                                    .foregroundColor(Color("Orange"))
                                
                            } icon: {
                                
                                Text(item.subTitle)
                                    .foregroundColor(.gray)
                                
                            }

                            
                            
                            
                            
                            
                        }
                        
                    }
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .overlay(alignment: .topTrailing) {
                     
                        Button("View All"){}
                            .font(.caption.bold())
                            .foregroundColor(Color("Orange"))
                            .offset(y:6)
                            
                            
                            
                        
                    }
                    
                }
                .padding(15)
                .background{
                 RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                .padding(.top,10)
                
            }
            
        }
          .frame(maxWidth: .infinity,alignment: .leading)
    }
    @ViewBuilder
    func PieChartView ()->some View{
        
        VStack{
            
              Text("Total Income")
                .font(.body.weight(.medium))
              .frame(maxWidth: .infinity,alignment: .leading)
            
            
            ZStack{
                
                Circle()
                    .trim(from: 0.5,to: 1)
                    .stroke(.red,style: StrokeStyle(lineWidth: 20,lineCap: .round,lineJoin: .round))
                
                Circle()
                    .trim(from: 0.2,to: 0.5)
                    .stroke(.yellow,style: StrokeStyle(lineWidth: 20,lineCap: .round,lineJoin: .round))
                
                Circle()
                    .trim(from: 0,to: 0.2)
                    .stroke(.green,style: StrokeStyle(lineWidth: 20,lineCap: .round,lineJoin: .round))
                
                Text("$250")
                    .font(.largeTitle.weight(.heavy))
            }
            .padding(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 10) {
                
                
                Label {
                    
                      Text("Food")
                    
                } icon: {
                  Image(systemName: "circle.fill")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
                
                
                Label {
                    
                      Text("Drink")
                    
                } icon: {
                  Image(systemName: "circle.fill")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
                
                
                Label {
                    
                      Text("Others")
                    
                } icon: {
                  Image(systemName: "circle.fill")
                        .font(.caption)
                        .foregroundStyle(.yellow)
                }
                

                
                
            }
        }
        .padding(15)
        .background{
         
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
        
        
    }
    @ViewBuilder
    func GraphView ()->some View{
        
        
        VStack(alignment:.leading,spacing: 10){
            
         
              Text("Daily Sales")
                .font(.title3.bold())
            
            Chart{
                
                ForEach(dailySales){sale in
                    
                    AreaMark(x: .value("Time", sale.time), y: .value("Sale", sale.sales))
                        .foregroundStyle(
                        
                        
                            LinearGradient(colors: [
                                Color("Orange").opacity(0.6),
                                Color("Orange").opacity(0.4),
                                Color("Orange").opacity(0.3),
                                Color("Orange").opacity(0.1),
                                .clear
                            
                            
                            ], startPoint: .top, endPoint:.bottom)
                        
                        )
                        .interpolationMethod(.catmullRom)
                    
                    LineMark(x: .value("Time", sale.time), y: .value("Sale",sale.sales))
                        .foregroundStyle(Color("Orange"))
                        .interpolationMethod(.catmullRom)
                    
                    PointMark(x: .value("Time", sale.time), y: .value("Sale",sale.sales))
                        .foregroundStyle(Color("Orange"))
                        .interpolationMethod(.catmullRom)
                        
                    
                    
                }
            }
            .frame(height:180)
            
            
            
            
        }
        .padding(15)
        .background{
         
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
        .frame(width:props.isAdaptable ? props.size.width - 400 : props.size.width - 30)
        
        
    }
    @ViewBuilder
    func InfoCardView ()->some View{
        
        ScrollView(.horizontal,showsIndicators: false){
            
            HStack(spacing:15){
                
                ForEach(infos){info in
                    
                    VStack(alignment:.leading,spacing: 10){
                        
                        
                        HStack(spacing:15){
                            
                            Text(info.title)
                                .font(.title3.bold())
                            
                            Spacer()
                            
                            HStack(spacing:10){
                                
                                Image(systemName: info.loss ? "arrow.down" : "arrow.up")
                                    .font(.callout)
                                    .foregroundColor(info.loss ? Color("Orange") : .green)
                                
                                Text("\(info.percentage)%")
                                    .font(.caption)
                            }
                            
                        }
                        
                        HStack{
                            
                            Image(systemName: info.icon)
                                
                                .font(.title3)
                                .foregroundColor(.white)
                                .frame(width:45,height: 45)
                                .background{
                                 
                                    Circle()
                                        .fill(info.iconColor)
                                    
                                }
                            
                            Text(info.amount)
                                .font(.title.weight(.black))
                                
                               
                        }
                        
                    }
                    
                    .padding()
                    .background{
                     
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                        
                    }
                    
                }
            }
            .padding(15)
          
            
            
        }
        .padding(.horizontal,-15)
      
        
    }
    @ViewBuilder
    func HeaderView ()->some View{
        
        let layOut = props.isIpad && !props.isMaxSprit ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout(spacing:10))
        
        
        layOut{
            
            VStack(alignment:.leading,spacing: 10){
                
                
                
                Text("Seatle NY")
                    .font(.title2.weight(.bold))
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.caption.weight(.semibold))
                
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            
            HStack(spacing:10){
                
                if !props.isAdaptable{
                    
                    Button {
                        
                        withAnimation(.easeInOut(duration: 0.5)){
                            
                            showSide.toggle()
                        }
                    } label: {
                        
                        Image(systemName: "line.horizontal.3")
                            .font(.title3)
                            .foregroundColor(.black)
                        
                        
                    }
                    
                }
                
                TextField("Search", text: .constant(""))
                
                Image("Search")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25,height: 25)
                
                
                
                
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .background{
                Capsule()
                    .fill(.white)
                
                
            }
            
        }
        
        
        
        
    }
    @ViewBuilder
    func SideBar()->some View{
        let tabs: [String] = [
            "Home","Table","Menu","Order","History","Report","Alert","Settings"]
        VStack(spacing:10) {
            
            
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 55,height: 55)
            
            
            ForEach(tabs,id:\.self){tab in
                
                VStack(spacing:10){
                    
                    Image(tab)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25,height: 25)
                    
                    Text(tab)
                        .font(.caption.weight(.semibold))
                    
                    
                    
                }
                .foregroundColor(currentTab == tab ? Color("Orange") : .gray)
                .frame(width:65)
                .padding(.vertical,15)
                .padding(.horizontal,15)
                .background{
                    
                    if currentTab == tab{
                        
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color("Orange").opacity(0.05))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                        
                    }
                }
                .onTapGesture {
                    
                    withAnimation(.easeInOut){currentTab = tab}
                }
            }
            
            
            VStack{
                Image("Pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30,height: 30)
                    .clipShape(Circle())
                
                Text("Profile")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.cyan.opacity(0.5))
            }
            .padding(.top,10)
            
            
            
            
            
            
            
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .frame(width:100)
        .background{
            
            Color.white.ignoresSafeArea()
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
