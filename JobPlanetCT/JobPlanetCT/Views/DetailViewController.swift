//
//  DetailViewController.swift
//  JobPlanetCT
//
//  Created by yoon on 2021/05/28.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    var item: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLayerView()
    }

    func setView() {
        if let receiveData = item, let imageUrl = receiveData.logoPath,
            let compnayName = receiveData.name, let rate = receiveData.rateTotalAvg,
            let industry = receiveData.industryName, let reviewCountDesc = receiveData.simpleDesc
        {
            self.logoImageView.kf.setImage(with: URL(string: imageUrl),
                                           placeholder: UIImage(named: "placeholderImage"),
                                           options: [.transition(.fade(3))])
            self.industryNameLabel.text = industry
            self.rateTotalAvgLabel.text = String(rate)
            self.title = compnayName
            self.companyLabel.text = compnayName
            
            if !reviewCountDesc.isEmpty {
                self.reviewCountLabel.text = reviewCountDesc
            }else {
                self.reviewCountLabel.text = "기업 리뷰가 없습니다."
            }
        }
    }
    
    func setLayerView(){
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.black.cgColor
        
        companyBackgroundView.layer.cornerRadius = 5
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBOutlet weak var companyBackgroundView: UIView!
    @IBOutlet weak var industryNameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var rateTotalAvgLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    

}
