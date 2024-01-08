//
//  WidgetCollectionViewCell.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 05/01/2024.
//

import UIKit

class WidgetCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet weak var contentContainerView: UIView?
    @IBOutlet weak var contentImageView: UIImageView?
    @IBOutlet weak var contentImageViewWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var contentLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView?.image = nil
    }
    
    private func setupUI() {
        [contentContainerView, contentImageView].forEach {
            $0?.layer.cornerRadius = PADDING16
        }
        contentImageView?.contentMode = .scaleAspectFill
    }
    
    // MARK: - Public -
    
    func configure(model: WidgetItem) {
       
        if let style = model.style {
            let size = style.size
            
            let isAdjustableWidth = (style == .squareMini && model.title != nil)
            contentImageViewWidthConstraint?.constant = isAdjustableWidth ? PADDING72 - PADDING16 : size.width
            contentImageView?.frame.size.height = size.height
        }
        contentImageView?.backgroundColor = .grayD9D9D9       
        contentImageView?.setImageFromUrl(model.imageUrl ?? "", placeholder: UIImage())
        contentLabel?.text = model.title
        contentLabel?.isHidden = model.title == nil
    }
}
