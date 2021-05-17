import SwiftUI

struct ContentView: View {
   
    //Textfield入力用
    @State var p = ""
    @State var t = ""
    @State var r = ""
    @State var year = ""
    
    //入力をdoubleに変換
    @State var principle = 0.0
    @State var tumitate = 0.0
    @State var rate = 0.0
    @State var month = 0.0
    
    //リターンと結果
    @State var ganpon = 0.0
    @State var valueMax = 0.0
    @State var ret = 0.0
    @State var pret = 0.0
    @State var result = ""
    
    //グラフ表示用の配列
    @State var barValues : [CGFloat] = []
    @State var barValues2 : [CGFloat] = []

    
    struct BarView: View{

        var value: CGFloat
        var cornerRadius: CGFloat
        var valueMax: CGFloat

        var body: some View {
            VStack {

                ZStack (alignment: .bottom) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 1, height: 250).foregroundColor(.black)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 1, height: 250*value/valueMax).foregroundColor(.green)
                }
            }
        }
    }
    
    struct BarView2: View{

        var value: CGFloat
        var cornerRadius: CGFloat
        var valueMax: CGFloat

        var body: some View {
            VStack {

                ZStack (alignment: .bottom) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 1, height: 250).foregroundColor(.clear)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: 1, height: 250*value/valueMax).foregroundColor(.yellow)
                }
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
                        self.r = "5.0"
                    }
                    if self.year.count == 0 {
                        self.year = "10"
                    }
                    
                    month = Double(self.year)! * 12
                    tumitate = Double(self.t)! * 10000
                    principle = Double(self.p)! * 10000
                    
                    self.barValues = []
                    self.barValues2 = []

                    if Double(r) == 0.0 {
                        rate = 0
                        //ganpon = principle
                        for i in 1...Int(month) {
                            ganpon = principle + tumitate * Double(Int(i))
                            barValues2.append(CGFloat(ganpon/10000))
                            valueMax = ganpon/10000
                        }
                        result = String.localizedStringWithFormat("%d", Int(ganpon))

                    } else {
                        rate = Double(self.r)! / 1200
                        pret = principle
                        for i in 1...Int(month) {
                            ret = (pow(1 + rate, Double(i)) - 1) / rate * tumitate
                            pret *= 1 + rate
                            valueMax = (ret + pret)/10000
                            barValues.append(CGFloat((ret + pret)/10000))
                            
                            ganpon = principle + tumitate * Double(Int(i))
                            barValues2.append(CGFloat(ganpon/10000))
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
                    ganpon = 0.0
                    result = ""
                    barValues = []
                    barValues2 = []
                }) {
                    Text("値をリセットする")
                }
            }
            HStack {
                Spacer()
                Text("積立金額と運用成績")
                Spacer()
            }

            ZStack{
                Color(.black).edgesIgnoringSafeArea(.all)

                ScrollView(.horizontal) {
                    VStack{

                        ZStack {
                            HStack(alignment: .center, spacing: 0.5)
                            {
                                ForEach(barValues, id: \.self){
                                    data in
                                    
                                    BarView(value: data, cornerRadius: CGFloat(0), valueMax: CGFloat(valueMax))
                                }
                            }
                            
                            HStack(alignment: .center, spacing: 0.5)
                            {
                                ForEach(barValues2, id: \.self){
                                    data in
                                    
                                    BarView2(value: data, cornerRadius: CGFloat(5), valueMax: CGFloat(valueMax))
                                }
                            }
                        }.padding(.bottom)
                    }
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
