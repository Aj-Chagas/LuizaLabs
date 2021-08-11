//
//  CodeView.swift
//  UI
//
//  Created by Anderson Chagas on 10/08/21.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraint()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraint()
        setupAdditionalConfiguration()
    }
}
