//
//  ContentView.swift
//  salad
//
//  Created by Liu, Yao Wen on 10/1/25.
//

import SwiftUI

struct ContentView: View {
    
    //need dynamic input
    let events: [LocationEvent] = [
        LocationEvent(
            title: "Find My",
            subtitle: "location accessed",
            time: "12:11 PM",
            deviceType: "Web",
            location: "Gainesville, FL",
            severity: .high
        ),
        LocationEvent(
            title: "Find My",
            subtitle: "location accessed",
            time: "12:11 PM",
            deviceType: "Mobile",
            location: "Gainesville, FL",
            severity: .medium
        )
    ]
    //
    var body: some View {
        ZStack{
            Color(hex:"#D9D9D9")
            
            VStack {
                TopBarView()
                TabsView()
                MonitoringCard()
                StatusBar()
                HStack{
                    Text("Recent Activity")
                    Spacer()
                }.padding(.top,15)
                
                VStack(spacing: 12){
                    ForEach(events){
                        event in LocationEventCard(event: event)
                    }
                }
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            
        }

    }
}
struct TopBarView: View {
    var body: some View {
        HStack{
            Text("Salads")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(Color(hex: "0429FD"))
            Spacer()
            Image("bell_icon")
                .resizable()
                .frame(width:50, height:50)
            
        }
    }
}
struct TabsView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Monitor")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(20)

            Text("Setting")
                .fontWeight(.regular)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(20)
        }
        .frame(height: 40)
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}
struct MonitoringCard: View {
    @State private var isMonitoringOn: Bool = true
    var body: some View {
        HStack {
            // LEFT SIDE (stack of two rows)
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "shield.fill")
                        .foregroundColor(.green)
                    Text("Location monitoring Active")
                        .font(.subheadline)
                }
                
                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                    Text("Location Access Today")
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            // RIGHT SIDE (toggle switch)
            Toggle("", isOn: $isMonitoringOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: .black)) // customize tint
        }
        .padding()
    }
}
struct RecentActivity: View {
    var body: some View {
        HStack{
            Text("Moitor")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.blue)
            Spacer()
            Text("Setting")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.blue)
            
        }
    }
}
struct StatusBar: View {
    var body: some View {
        HStack(spacing: 16) {
            // Left block: High Risk Today
            VStack {
                Text("4")
                    .font(.title)
                    .foregroundColor(.red)
                    .bold()
                Text("High Risk Today")
                    .font(.subheadline)
                    .foregroundColor(.brown)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 2) // blue border to highlight
            )

            // Right block: Total Access Today
            VStack {
                Text("11")
                    .font(.title)
                    .foregroundColor(.blue)
                    .bold()
                Text("Total Access Today")
                    .font(.subheadline)
                    .foregroundColor(.brown)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
    }
}
struct other: View {
    var body: some View {
        HStack{
            Text("Moitor")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.blue)
            Spacer()
            Text("Setting")
                .font(.system(size: 30))
                .bold()
                .foregroundColor(.blue)
            
        }
    }
}

#Preview {
    ContentView()
}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255,
                (int >> 8) * 17,
                (int >> 4 & 0xF) * 17,
                (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255,
                int >> 16,
                int >> 8 & 0xFF,
                int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (
                int >> 24,
                int >> 16 & 0xFF,
                int >> 8 & 0xFF,
                int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


/////
///move to  different file?
///
struct LocationEvent: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let time: String
    let deviceType: String
    let location: String
    let severity: Severity
}

enum Severity {
    case high, medium, low

    var label: String {
        switch self {
        case .high: return "High"
        case .medium: return "Medium"
        case .low: return "Low"
        }
    }

    var color: Color {
        switch self {
        case .high: return .red
        case .medium: return .yellow
        case .low: return .blue
        }
    }
}

struct LocationEventCard: View {
    let event: LocationEvent
    
    var body: some View {
        HStack {
            // LEFT SIDE
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(event.severity.color)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(event.title)
                            .bold()
                        Text(event.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                HStack(spacing: 16) {
                    Label(event.time, systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Label(event.deviceType, systemImage: "globe")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            // RIGHT SIDE
                        VStack(alignment: .trailing, spacing: 6) {
                            Text(event.severity.label)
                                .font(.caption)
                                .bold()
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(hex:"#D9D9D9"))
                                .cornerRadius(8)
                            
                            HStack {
                                Image(systemName: "location")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(event.location)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
