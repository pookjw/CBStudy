//
//  SearchViewController.swift
//  ImageSearch
//
//  Created by Jinwoo Kim on 3/12/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Kingfisher

internal final class SearchViewController: UIViewController {
    private typealias DataSource = RxTableViewSectionedAnimatedDataSource<SearchDataSourceSectionModel>
    private weak var tableView: UITableView? = nil
    private weak var searchController: UISearchController? = nil
    private lazy var dataSource: DataSource = createDataSource()
    private var viewModel: SearchViewModel = .init()
    private var disposeBag: DisposeBag = .init()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        configureSearchController()
        configureTableView()
        bind()
    }
    
    private func setAttributes() {
        view.backgroundColor = .systemBackground
        title = "ImageSearch"
    }
    
    private func configureSearchController() {
        let searchController: UISearchController = .init(searchResultsController: nil)
        self.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureTableView() {
        let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
        self.tableView = tableView
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
    }
    
    private func createDataSource() -> DataSource {
        let dataSource: DataSource = .init { (ds, tv, ip, item) -> UITableViewCell in
            let cell: UITableViewCell = tv.dequeueReusableCell(withIdentifier: "cell", for: ip)
            
            switch item {
            case .search(let data):
                cell.textLabel?.text = data.displaySitename
                cell.detailTextLabel?.text = data.docUrl?.absoluteString
                cell.imageView?.kf.indicatorType = .activity
                cell.imageView?.kf.setImage(with: data.thumbnailUrl, completionHandler: { [weak cell] _ in
                    cell?.layoutSubviews()
                })
                cell.imageView?.clipsToBounds = true
                cell.imageView?.layer.cornerRadius = 50
            }
            
            return cell
        }
        
        return dataSource
    }
    
    private func bind() {
        searchController?.searchBar.rx
            .searchButtonClicked
            .subscribe(with: self, onNext: { (obj, _) in
                obj.searchController?.dismiss(animated: true, completion: nil)
                guard let text: String = obj.searchController?.searchBar.text,
                      !text.isEmpty else {
                    return
                }
                obj.viewModel.keywordEvent.onNext(text)
            })
            .disposed(by: disposeBag)
        
        if let tableView: UITableView = tableView {
            viewModel.dataSource
                .drive(tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
