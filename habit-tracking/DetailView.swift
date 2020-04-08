import SwiftUI

struct DetailView: View {
    @ObservedObject var habits = Habits()
    
    var habit: Habit
    var index: Int
    
    init(habit: Habit, index: Int) {
        self.habit = habit
        self.index = index
        //動かない　self.amount = habits.array[index].amount
        //↑　indexに数字は入っていたが、肝心のhabits.arrayに何も入っていなかったためエラーだった index out of range
    }

    var body: some View {
        VStack {
            Text("アクティビティ: \(habit.name)")
            Text("詳細: \(habit.detail)")
            Stepper(value: self.$habits.array[index].amount) {
//                $のついたデータはhabit.swiftで自動保存してくれている？
                Text("回数: \(self.habits.array[index].amount)")

            }.padding(.horizontal)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var habits = Habits()
    static var previews: some View {
        DetailView(habit: habits.array[0], index: 0)
    }
}
