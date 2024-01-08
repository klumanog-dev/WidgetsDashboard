//
//  WidgetItem.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 05/01/2024.
//

import Foundation
import ObjectMapper

struct WidgetItem: Mappable {
    var style: WidgetType?
    var imageUrl: String?
    var title: String?
    
    // MARK: - Mapping -

    init?(map: Map) { }

    mutating func mapping(map: Map) {
                
        var styleString: String?
        styleString <- map["style"]
        
        if let styleString = styleString, 
            let styleType =  WidgetType(rawValue: styleString) {
            
            self.style = styleType
        }
        
        title <- map["title"]
        imageUrl <- map["image_url"]
    }
}
