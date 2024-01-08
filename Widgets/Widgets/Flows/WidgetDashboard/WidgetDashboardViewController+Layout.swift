//
//  WidgetDashboardViewController+Helpers.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 07/01/2024.
//

import Foundation
import UIKit

extension WidgetDashboardViewController {
        
    // MARK: - Create Layout -
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        var totalHeightInGroups: CGFloat = 0
        var collectionLayoutGroups: [NSCollectionLayoutGroup] = []
        let widgetGroups = viewModel.getWidgetGroups()
        
        for group in widgetGroups {
            if let widgetGroup = createLayoutGroup(widgetGroup: group), let layoutType = group.layoutType {
                let totalHeight = viewModel.getTotalHeightOrWidthInGroup(
                    from: group,
                    layoutType: layoutType,
                    isTotalHeight: true
                )
                totalHeightInGroups += totalHeight
                collectionLayoutGroups.append(widgetGroup)
            }
        }
        
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(totalHeightInGroups)
        )
        
        let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutSize, subitems: collectionLayoutGroups)
        
        let section = NSCollectionLayoutSection(group: containerGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    // MARK: - Create Item -
    
    func createItem(widget: WidgetItem) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(widget.style?.size.width ?? 0),
            heightDimension: .absolute(widget.style?.size.height ?? 0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: PADDING7, leading: PADDING7, bottom: PADDING7, trailing: PADDING7)
        
        return item
    }
    
    // MARK: - Create Layout Group -
    
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
            widthDimension: .absolute(totalWidthInGroup),
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
