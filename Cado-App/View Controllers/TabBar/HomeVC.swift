//
//  HomeVC.swift
//  Cado-App
//
//  Created by Saim on 26/09/2023.
//

import UIKit

class HomeVC: UIViewController {
    static let storyboardIdentifier = "homeVC"
    static let tabbarIndex = 0
    
    typealias Datasource = UICollectionViewDiffableDataSource<Int, SectionItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, SectionItem>
    
    @IBOutlet var homeCollectionView: UICollectionView!
    
    private let productManager = ProductManager()
    private let searchController = UISearchController()
    
    private var datasource: Datasource!
    private var sectionList: [Section] = []
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Home"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadHomePageData()
        
        configureDatasource()
        applySnapshot()
        configureLayout()
    }
    
    func loadHomePageData() {
        let json = CADOAppData.getFakeData()
        let data = json.data(using: .utf8)!
        
        sectionList = try! JSONDecoder().decode([Section].self, from: data)
    }
    
    func configureDatasource() {
        datasource = Datasource(collectionView: homeCollectionView, cellProvider: { collectionView, indexPath, item in
            let section = self.sectionList[indexPath.section].type
            
            switch section {
            case .bigBanner:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BigBannerCell.identifier, for: indexPath) as! BigBannerCell
                let item = item as! BannerItem
                
                cell.configure(imageURL: item.imageUrl, title: item.title)
                
                return cell
            case .smallBanner:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallBannerCell.identifier, for: indexPath) as! SmallBannerCell
                let item = item as! BannerItem
                
                cell.configure(imageURL: item.imageUrl, title: item.title)
                
                return cell
            case .scrollable:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrollableCell.identifier, for: indexPath) as! ScrollableCell
                
                let item = item as! ProductItem
                
                var productList: [Product] = []
                for productId in item.productIdList {
                    let product = self.productManager.get(byId: productId)!
                    productList.append(product)
                }
                
                cell.configure(productList: productList, parent: self)
                
                return cell
            }
        })
        
        
        datasource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let section = self.sectionList[indexPath.section]
            
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
                
                header.configure(mainTitle: section.title!)
                
                return header
            default:
                return UICollectionReusableView()
            }
        }
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        
        let sectionIdentifierList = Array(0..<sectionList.count)
        snapshot.appendSections(sectionIdentifierList)
        
        for sectionIndex in sectionIdentifierList {
            snapshot.appendItems(sectionList[sectionIndex].items, toSection: sectionIndex)
        }
        
        datasource.apply(snapshot)
    }
    
    func configureLayout() {
        homeCollectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            let sectionType = self.sectionList[sectionIndex].type
            
            switch sectionType {
            case .bigBanner:
                return self.getBigBannerSection()
            case .smallBanner:
                return self.getSmallBannerSection()
            case .scrollable:
                return self.getScrollableSection()
            }
        }
        
        homeCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func getBigBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 5.0, bottom: 0.0, trailing: 5.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 10.0, trailing: 0.0)
        return section
    }
    
    
    func getSmallBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 0.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [getSupplementaryHeaderItem()]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 10.0, trailing: 0.0)
        
        return section
    }
    
    func getScrollableSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [getSupplementaryHeaderItem()]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 10.0, trailing: 0.0)
        return section
    }
    
    func getSupplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerElement: NSCollectionLayoutBoundarySupplementaryItem = .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.15)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        return headerElement
    }
}
