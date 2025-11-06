//
//  PlannerView.swift
//  Outfitify
//
//  Created by Leonardo Avila Molina on 05/11/25.
//

import SwiftUI

struct MyWeek: View {
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
    MyWeek()
}


struct WeekCalendarView: View {
    @State private var weekdays = currentWeekDates(using: .current)
    @Binding var selectedDate: Date
    
    var body: some View {
        HStack(spacing: 20){
            ForEach(weekdays, id: \.self) { day in
                Button {
                    selectedDate = day
                } label: {
                    VStack{
                        Text(day.formatted(.dateTime.weekday(.abbreviated)))
                            .padding(.bottom, 4)
                        ZStack{
                            if Calendar.current.isDate(selectedDate, equalTo: day, toGranularity: .day) {
                                Circle()
                                    .foregroundStyle(.accent)
                                    .scaledToFit()
                            }
                            Text(day.formatted(.dateTime.day()))
                        }
                        .frame(width: 35, height: 35)
                        
                    }
                }
                .buttonStyle(.plain)
                
            }
        }
    }
}
