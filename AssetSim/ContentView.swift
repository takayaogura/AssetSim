
import SwiftUI
import Charts

struct ContentView: View {
   
    @State var p = ""
    @State var t = ""
    @State var r = ""
    @State var year = ""
    
    @State var principle = 0.0
    @State var tumitate = 0.0
    @State var rate = 0.0
    @State var month = 0.0
    
    @State var ret = 0.0
    @State var pret = 0.0
    @State var result = ""
    
    //@State var barValues : [ChartDataEntry] = []
    @State var barValues : [CGFloat] = []

    
    /*チャート部分==============================================================
    struct LineChart : UIViewRepresentable {
        
        @State var chartdata : [ChartDataEntry] = []
        
        typealias UIViewType = LineChartView
     
        func makeUIView(context: Context) -> LineChartView {
            let lineChartView = LineChartView()
     
            lineChartView.data = setData()
            
            return lineChartView
        }
        
        func updateUIView(_ uiView: LineChartView, context: Context) {
     
        }
                
        func setData() -> LineChartData{
            let set = LineChartDataSet(entries: ContentView().barValues, label: "My data")
            let data = LineChartData(dataSet: set)
            
            return data
        }
    }
    */
    
    struct BarView: View{

        var value: CGFloat
        var cornerRadius: CGFloat
        
        var body: some View {
            VStack {

                ZStack (alignment: .bottom) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 1, height: 100).foregroundColor(.black)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 1, height: value).foregroundColor(.green)
                    
                }.padding(.bottom, 8)
            }
            
        }
    }
    
    var body: some View {
       
        Form{
            Section(header: Text("資産運用シミュレーション")) {
                
                HStack {
                    Text("初期投資額").font(.system(size: 18))
                    TextField("100",text:self.$p).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                    Text("　　万円").font(.system(size: 18))
                }
                .padding(.vertical, 12.0)
                HStack {
                    Text("毎月の積立額").font(.system(size: 18))
                    TextField("5",text:self.$t).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                    Text("　　万円").font(.system(size: 18))

                }
                .padding(.vertical, 12.0)
                HStack {
                    Text("運用利回り").font(.system(size: 18))
                    TextField("5.0",text:self.$r).keyboardType(.decimalPad).multilineTextAlignment(.trailing)
                    Text("　　　%").font(.system(size: 18))
                }
                .padding(.vertical, 12.0)
                HStack {
                    Text("運用期間").font(.system(size: 18))
                    TextField("10",text:self.$year).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                    Text("　　　年").font(.system(size: 18))
                }
                .padding(.vertical, 12.0)
                
                Button(action: {
                    if self.p.count == 0 {
                        self.p = "100"
                    }
                    if self.t.count == 0 {
                        self.t = "5"
                    }
                    if self.r.count == 0 {
                        self.r = "0.0"
                    }
                    if self.year.count == 0 {
                        self.year = "10"
                    }
                    
                    month = Double(self.year)! * 12
                    tumitate = Double(self.t)! * 10000
                    principle = Double(self.p)! * 10000
                    pret = principle
                    
                    if Double(r) == 0.0 {
                        rate = 0
                        self.barValues = []
                        for i in 0...Int(month) {
                            ret = pret + tumitate * Double(Int(i))
                            //barValues.append(ChartDataEntry(x: Double(i), y: ret))
                            //barValues.append(ChartDataEntry(x: 55, y: 32))
                            barValues.append(CGFloat(ret/10000))
                            var valueMax 
                        }
                        result = String.localizedStringWithFormat("%d", Int(ret))

                    } else {
                        rate = Double(self.r)! / 1200
                        ret = (pow(1 + rate, month) - 1) / rate * tumitate
                        
                        for _ in 0..<Int(month) {
                            pret *= 1 + rate

                        }
                        result = String.localizedStringWithFormat("%d", Int(ret + pret))

                    }
                    //LineChart().chartdata = barValues

                }){
                    Text("計算する")
                }
                

                
                Text("予想資産額 ： \(result)円").font(.system(size: 18))
                
                Button(action: {
                    self.p = ""
                    self.t = ""
                    self.r = ""
                    self.year = ""
                    result = ""
                    barValues = []
                }) {
                    Text("値をリセットする")
                }
                //LineChart().frame(height:300)
                Text("\(barValues.count)")
            }
            
            ZStack{
                Color(.black).edgesIgnoringSafeArea(.all)

                VStack{
                    Text("Bar Charts").foregroundColor(.white)
                        .font(.largeTitle)

                    HStack(alignment: .center, spacing: 1)
                    {
                        ForEach(barValues, id: \.self){
                            data in
                            
                            BarView(value: data, cornerRadius: CGFloat(5))
                        }
                    }.padding(.top, 24).animation(.default)
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
