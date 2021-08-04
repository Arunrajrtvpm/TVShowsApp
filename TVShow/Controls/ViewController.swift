//
//  ViewController.swift
//  TVShow
//
//  Created by Arunraj on 04/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var searchBar: UISearchBar!
   
    
    var selectedId : Int?
//    private var showsList: [Int] = [1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2]

    private var showsList: [ShowModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SHOWS"
        setupCollectionView()
        
        loadData(with: 0)
    }
    
    
    func setupCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ShowViewCell.self, forCellWithReuseIdentifier: "ShowViewCell")
        
        collectionView.allowsSelection = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.alwaysBounceVertical = false
        collectionView.bounces = true
        collectionView.showsHorizontalScrollIndicator = true
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView!.collectionViewLayout = layout
        
    }

    func loadData(with id: Int) {
        
        ShowService.shared.getListData(input: id) { response in
            
            switch response {
            
            case .success(let data):
                self.showsList = data
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    

    
    func showAlert(rating: String)  {
        
    
        let alert = UIAlertController(title: "Rating",
                                      message: "You Give a rating of \(rating)",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok",
                                         style: .cancel)
        
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    
}

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowViewCell", for: indexPath)
                as? ShowViewCell
        else { fatalError("Could not find GridCollectionViewCell") }
        
        cell.showName.text = showsList[indexPath.item].name
        cell.showImage.image = UIImage(named: "placeholder")
        cell.showImage.downloadImageFrom(link: showsList[indexPath.item].image.medium, contentMode: UIView.ContentMode.scaleAspectFit)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return showsList.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        return CGSize(width: 100, height: 100)
        return CGSize(width: UIScreen.main.bounds.size.width/2 - 20, height: UIScreen.main.bounds.size.width/2 + 20 );
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.selectedId = showsList[indexPath.item].id
         performSegue(withIdentifier: "showDetails", sender: self)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let destinationVC = segue.destination as! DetailsViewController

        destinationVC.showId = self.selectedId
        destinationVC.onRatingComplete = { val in
            
            self.showAlert(rating: val)
        }
    }
    

}
