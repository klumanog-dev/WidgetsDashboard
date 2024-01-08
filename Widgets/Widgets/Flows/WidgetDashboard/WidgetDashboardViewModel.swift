//
//  WidgetDashboardViewModel.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 07/01/2024.
//

import Foundation
import Combine

protocol WidgetDashboardViewModelProtocol {
    func fetchDashboardData()
    func getWidgetGroups() -> [WidgetGroup]
    func getWidgetGroup(at index: Int) -> WidgetGroup?
    func getWidgetItems(from group: WidgetGroup) -> [WidgetItem]
    func getTotalWidgetGroupsCount() -> Int
    func getTotalWidgetItemsCount() -> Int
    func getItemsCount(at index: Int) -> Int
    func getItem(at index: Int) -> WidgetItem?
    func getMaxHeightOrWidthInGroup(from widgetGroup: WidgetGroup?, isMaxHeight: Bool) -> CGFloat
    func getMaxHeightInGroup(at index: Int) -> CGFloat
    func getTotalHeightOrWidthInGroup(from widgetGroup: WidgetGroup?, layoutType: WidgetLayoutType, isTotalHeight: Bool) -> CGFloat
}

class WidgetDashboardViewModel {
    
    @Published var dataSource: [WidgetGroup] = []
    private var allItems: [WidgetItem] = []
}

extension WidgetDashboardViewModel: WidgetDashboardViewModelProtocol {
        
    func fetchDashboardData() {
        dataSource = DashboardService().fetchDashboardData()
        
        dataSource.forEach {
            allItems += $0.widgets
        }
    }
    
    // MARK: - Get Data -
    
    func getWidgetGroups() -> [WidgetGroup] {
        return dataSource
    }
    
    func getWidgetGroup(at index: Int) -> WidgetGroup? {
        guard index <= dataSource.count else {
            return nil
        }
        return dataSource[index]
    }
    
    func getWidgetItems(from group: WidgetGroup) -> [WidgetItem] {
        return group.widgets
    }
    
    // MARK: - Items Count -
    
    func getTotalWidgetGroupsCount() -> Int {
        return dataSource.count
    }
    
    func getTotalWidgetItemsCount() -> Int {
        var totalCount = 0
        for group in dataSource {
            totalCount += group.widgets.count
        }
        return totalCount
    }
    
    func getItemsCount(at index: Int) -> Int {
        guard let widgetGroup = getWidgetGroup(at: index), !widgetGroup.widgets.isEmpty else {
            return 0
        }
        
        return widgetGroup.widgets.count
    }
    
    func getItem(at index: Int) -> WidgetItem? {
        guard index <= allItems.count else {
            return nil
        }
        
        return allItems[index]
    }
    
    // MARK: - Max Height -
    
    func getMaxHeightOrWidthInGroup(from widgetGroup: WidgetGroup?, isMaxHeight: Bool) -> CGFloat {
        guard let widgetGroup = widgetGroup, !widgetGroup.widgets.isEmpty else {
            return 0
        }
        
        let allHeights = widgetGroup.widgets.compactMap { isMaxHeight ? $0.style?.size.height : $0.style?.size.width }
        return allHeights.max() ?? 0
    }
    
    func getMaxHeightInGroup(at index: Int) -> CGFloat {
        guard let widgetGroup = getWidgetGroup(at: index), !widgetGroup.widgets.isEmpty else {
            return 0
        }
        
        let allHeights = widgetGroup.widgets.compactMap { $0.style?.size.height }
        return allHeights.max() ?? 0
    }
    
    func getTotalHeightOrWidthInGroup(from widgetGroup: WidgetGroup?, layoutType: WidgetLayoutType, isTotalHeight: Bool) -> CGFloat {
        guard let widgetGroup = widgetGroup, !widgetGroup.widgets.isEmpty else {
            return 0
        }
        
        if layoutType == .horizontal, isTotalHeight {
            return getMaxHeightOrWidthInGroup(from: widgetGroup, isMaxHeight: true)
        }
                                              
        let allHeights = widgetGroup.widgets.compactMap { isTotalHeight ? $0.style?.size.height : $0.style?.size.width}
        return allHeights.reduce(0, +)
    }
}
