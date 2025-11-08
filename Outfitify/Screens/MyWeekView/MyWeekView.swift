//
//  PlannerView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI

struct MyWeekView: View {
    @State private var selectedDate: Date = Date.now
    
    var body: some View {
        NavigationStack{
            ScrollView {
                WeekCalendarView(selectedDate: $selectedDate)
                    .padding(.bottom, 50)
                    
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(.black, lineWidth: 3)
                        .foregroundStyle(.background)
                        .frame(width: 350, height: 500)
                    
                    Image(systemName: "tshirt.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 500)
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
            }
            .navigationTitle("My Week")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
    

#Preview {
    MyWeekView()
}


struct WeekCalendarView: View {
    @Binding var selectedDate: Date
    
    let rows = [GridItem(.fixed(10)), GridItem(.fixed(40))]
    var weekdays: [Date] {
            getWeekDates(for: selectedDate, using: .gregorian)
    }
    
    var body: some View {
        VStack (spacing: 5){
            HStack{
                Text(selectedDate.formatted(.dateTime.month(.wide)) + " " + selectedDate.formatted(.dateTime.year()))
                    .foregroundStyle(.accent)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)
            
            HStack{
                Button {
                    selectedDate.addTimeInterval(-86400*7)
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                }
                .buttonStyle(.automatic)
                .fontWeight(.semibold)
                
                LazyHGrid(rows: rows){
                    ForEach(weekdays, id: \.self) { day in
                        var isSelected: Bool {
                            Calendar.current.isDate(selectedDate, equalTo: day, toGranularity: .day)
                        }
                        
                        Text(day.formatted(.dateTime.weekday(.abbreviated)))
                            .padding(.bottom, 4)
                            .bold(isSelected)
                        
                        Button {
                            selectedDate = day
                        } label: {
                            ZStack{
                                if isSelected {
                                    Circle()
                                        .foregroundStyle(.sec)
                                        .scaledToFit()
                                }
                                Text(day.formatted(.dateTime.day()))
                                    .bold(isSelected)
                            }
                            .frame(width: 35, height: 35)
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                
                Button {
                    selectedDate.addTimeInterval(86400*7)
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.title)
                }
                .buttonStyle(.automatic)
                .fontWeight(.semibold)
            }
        }
        
        
        
    }
}
