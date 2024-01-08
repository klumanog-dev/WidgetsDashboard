//
//  ReusableView.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 08/01/2024.
//

import UIKit

protocol ReusableView: AnyObject {
    static var reusableIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}
