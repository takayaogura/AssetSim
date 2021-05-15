
import SwiftUI
import Charts

/*
struct AssetChart: View {

    @State var pickerSelection = 0
    @State var barValues : [CGFloat] = Calculator().barValues
    
    var body: some View {
        ZStack{

            VStack{
                Text("積立金額と運用成績").foregroundColor(.white)
                    .font(.body)

                Picker(selection: $pickerSelection, label: Text("Stats"))
                    {
                    Text("積立金額").tag(0)
                    Text("運用成績").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)
 
                HStack(alignment: .center, spacing: 5)
                {
                    if barValues.count > 0 {
                        ForEach(barValues, id: \.self){
                            data in
                            BarView(value: data, cornerRadius: CGFloat(10))
                        }
                    }

                }.padding(.top, 20).animation(.default)

            }
        }
    }

    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemGreen
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
}

struct BarView: View{

    var value: CGFloat
    var cornerRadius: CGFloat
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 10, height: 200).foregroundColor(.gray)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 10, height: value).foregroundColor(.green)
            }.padding(.bottom, 8)
        }
    }
}

struct AssetChart_Previews: PreviewProvider {
    static var previews: some View {
        AssetChart()
    }
}
*/




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

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart().frame(height: 400)
    }
}

/*
func setChart(dataPoints: [String], values: [Double]) {
    var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "降水量")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
}
*/
