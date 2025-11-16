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
    @State private var showAlert: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    @Query(sort: \DayFit.date) var dayFits: [DayFit]
    @Environment(\.modelContext) private var modelContext
    
    private var dayFit: DayFit? {
        dayFits.first { Calendar.gregorian.isDate(selectedDate, equalTo: $0.date, toGranularity: .day) }
    }

    private var dayFitIsEmpty: Bool { dayFit == nil }
    
    var body: some View {
        
        NavigationStack{
            ZStack {
                

                InteractiveView
                
                if dayFitIsEmpty {
                    ButtonWithLabelView
                }
                
                if dayFitIsEmpty || !hideCalendar {
                    VStack {
                        WeekCalendarView(selectedDate: $selectedDate)
                        Spacer()
                    }
                    .padding()
                }
            }
            .navigationTitle(selectedDate.formatted(.dateTime.month(.wide)) + " " + selectedDate.formatted(.dateTime.year()))
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showSheet){
                AddDayFitView(date: selectedDate)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Look"),
                    message: Text("Are you sure you want to delete this look? Deleted looks cannot be restored."),
                    primaryButton: .default(
                        Text("Cancel")
                    ),
                    secondaryButton: .destructive(
                        Text("Delete"),
                        action: deleteDayFit
                    )
                )
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    DatePicker(selection: $selectedDate, displayedComponents: .date) {}
                }
                
                if !dayFitIsEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Delete current look", systemImage: "eraser.line.dashed.fill") {
                            showAlert.toggle()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Hide Calendar", systemImage: hideCalendar ? "calendar.badge.plus" : "calendar.badge.minus") {
                            hideCalendar.toggle()
                        }
                    }
                }
            }
            .background {
                BackgroundView
            }
        }
    }
    
    private func deleteDayFit() {
        guard let fit = dayFit else { return }
        modelContext.delete(fit)
    }
    
    private var BackgroundView: some View {
        VStack {
            if let imageData = dayFit?.image, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            }
        }
        .ignoresSafeArea(.all)
        .frame(minWidth: 0)
    }
    
    private var InteractiveView: some View {
        HStack {
            VStack {
                HStack {
                    Spacer()
                }
                Spacer()
            }
            .background(.black.opacity(0.01))
            .onTapGesture(count: 1) {
                selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
            }
            
            VStack {
                HStack {
                    Spacer()
                }
                Spacer()
            }
            .background(.black.opacity(0.01))
            .onTapGesture(count: 1) {
                selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
            }
        }
    }
    
    private var ButtonWithLabelView: some View {
        VStack {
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
}
    

#Preview {
    MyWeekView()
}


struct WeekCalendarView: View {
    @Binding var selectedDate: Date
    
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    var weekdays: [Date] {
            getWeekDates(for: selectedDate, using: .gregorian)
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
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
                
                LazyHGrid(rows: rows){
                    ForEach(weekdays, id: \.self) { day in
                        var isSelected: Bool {
                            Calendar.current.isDate(selectedDate, equalTo: day, toGranularity: .day)
                        }
                        
                        Text(day.formatted(.dateTime.weekday(.abbreviated)))
                            .bold(isSelected)
                        
                        Button {
                            selectedDate = day
                        } label: {
                            ZStack{
                                if isSelected {
                                    Circle()
                                        .foregroundStyle(.accent)
                                }
                                Text(day.formatted(.dateTime.day()))
                                    .bold(isSelected)
                            }
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
            }
            .padding()
        }
        .frame(height: 105)
    }
    
}
