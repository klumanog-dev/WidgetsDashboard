//
//  DashboardService.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 07/01/2024.
//

import Foundation
import ObjectMapper

protocol DashboardServiceProtocol {
    func fetchDashboardData() -> [WidgetGroup]
}

final class DashboardService {
    // Add any parameters needed for this service
    init() { }
}

extension DashboardService: DashboardServiceProtocol {
    
    func fetchDashboardData() -> [WidgetGroup] {
        guard let path = Bundle.main.path(forResource: "widgets-dashboard", ofType: "json") else {
            return []
        }
        
        var widgetGroups: [WidgetGroup] = []
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            
            if let jsonData = jsonResult as? [[String: Any]] {
                let groups: [WidgetGroup] = Mapper<WidgetGroup>().mapArray(JSONArray: jsonData)
                widgetGroups = groups
            }
        } catch {
            return []
        }
        
        return widgetGroups
    }

}
