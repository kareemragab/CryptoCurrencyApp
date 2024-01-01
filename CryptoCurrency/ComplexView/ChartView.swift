//
//  ChartView.swift
//  CryptoCurrency
//
//  Created by Kareem Ragab Hassan on 25/12/2023.
//

import SwiftUI

struct ChartView: View {
    
    var  data : [Double] = []
    let coin : CoinModel
    var  minY:Double 
    var  maxY:Double
    var chartColor:Color
    @State var TrimValue = 0.0
    
    init(coin : CoinModel){
        self.coin = coin
        data =  coin.sparklineIn7D?.price ?? []
      minY = data.min() ?? 0
       maxY = data.max() ?? 0
        
        let PriceStatus = data.last! - data.first!
        
        chartColor = PriceStatus > 0 ?  .Theme.Green : .Theme.Red
        
    }
    
    // 100 / 30
    
    
    var body: some View {
        
        ChartItem
            .frame(height:200)
            .background(
                VStack{
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                  
                }
            )
            .overlay(VStack{
                Text(data.max()?.formattedWithAbbreviations() ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading)
                Spacer()
                Text((((data.max() ?? 0.0) + (data.min() ?? 0.0)) / 2 ) .formattedWithAbbreviations() )
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading)
                Spacer()
                Text(data.min()?.formattedWithAbbreviations() ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading)
                
            }
                     , alignment: .leading)
        
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.Coin)
    }
}


extension ChartView {
    
    var ChartItem : some View {
        GeometryReader { geo in
            Path{ path in
                
                for index in data.indices{
                    
                    let Xposition =  geo.size.width / CGFloat(data.count)
                    * CGFloat(index + 1)
                    
                    let Yaxis = maxY - minY
                    
                    let Yposition = (1-CGFloat(data[index]-minY) /  Yaxis ) *
                    geo.size.height
                    
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: Xposition, y: Yposition))
                    }
                    
                    path.addLine(to: CGPoint(x: Xposition, y: Yposition))
                    
                    
                }
                   
                
                
                
                
            }
            .trim(from: 0, to: TrimValue)
            .stroke(chartColor , style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
            .shadow(color: chartColor, radius: 10, x: 0, y: 15)
            .shadow(color: chartColor.opacity(0.3), radius: 10, x: 0, y: 30)
            .shadow(color: chartColor.opacity(0.2), radius: 10, x: 0, y: 40)
            .shadow(color: chartColor.opacity(0.1), radius: 10, x: 0, y: 50)
            .shadow(color: chartColor.opacity(0.1), radius: 10, x: 0, y: 60)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    withAnimation(.linear(duration: 3.0)) {
                        TrimValue = 1
                    }
                }
            }
        }
        
        
        
    }
}
