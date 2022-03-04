//
//  UserListViewController.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import UIKit
import Combine
import Resolver

final class UserListViewController: UIViewController {
    @Injected private var viewModel: UserListViewModel
    @Injected private var coordinator: AppNavigationFlow
    private var dataSource: UICollectionViewDiffableDataSource<UserListViewModelSection, User>?
    private typealias Snapshot = NSDiffableDataSourceSnapshot<UserListViewModelSection, User>
    private var searchController = UISearchController(searchResultsController: nil)
    private lazy var contentView = UserListView()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        viewModel.loadUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            self.contentView.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}

// MARK: - Data

private extension UserListViewController {
    func updateSections() {
        var snapshot = Snapshot()
        snapshot.appendSections([.users])
        snapshot.appendItems(viewModel.users)
        dataSource?.apply(snapshot, animatingDifferences: true)
        contentView.refreshControl.endRefreshing()
    }
}

// MARK: - Setup
private extension UserListViewController {
    func setUp() {
        setupViewController()
        setUpCollectionView()
        configureSearchController()
        configureRefresh()
        configureDataSource()
        setUpBindings()
    }
    
    func setupViewController() {
        title = "Users"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpCollectionView() {
        contentView.collectionView.delegate = self
        contentView.collectionView.prefetchDataSource = self
        contentView.collectionView.register(
            UserCollectionCell.self,
            forCellWithReuseIdentifier: UserCollectionCell.reuseIdentifier)
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func configureRefresh() {
        contentView.refreshControl.addTarget(self, action: #selector(refreshUsers(_:)), for: .valueChanged)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<UserListViewModelSection, User>(collectionView: contentView.collectionView) { collectionView, indexPath, user in
            return self.configure(UserCollectionCell.self, with: user, for: indexPath)
        }
    }
    
    func setUpBindings() {
        func bindViewToViewModel() {
            searchController.searchBar.searchTextField.textPublisher
                .debounce(for: 0.5, scheduler: DispatchQueue.main)
                .removeDuplicates()
                .sink { [weak viewModel] query in
                    viewModel?.search(query: query)
                }
                .store(in: &cancellable)
        }
        
        func bindViewModelToView() {
            viewModel.$state
                .receive(on: DispatchQueue.main)
                .sink { [weak self] state in
                    switch state {
                    case .idle, .loading:
                        self?.contentView.startLoading()
                    case .finished, .searching:
                        self?.contentView.finishLoading()
                        self?.updateSections()
                    }
                }
                .store(in: &cancellable)
        }
        bindViewToViewModel()
        bindViewModelToView()
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension UserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if !searchController.isActive {
            viewModel.search()
        }
    }
}

extension UserListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath]) {
        guard viewModel.users.count > 10,
              viewModel.canPullMoreUsers() else {
                  return
              }
        for index in indexPaths where index.row == viewModel.users.count - 3 {
            viewModel.loadUsers()
            break
        }
    }
}

extension UserListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard viewModel.users.count == 10,
              indexPath.item == 9,
              viewModel.canPullMoreUsers() else {
                  return
              }
        viewModel.loadUsers()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.item]
        navigationController?.pushViewController(coordinator.createView(for: .userDetail(user)), animated: true)
    }
}

// MARK: - UISearchResultsUpdating Delegate
private extension UserListViewController {
    @objc private func refreshUsers(_ sender: Any) {
        guard viewModel.state != .searching else {
            return
        }
        contentView.refreshControl.beginRefreshing()
        
        viewModel.refreshUsers()
    }
}

// MARK: - Utils

private extension UserListViewController {
    func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with user: User, for indexPath: IndexPath) -> T {
        guard let cell = contentView.collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        
        cell.configure(with: user)
        return cell
    }
}
