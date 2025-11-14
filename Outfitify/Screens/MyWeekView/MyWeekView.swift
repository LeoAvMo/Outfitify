//
//  PlannerView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI
import SwiftData
struct MyWeekView: View {
    @State private var selectedDate: Date = Date.now
    
    @State private var showSheet: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @Query(sort: \DayFit.date) var dayFits: [DayFit]
    
    var body: some View {
        // Check if there's a dayfit in that day
        var dayFit: DayFit? {
            dayFits.first { Calendar.current.isDate(selectedDate, equalTo: $0.date, toGranularity: .day) }
        }
        
        NavigationStack{
            ScrollView {
                WeekCalendarView(selectedDate: $selectedDate)
                    .padding(.bottom, 10)
                    
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 3)
                        .foregroundStyle(.background)
                        .frame(width: 350, height: 500)
                    
                        if let imageData = dayFit?.image, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 350, height: 500)
                                .clipShape(RoundedRectangle(cornerRadius: 40))
                            
                        } else {
                            VStack{
                                Button{
                                    showSheet.toggle()
                                } label: {
                                    ZStack {
                                        Circle()
                                            .foregroundStyle(.accent)
                                        Image(systemName: "plus")
                                            .foregroundStyle(.primary)
                                            .font(.largeTitle)
                                    }
                                    .frame(width: 70, height: 80)
                                }
                                .buttonStyle(.glassProminent)
                                .padding(.bottom, 5)
                                Text("Add today's look!")
                                    .font(.title2)
                            }
                            .frame(width: 350, height: 500)
                    }
                }
            }
            .navigationTitle("My Week")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSheet){
                AddDayFit(date: selectedDate)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    DatePicker(selection: $selectedDate, displayedComponents: .date) {}
                }
            }
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

