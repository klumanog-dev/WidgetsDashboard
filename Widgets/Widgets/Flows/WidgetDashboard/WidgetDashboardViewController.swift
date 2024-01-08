//
//  WidgetDashboardViewController.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 05/01/2024.
//

import UIKit
import Combine

class WidgetDashboardViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView?
    
    var viewModel: WidgetDashboardViewModel
    var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: WidgetDashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
      
        performInitialSetup()
    }
    
    override func setupNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

// MARK: - Setup -

extension WidgetDashboardViewController{
    
    private func performInitialSetup() {
        viewModel.fetchDashboardData()
        setupBinders()
        setupCollectionView()
    }
    
    private func setupBinders() {
        viewModel.$dataSource.sink { [weak self] data in
            guard let self = self, !data.isEmpty else {
                return
            }
            self.collectionView?.setCollectionViewLayout(createLayout(), animated: true)
            self.collectionView?.reloadData()
        }.store(in: &cancellables)
    }
    
    private func setupCollectionView() {
        collectionView?.register(cell: WidgetCollectionViewCell.self)
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource -

extension WidgetDashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getTotalWidgetItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.row < viewModel.getTotalWidgetItemsCount(),
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WidgetCollectionViewCell.reusableIdentifier, for: indexPath) as? WidgetCollectionViewCell
        else {
            return UICollectionViewCell()
        }
     
        if let model = viewModel.getItem(at: indexPath.row) {
            cell.configure(model: model)
        }
        return cell
    }
    
}
