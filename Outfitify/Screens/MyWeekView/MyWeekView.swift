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
    @State private var hideCalendar: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    @Query(sort: \DayFit.date) var dayFits: [DayFit]
    
    
    var body: some View {
        // Check if there's a dayfit in that day
        var dayFit: DayFit? {
            dayFits.first { Calendar.gregorian.isDate(selectedDate, equalTo: $0.date, toGranularity: .day) }
        }
        NavigationStack{
            ZStack {
                VStack {
                    if let imageData = dayFit?.image, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    } else {
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
                            
                            Text("Add today's look!")
                                .font(.title2)
                    }
                }
                .frame(minWidth: 0)
                .ignoresSafeArea(.all)
                
                if dayFit == nil || !hideCalendar {
                    VStack {
                        WeekCalendarView(selectedDate: $selectedDate)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                
            }
            .navigationTitle(selectedDate.formatted(.dateTime.month(.wide)) + " " + selectedDate.formatted(.dateTime.year()))
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showSheet){
                AddDayFitView(date: selectedDate)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    DatePicker(selection: $selectedDate, displayedComponents: .date) {}
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Hide Calendar", systemImage: "calendar") {
                        hideCalendar.toggle()
                    }
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
        
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .foregroundStyle(.sec)
            HStack {
                Button {
                    selectedDate.addTimeInterval(-86400*7)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                }
                .buttonStyle(.automatic)
                .fontWeight(.semibold)
                .padding(.bottom, 7)
                
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
                                        .foregroundStyle(.accent)
                                        .scaledToFit()
                                }
                                Text(day.formatted(.dateTime.day()))
                                    .bold(isSelected)
                            }
                            .frame(width: 28, height: 35)
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                
                Button {
                    selectedDate.addTimeInterval(86400*7)
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title)
                }
                .buttonStyle(.automatic)
                .fontWeight(.semibold)
                .padding(.bottom, 7)
            }
            .padding(.top, 12)
        }
        .frame(height: 105)
    }
    
}

