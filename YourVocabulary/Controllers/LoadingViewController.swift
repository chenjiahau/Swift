//
//  LoadingViewController.swift
//  YourVocabulary
//
//  Created by Ivan Chen on 2022/6/27.
//

import UIKit

class LoadingViewController: UIViewController {
    // MARK: UI Properties
    
    private let loadingLabel: UILabel = {
        let label = UIGenerater.makeLabel(withText: "Loading", font: UIFont.systemFont(ofSize: 24), color: .white)
        
        return label
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Helpers
    
    func configureUI() {
        view.backgroundColor = .appMainColor
        
        view.addSubview(loadingLabel)
        loadingLabel.center(inView: view)
    }
}
