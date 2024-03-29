//
//  UICollectionView+Reusable.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 08/01/2024.
//


import Foundation
import UIKit

extension UICollectionView {
    enum SupplementaryViewKind {
        case header
        case footer

        var rawValue: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UICollectionViewCell>(cell: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellWithReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UICollectionReusableView>(view: T.Type, asSupplementaryViewKind kind: SupplementaryViewKind) where T: ReusableView {
        register(T.self, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reusableIdentifier)
    }

    func register<T: UICollectionReusableView>(view: T.Type, asSupplementaryViewKind kind: SupplementaryViewKind) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reusableIdentifier)
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reusableIdentifier)")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: SupplementaryViewKind, forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.reusableIdentifier)")
        }
        return view
    }
}
