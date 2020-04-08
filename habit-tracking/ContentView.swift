import SwiftUI

struct ContentView: View {
    @State var text = ""
    @State var detail = ""
    @ObservedObject var habits = Habits()
    
    func removeItems(at offsets: IndexSet) {
        habits.array.remove(atOffsets: offsets)
        // 削除→削除された状態のarrayをuserdefaultsに保存
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(habits.array) {
            UserDefaults.standard.set(data, forKey: "Habits")
        }}
    
    func updateData(){
        //DetailViewで変更したamountが代入されているarrayを画面再表示の時に更新する処理
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: habits) {
                self.habits.array = decoded
                return
            }
        }
        self.habits.array = []
    }
    
    var body: some View {
        NavigationView {
            
            VStack {
                TextField("アクティビティ", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                TextField("詳細", text: $detail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                
                List {
                    ForEach(habits.array) { habit in
                        NavigationLink(destination: DetailView(habit: habit, index: self.habits.array.firstIndex(of: habit) ?? 0)){
                            HStack {
                                Text(habit.name)
                                Text("\(habit.amount)回")
                            }
                        }
                    } .onDelete(perform: removeItems)
                }
                
                
            }.navigationBarTitle(Text("Habit Track"))
                .navigationBarItems(trailing:
                    Button(action: {
                        if self.text == "" || self.detail == ""{
                            return
                        } else {
                            let habit = Habit(name: self.text, amount: 0, detail: self.detail)
                            self.habits.array.append(habit)
                            
                            let encoder = JSONEncoder()
                            if let data = try? encoder.encode(self.habits.array) {
                                UserDefaults.standard.set(data, forKey: "Habits")
                                
                                //入力されたtext, detailを持ったHabitクラスをarrayに代入
                                //そのHabitクラスが代入された状態のhabits.arrayをuserdefaultsに保存
                                
                                self.text = ""
                                self.detail = ""
                            }
                        }}) {
                            Text("Save")
                    }
            ).onAppear(perform: updateData)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
