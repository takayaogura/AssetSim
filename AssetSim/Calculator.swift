import SwiftUI
import Charts

struct Calculator: View {
   
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
    
    @State var barValues : [ChartDataEntry] = []

    struct LineChart : UIViewRepresentable {
        
        typealias UIViewType = LineChartView
     
        func makeUIView(context: Context) -> LineChartView {
            let lineChartView = LineChartView()
     
            lineChartView.data = setData()
            
            return lineChartView
        }
        
        func updateUIView(_ uiView: LineChartView, context: Context) {
     
        }
        
        let values:[ChartDataEntry] = Calculator().barValues
        
        func setData() -> LineChartData{
            let set = LineChartDataSet(entries: values, label: "My data")
            let data = LineChartData(dataSet: set)
            
            return data
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
                        self.r = "5.0"
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
                        for mth in 0...Int(month) {
                            ret = pret + tumitate * Double(Int(mth))
                            
                            //setArray(value: ret)
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

                }) {
                    Text("値をリセットする")
                }

            }
        }
       
    }
    
}
