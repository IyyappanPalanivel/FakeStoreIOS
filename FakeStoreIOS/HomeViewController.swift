//
//  HomeViewController.swift
//  FakeStoreIOS
//
//  Created by Apple on 22/09/22.
//

import UIKit
import Alamofire
import Foundation


class Product: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productPrice: UILabel!
}

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var reuseIdentifier:String = "Product"
    
    var productList: [ProductElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "ProductCell", bundle: Bundle(identifier: "tt.FakeStoreIOS"))
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        getProducts()
    }
    
    func getProducts() {
        
        AF.request("https://fakestoreapi.com/products").responseDecodable(of: ProductResponse.self) { response in
            
            self.productList = response.value!
            //print(self.productList.count)
            self.collectionView.reloadData()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UICollectionViewDelegate{
    
}

extension HomeViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? Product else{
            return UICollectionViewCell()
        }
        
        cell.title.text = productList[indexPath.row].title
        cell.productDesc.text = productList[indexPath.row].description
        cell.productPrice.text = "$" + String(productList[indexPath.row].price)
        
        return cell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 250)
    }
    
}

//Pojo class
// MARK: - ProductElement
struct ProductElement: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case description
        case category, image, rating
    }
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRating { response in
//     if let rating = response.result.value {
//       ...
//     }
//   }

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

typealias ProductResponse = [ProductElement]
