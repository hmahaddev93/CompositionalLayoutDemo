//
//  ViewController.swift
//  CompositionalLayoutDemo
//
//  Created by Khateeb H. on 7/13/22.
//

import UIKit

class EmptyCell: UICollectionViewCell {
    
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(EmptyCell.self, forCellWithReuseIdentifier: "EmptyCell")
        collectionView.collectionViewLayout = createLayoutScrollable()//createLayoutDiffSection()
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
        //1
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        //2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),heightDimension: .absolute(44))
        //3
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitem: item, count: 2)
        group.interItemSpacing = .fixed(CGFloat(10))

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func createLayout2() -> UICollectionViewLayout {
        let verticalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(0.3))
        let verticalItem = NSCollectionLayoutItem(layoutSize: verticalItemSize)

        let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                       heightDimension: .fractionalHeight(1))
        let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize,
                                                             subitem: verticalItem, count: 3)
        verticalGroup.interItemSpacing = .fixed(8)
        // ---------------------------------------------------------------------------------
        let horizontalItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                      heightDimension: .fractionalHeight(1))
        let horizontalItem = NSCollectionLayoutItem(layoutSize: horizontalItemSize)
        let horizontalItemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                      heightDimension: .fractionalHeight(1))
        let horizontalItem2 = NSCollectionLayoutItem(layoutSize: horizontalItemSize2)

        let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                    heightDimension: .fractionalHeight(0.3))
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize,
                                                             subitems: [horizontalItem, horizontalItem2, horizontalItem])
        let horizontalGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize,
                                                                  subitems: [horizontalItem2, horizontalItem, horizontalItem])
        let horizontalGroup3 = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize,
                                                                  subitems: [horizontalItem, horizontalItem, horizontalItem2])
        horizontalGroup.interItemSpacing = .fixed(8)
        horizontalGroup2.interItemSpacing = .fixed(8)
        horizontalGroup3.interItemSpacing = .fixed(8)
        // ---------------------------------------------------------------------------------
        let horizontalsGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75),
                                                       heightDimension: .fractionalHeight(1))
        let horizontalsGroup = NSCollectionLayoutGroup.vertical(layoutSize: horizontalsGroupSize,
                                                             subitems: [horizontalGroup, horizontalGroup2, horizontalGroup3])
        horizontalsGroup.interItemSpacing = .flexible(0)
        // ---------------------------------------------------------------------------------
        let finalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(0.5))
        let finalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: finalGroupSize,
                                                            subitems: [horizontalsGroup, verticalGroup])

        let section = NSCollectionLayoutSection(group: finalGroup)
        section.interGroupSpacing = 8

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func createLayoutDiffSection() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var columns = 1
            switch sectionIndex{
            case 1:
                columns = 3
            case 2:
                columns = 5
            default:
                columns = 1
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            let groupHeight = columns == 1 ?
                NSCollectionLayoutDimension.absolute(44) :
                NSCollectionLayoutDimension.fractionalWidth(0.2)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            return section
        }
        return layout
    }
    
    func createLayoutScrollable() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let item1 = NSCollectionLayoutItem(layoutSize:
                                                NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                                       heightDimension: .fractionalHeight(1.0)))
            let item2 = NSCollectionLayoutItem(layoutSize:
                                                NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                       heightDimension: .absolute(120)))
            let item3 = NSCollectionLayoutItem(layoutSize:
                                                NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                       heightDimension: .absolute(80)))

            item1.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            item2.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            item3.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            let group2 = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                   heightDimension: .fractionalHeight(1.0)),
                subitems: [item2, item3])

            let group1 = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                   heightDimension: .absolute(200)),
                subitems: [item1, group2])
            let section = NSCollectionLayoutSection(group: group1)
            section.orthogonalScrollingBehavior = .continuous

            return section
        }
        return layout
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCell", for: indexPath) as? EmptyCell {
            cell.backgroundColor = .blue
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
