//
//  ViewController.swift
//  UIKit Random Photo
//
//  Created by GÜRHAN YUVARLAK on 4.07.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Random Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
    
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        imageView.center = view.center
        
        view.addSubview(button)
        getRandomPhoto()
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: 20, y: view.frame.size.height-150-view.safeAreaInsets.bottom, width: view.frame.size.width-40, height: 55)
    }
    
    @objc func didTapButton(){
        getRandomPhoto()
    }
    
    
    func getRandomPhoto(){
        let url = "https://source.unsplash.com/random/600x600"
        let cache = NSCache<AnyObject, AnyObject>()
        if let imageFromCache = cache.object(forKey: url as AnyObject) as? UIImage{
            imageView.image = imageFromCache
            return
        }
        AF.request(url, method: .get).response { response in
            switch response.result{
                case .failure(let error):
                    print(error)
                case .success(let data):
                    guard let data = data,
                          let image = UIImage(data: data) else {
                        return
                    }
                    cache.setObject(image, forKey: url as AnyObject)
                    self.imageView.image = image
            }
        }
    }


}

