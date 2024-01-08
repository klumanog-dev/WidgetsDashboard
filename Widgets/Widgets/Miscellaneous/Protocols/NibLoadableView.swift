//
//  NibLoadableView.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 08/01/2024.
//

import UIKit

protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
