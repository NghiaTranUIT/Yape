//
//  VideoItemsListSectionHeaderVIew.swift
//  Yape
//
//  Created by Igor Savelev on 29/07/2018.
//  Copyright © 2018 Igor Savelev. All rights reserved.
//

import AppKit

final class VideoItemsListSectionHeaderView: NSView {
    private struct Constants {
        static let titleViewSidePadding: CGFloat = 15
    }
    
    var viewModel: VideoItemsListSectionProtocol? {
        didSet {
            self.applyViewModel()
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setupView()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Subviews
    
    private lazy var titleView: NSTextField =  {
        let textField = NSTextField(frame: .zero)
        textField.isEditable = false
        textField.isSelectable = false
        textField.font = NSFont.labelFont(ofSize: 12.0)
        textField.backgroundColor = .clear
        textField.textColor = .labelColor
        textField.isBordered = false
        textField.maximumNumberOfLines = 1
        return textField
    }()
    
    // MARK: Setup view
    
    private func setupView() {
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.headerColor.withAlphaComponent(0.1).cgColor
        
        self.addSubview(self.titleView)
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.titleViewSidePadding),
            self.titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.titleViewSidePadding)
        ])
    }
    
    // MARK: Setup data
    
    private func applyViewModel() {
        guard let viewModel = self.viewModel else {
            self.titleView.stringValue = ""
            return
        }
        self.titleView.stringValue = viewModel.title
    }
}

extension VideoItemsListSectionHeaderView: ReusableSupplementaryView {
    static let supplementaryElementKind: NSCollectionView.SupplementaryElementKind = .sectionHeader
}
