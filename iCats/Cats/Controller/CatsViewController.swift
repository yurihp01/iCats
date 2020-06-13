//
//  CatsViewController.swift
//  iCats
//
//  Created by Yuri on 12/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class CatsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: CatsViewModel?
    weak var coordinator: CatsCoordinator?
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let width = UIScreen.main.bounds.width / 2
        let height = UIScreen.main.bounds.height / 3
        layout.itemSize = CGSize(width: width, height: height)

        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        return layout
    }()

    deinit {
        coordinator?.childDidFinish(coordinator)
        print("CatsViewController - DEINIT")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iCats"
        configureCollectionView()
        getCats()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout
    }
    
    private func getCats() {
        guard let viewModel = viewModel else { return }
        viewModel.getCatsFromAPI(onComplete: { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.collectionView.reloadData()
                    self.collectionView.collectionViewLayout.invalidateLayout()
                    self.collectionView.layoutSubviews()
                case .failure(let error):
                    let alert = CatsAlert.showAlertDialog(title: "Erro", message: error.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        })
    }
}

extension CatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.catsCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CatsCollectionViewCell, let viewModel = viewModel else { return UICollectionViewCell() }
        
        cell.catImageView.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 20)

        cell.catImageView.kf.setImage(with: viewModel.cats[indexPath.row].url, options: [.transition(.fade(0.2)), .cacheOriginalImage, .fromMemoryCacheOrRefresh, .onFailureImage(#imageLiteral(resourceName: "error")), .processor(processor)])
        
        return cell
    }
    
}
