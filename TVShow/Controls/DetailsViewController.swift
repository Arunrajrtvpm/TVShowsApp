//
//  DetailsViewController.swift
//  TVShow
//
//  Created by Arunraj on 04/08/21.
//

import UIKit
import Cosmos
import CoreData


class DetailsViewController: UIViewController {

    var details: ShowModel!
    
    var showId: Int!
    
    var mainStack: UIStackView!
    var showImage: UIImageView!
    var showDescription: UILabel!
    var showDetailsVStack: UIStackView!
    var showSeason: UILabel!
    var seasonsStack: UIStackView!
   
    var showRating: CosmosView!
//    Status
//    Permiered Date
//    Run Time
//    Official Site
//    Url
//    Rating

    var onRatingComplete: ((String)->())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        if let id = showId{
            getDetails(with: id)
        }
        
    }
    
    func setUpViews() {
        
        let(_, stackView) = bindStackableView(in: self.view)
        
        self.mainStack = stackView
        self.mainStack.alignment = .fill
        
        let deviderLine1: UIView = {
            let view = UIView(frame: .zero)
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        let deviderLine2: UIView = {
            let view = UIView(frame: .zero)
            view.backgroundColor = .white
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        showImage = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        showDescription = {
            let field = UILabel(frame: .zero)
            field.translatesAutoresizingMaskIntoConstraints = false
            field.font = UIFont.systemFont(ofSize: 25.0)
            field.textColor = .white
            field.numberOfLines = 0
            return field
        }()
        
        showSeason = {
            let field = UILabel(frame: .zero)
            field.translatesAutoresizingMaskIntoConstraints = false
            field.font = UIFont.systemFont(ofSize: 20.0)
            field.textColor = .white
            field.text = "Season"
            return field
        }()
        
        seasonsStack = {
            let stackView = UIStackView(frame: .zero)
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        } ()
        
         showRating = {
            let cosmoView = CosmosView()
            cosmoView.settings.totalStars = 5
            cosmoView.settings.starSize = 40
            cosmoView.settings.starMargin = 5
            cosmoView.settings.fillMode = .full
            cosmoView.settings.textMargin = 10
            cosmoView.settings.textColor = UIColor.yellow
            cosmoView.didTouchCosmos = {[weak self] s in
                guard let `self` = self else {return}
                self.onRating(val: s)
                
            }
                
            cosmoView.settings.textFont = UIFont.systemFont(ofSize: 15, weight: .bold)
            cosmoView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
            return cosmoView
            
        }()
        
        
        showDetailsVStack = self.getStackView()
        
        
        self.mainStack.addArrangedSubview(showImage)
        self.mainStack.addArrangedSubview(showDescription)
        self.mainStack.addArrangedSubview(deviderLine1)
        self.mainStack.addArrangedSubview(showDetailsVStack)
        self.mainStack.addArrangedSubview(deviderLine2)
        self.mainStack.addArrangedSubview(showSeason)
//        self.mainStack.addArrangedSubview(deviderLine1)
        self.mainStack.addArrangedSubview(showRating)
        self.mainStack.addArrangedSubview(seasonsStack)
        
        
        
        NSLayoutConstraint.activate([
            deviderLine1.heightAnchor.constraint(equalToConstant: 3.0),
            deviderLine1.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 20),
            deviderLine2.heightAnchor.constraint(equalToConstant: 3.0),
            deviderLine2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 20),

        ])
    }
    
    
    func bindStackableView(in view: UIView) -> (scrollView: UIScrollView, stackView: UIStackView) {
        
        let scrollView = self.getScrollView()
        let stackView = self.getStackView()
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        
        let heightAnchor = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1)
        heightAnchor.priority = UILayoutPriority.defaultLow
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            heightAnchor
        ])
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 25, leading: 25, bottom: 25, trailing: 25)
        
        return (scrollView: scrollView, stackView: stackView)
    }
    
    private func getStackView() -> UIStackView {
        
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }
    
    private func getScrollView() -> UIScrollView {
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        
    }
    
    private func getStackViewForKeyValue(key: String, Value: String) -> UIStackView {
        
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let Key = UILabel(frame: .zero)
        Key.translatesAutoresizingMaskIntoConstraints = false
        Key.font = UIFont.systemFont(ofSize: 18.0)
        Key.textColor = .white
        Key.widthAnchor.constraint(equalToConstant: 150).isActive = true
        Key.text = key
        
        let colon = UILabel(frame: .zero)
        colon.translatesAutoresizingMaskIntoConstraints = false
        colon.font = UIFont.systemFont(ofSize: 18.0)
        colon.textColor = .white
        colon.text = ":"
        
        let value = UILabel(frame: .zero)
        value.textColor = .white
        value.textAlignment = .left
        value.font = UIFont.systemFont(ofSize: 18.0)
        value.translatesAutoresizingMaskIntoConstraints = false
        value.text = Value
        
        stackView.addArrangedSubview(Key)
        stackView.addArrangedSubview(colon)
        stackView.addArrangedSubview(value)
        
        
        
        
        return stackView
        
    }
    
    func onRating(val: Double) {
        
        self.save(id: self.showId.description, value: val.description)
        self.navigationController?.popViewController(animated: true)

        self.onRatingComplete?(val.description)
        
    }
    
    func getRating()  {
        
        self.fetchData { response in
            switch response {
            
            case .success(let data):
                let new = data as? [ShowRating]
                if let rate = new?.first(where: {$0.id == showId.description}){
                    
                    showRating.rating = Double(rate.rating ?? "0.0") ?? 0.0
                }
                
                
            case .failure(_):
                break
            }
        }
        
    }
    
    
    
    func getDetails(with id: Int)  {
       
        ShowService.shared.getShowDetails(input: id) {[weak self] response in
          
            guard let `self` = self else {return}
            
            switch response {
            
            case .success(let data): 
                self.details = data
                self.setDetailsInView()
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func setDetailsInView() {
        
        self.title = self.details.name
        
        self.showImage.image = UIImage(named: "placeholder")
        self.showImage.downloadImageFrom(link: self.details.image.medium, contentMode: UIView.ContentMode.scaleAspectFit)
        
        let string = self.details.summary
        let str = string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        
        self.showDescription.text = str
                
        showDetailsVStack.addArrangedSubview(getStackViewForKeyValue(key:"Status" , Value: details.status))
        
        showDetailsVStack.addArrangedSubview(getStackViewForKeyValue(key:"Permiered Date" , Value: details.premiered))
        
        showDetailsVStack.addArrangedSubview(getStackViewForKeyValue(key:"Run Time" , Value: details.runtime?.description ?? ""))
        
        showDetailsVStack.addArrangedSubview(getStackViewForKeyValue(key:"Official Site" , Value: details.officialSite?.description ?? ""))
        
        showDetailsVStack.addArrangedSubview(getStackViewForKeyValue(key:"Url" , Value: details.url))
        
        showDetailsVStack.addArrangedSubview(getStackViewForKeyValue(key:"Rating" , Value: details.rating?.average?.description ?? "0.0"))
        
        
        getRating()
        
    }
    

}


//MARK:- Core Data actions
extension DetailsViewController {

    private func fetchData(completionHandler: (Result<[NSManagedObject], Error>)->()) {

          //1
          guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }

          let managedContext =
            appDelegate.persistentContainer.viewContext

          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ShowRating")
        
        //3
        do {
            let value = try managedContext.fetch(fetchRequest)
            completionHandler(.success(value))
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func save(id: String, value: String) {

        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext

        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "ShowRating",
                                       in: managedContext)!

        let showRating = NSManagedObject(entity: entity,
                                     insertInto: managedContext)

        // 3
        showRating.setValue(id, forKeyPath: "id")
        showRating.setValue(value, forKeyPath: "rating")

        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
