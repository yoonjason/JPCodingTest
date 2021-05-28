//
//  ViewController.swift
//  JobPlanetCT
//
//  Created by yoon on 2021/05/26.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    var viewModel = JPViewModel()
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestData()
        setView()
    }


    func setView() {
        self.title = "기업 정보 검색 결과"
        viewModel.items.bind(to: jpTableView.rx.items) { (tableView, row, item) -> UITableViewCell in
            let indexPath = IndexPath(item: row, section: 0)

            switch item.cellType {
            case .cellTypeCompany:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath) as! CompanyCell
                cell.setView(item)
                cell.selectionStyle = .none
                return cell
            case .cellTypeHorizontalTheme:
                let cell = tableView.dequeueReusableCell(withIdentifier: "HorizontalCell", for: indexPath) as! HorizontalCell
                if let themes = item.themes {
                    cell.data.onNext(themes)
                    cell.set()
                }
                cell.selectionStyle = .none
                return cell
            case .cellTypeReview:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
                cell.setView(item)
                cell.selectionStyle = .none
                return cell
            }
        }
            .disposed(by: disposeBag)

        jpTableView
            .rx
            .willDisplayCell
            .subscribe(onNext: { [self] (cell, indexPath) in
            if viewModel.itemsCount - 4 == indexPath.row {
                viewModel.page += 1
                /*
                 다음 데이터 호출
                 viewModel.requestData()
                 jpTableView.reloadData()
                 */
            }
        })
            .disposed(by: disposeBag)

        Observable.zip(jpTableView.rx.itemSelected, jpTableView.rx.modelSelected(Item.self))
            .subscribe(onNext: { [self] (indexPath, item) in
            switch (item.cellType) {
            case .cellTypeCompany:
                performSegue(withIdentifier: "MOVE_DETAIL", sender: item)
                break
            case .cellTypeReview:
                performSegue(withIdentifier: "MOVE_DETAIL", sender: item)
                break
            case .cellTypeHorizontalTheme:
                break
            }
        })
            .disposed(by: disposeBag)


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MOVE_DETAIL" {
            if let destinationVC = segue.destination as? DetailViewController, let item = sender as? Item {
                destinationVC.item = item
            }
        }
    }

    @IBOutlet weak var jpTableView: UITableView!
}
