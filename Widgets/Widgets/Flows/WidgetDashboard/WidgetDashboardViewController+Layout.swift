//
//  WidgetDashboardViewController+Helpers.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 07/01/2024.
//

import Foundation
import UIKit

extension WidgetDashboardViewController {
    
    func createItem(widget: WidgetItem) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(widget.style?.size.width ?? 0),
            heightDimension: .absolute(widget.style?.size.height ?? 0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: PADDING7, leading: PADDING7, bottom: PADDING7, trailing: PADDING7)
        
        return item
    }
    
    func createLayoutGroup(widgetGroup: WidgetGroup) -> NSCollectionLayoutGroup? {
        guard let layoutType = widgetGroup.layoutType else {
            return nil
        }
        let totalHeightInGroup = viewModel.getTotalHeightOrWidthInGroup(from: widgetGroup, layoutType: layoutType, isTotalHeight: true)
        let maxHeightInGroup = viewModel.getMaxHeightOrWidthInGroup(from: widgetGroup, isMaxHeight: true)
        let totalWidthInGroup = viewModel.getTotalHeightOrWidthInGroup(from: widgetGroup, layoutType: layoutType, isTotalHeight: false)
       
        let widgets = widgetGroup.widgets
          
        // Items Creation
        var items: [NSCollectionLayoutItem] = []
        
        for widget in widgets {
            let item = createItem(widget: widget)
            items.append(item)
        }
        
        // Group Layout Creation
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(totalWidthInGroup), // .fractionalWidth(1),
            heightDimension: .absolute(totalHeightInGroup)
        )
        
        if widgetGroup.layoutType == .vertical {
            return NSCollectionLayoutGroup.vertical(
                layoutSize: layoutSize,
                subitems: items
            )
        } else {
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: layoutSize,
                subitems: items
            )
        }
        
    }
}
