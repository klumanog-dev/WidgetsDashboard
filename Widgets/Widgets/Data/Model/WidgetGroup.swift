//
//  WidgetGroup.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 07/01/2024.
//

import Foundation
import ObjectMapper

struct WidgetGroup: Mappable {
    
    var layoutType: WidgetLayoutType?
    var widgets: [WidgetItem] = []
    
    // MARK: - Mapping -

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        var layoutTypeString: String?
        layoutTypeString <- map["layout_type"]
        
        if let layoutTypeString = layoutTypeString, 
            let layoutType =  WidgetLayoutType(rawValue: layoutTypeString) {
            
            self.layoutType = layoutType
        }
        
        widgets <- map["items"]
    }
}
