//
//  Cells.swift
//  JobPlanetCT
//
//  Created by yoon on 2021/05/26.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class CompanyCell: UITableViewCell {

    override func prepareForReuse() {
        interviewQuestionLabel.text = nil
        salaryAvgLabel.text = nil
        reviewSummaryLabel.text = nil
        companyLabel.text = nil
        rateTotalAvgLabel.text = nil
    }

    func setView(_ data: Item) {
        if let imageUrl = data.logoPath, let name = data.name,
            let rate = data.rateTotalAvg, let industry = data.industryName,
            let review_summary = data.reviewSummary, let salary_avg = data.salaryAvg,
            let interview_question = data.interviewQuestion
        {
            logoImageView.kf.setImage(with: URL(string: imageUrl),
                                      placeholder: UIImage(named: "placeholderImage"),
                                      options: [.transition(.fade(0.2))]
            )
            self.companyLabel.text = name
            self.rateTotalAvgLabel.text = String(rate)
            self.industryNameLabel.text = industry
            self.reviewSummaryLabel.text = review_summary
            self.salaryAvgLabel.attributedText = NSMutableAttributedString()
                .bold(string: String(salary_avg), fontSize: 25)
                .regular(string: " 만원", fontSize: 21)
            self.interviewQuestionLabel.text = interview_question

        }
    }

    @IBOutlet weak var salaryAvgView: avgRateView!
    @IBOutlet weak var interviewQuestionLabel: UILabel!
    @IBOutlet weak var salaryAvgLabel: UILabel!
    @IBOutlet weak var reviewSummaryLabel: UILabel!
    @IBOutlet weak var industryNameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var rateTotalAvgLabel: UILabel!
}

class ReviewCell: UITableViewCell {
    
    override func prepareForReuse() {
        consLabel.text = nil
        prosLabel.text = nil
        reviewSummaryLabel.text = nil
        rateTotalAvgLabel.text = nil
        companyLabel.text = nil
        
    }

    func setView(_ data: Item) {
        if let imageUrl = data.logoPath, let name = data.name,
            let rate = data.rateTotalAvg, let industry = data.industryName,
            let review_summary = data.reviewSummary, let cons = data.cons,
            let pros = data.pros
        {
            logoImageView.kf.setImage(with: URL(string: imageUrl),
                                      placeholder: UIImage(named: "placeholderImage"),
                                      options: [.transition(.fade(0.2))]
            )
            self.companyLabel.text = name
            self.rateTotalAvgLabel.text = String(rate)
            self.industryNameLabel.text = industry
            self.reviewSummaryLabel.text = review_summary
            self.prosLabel.text = pros
            self.consLabel.text = cons
        }

    }

    @IBOutlet weak var salaryAvgView: avgRateView!
    @IBOutlet weak var consLabel: UILabel!
    @IBOutlet weak var prosLabel: UILabel!
    @IBOutlet weak var reviewSummaryLabel: UILabel!
    @IBOutlet weak var industryNameLabel: UILabel!
    @IBOutlet weak var rateTotalAvgLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var consHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var consTitleHeightConstraint: NSLayoutConstraint!
}

class HorizontalCell: UITableViewCell {

    var themes: [Theme]?
    var data = BehaviorSubject<[Theme]>(value: [])
    var disposeBag: DisposeBag?

    func set() {
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag

        collectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        data.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: "HorizontalCollectionViewCell", cellType: HorizontalCollectionViewCell.self)) { (row, data, cell) in
            cell.setView(data)
            cell.frame.origin.y = 5
        }
            .disposed(by: disposeBag)

    }

    @IBOutlet weak var collectionView: UICollectionView!
}

extension HorizontalCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = -10
        layout.minimumLineSpacing = 10
        return CGSize(width: (self.frame.size.width / 3), height: (self.frame.size.height - 10))
    }
}

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        titleLabel.text = nil 
    }

    func setView(_ data: Theme) {
        self.titleLabel.text = data.title
        let imageUrl = data.coverImage
        self.coverImageView.kf.setImage(with: URL(string: imageUrl),
                                        placeholder: UIImage(named: "placeholderImage"),
                                        options: [.transition(.fade(0.2))])

        self.bgView.layer.borderColor = UIColor(hexString: data.color).cgColor
        self.bgView.layer.borderWidth = 1.5
    }

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!

}
