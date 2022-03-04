//
//  UserDetailView.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 02/03/2022.
//

import UIKit
import SDWebImage
import SnapKit
import MapKit

final class UserDetailView: UIView {
    private let userHeaderView: UserHeaderView
    private let userLocationView: UserLocationView
    let userLoginView: UserLoginView

    init() {
        userLocationView = UserLocationView()
        userHeaderView = UserHeaderView()
        userLoginView = UserLoginView()
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        let outerStackView = UIStackView(arrangedSubviews: [userHeaderView, userLocationView, userLoginView])
        outerStackView.spacing = 20
        outerStackView.axis = .vertical
        addSubview(outerStackView)
        outerStackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with user: User) {
        userHeaderView.configure(user: user)
        userLocationView.configure(user: user)
        userLoginView.configure(user: user)
    }
    
    func shouldShowMore(_ showMore: Bool) {
        let anim = UIViewPropertyAnimator(duration: 0.2, curve: UIView.AnimationCurve.linear, animations: { [weak self] in
            self?.userLoginView.shouldShowMore(showMore)
            self?.layoutIfNeeded()
        })
        anim.startAnimation()
    }
}


final class UserHeaderView: UIView {
    // MARK: - Header
    let imageView = UIImageView()
    let name = UILabel()
    let phoneNumber = UILabel()
    let email = UILabel()
    let cell = UILabel()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        let currentView = create()
        addSubview(currentView)
        
        currentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: User) {
        name.text = user.name.fullName
        email.text = user.email
        phoneNumber.text = "Phone: \(user.phone)"
        imageView.sd_setImage(with: URL(string: user.picture.large),
                              placeholderImage:UIImage(systemName: "photo"))
        cell.text = "Cell: \(user.cell)"
    }
    
    func create() -> UIView {
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        email.normalize(with: .subheadline)
        phoneNumber.normalize(with: .subheadline)
        cell.normalize(with: .subheadline)
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        let innerStackView = UIStackView(arrangedSubviews: [name, email, phoneNumber, cell])
        innerStackView.spacing = 3
        innerStackView.axis = .vertical
        
        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView])
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        
        return outerStackView
    }
}


final class UserLocationView: UIView {
    // MARK: - Location
    private let locationTitle = UILabel()
    private let street = UILabel()
    private let city = UILabel()
    private let state = UILabel()
    private let country = UILabel()
    private let postcode = UILabel()
    private let mapView = MKMapView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        let currentView = create()
        addSubview(currentView)
        
        currentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: User) {
        street.text = "Street: \(user.location.street.name)"
        city.text = "City: \(user.location.city)"
        state.text = "State: \(user.location.state)"
        country.text = "Country: \(user.location.country)"
        postcode.text = "Postcode: \(user.location.postcode.getCode)"
        let noLocation = user.location.coordinates.position
        mapView.centerToLocation(noLocation)
        let userLocation = UserLocation(
            title: "Hello this is where I live",
            locationName: "\(user.location.street.name)",
            coordinate: CLLocationCoordinate2D(latitude: user.location.coordinates.latitudeDouble, longitude: user.location.coordinates.longitudeDouble))
        mapView.addAnnotation(userLocation)
    }
    
    func create() -> UIView {
        locationTitle.text = "Location"
        locationTitle.font = UIFont.preferredFont(forTextStyle: .title1)
        locationTitle.textColor = .label
        street.normalize(with: .subheadline)
        city.normalize(with: .subheadline)
        state.normalize(with: .subheadline)
        country.normalize(with: .subheadline)
        postcode.normalize(with: .subheadline)
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = true
        mapView.showsScale = true
    
        mapView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let verticalInnerStackView = UIStackView(arrangedSubviews: [street, city, state, country, postcode])
        verticalInnerStackView.spacing = 3
        verticalInnerStackView.axis = .vertical
        
        let innerStackView = UIStackView(arrangedSubviews: [verticalInnerStackView, mapView])
        innerStackView.spacing = 3
        innerStackView.axis = .horizontal
        
        let outerStackView = UIStackView(arrangedSubviews: [locationTitle, innerStackView])
        outerStackView.spacing = 10
        outerStackView.axis = .vertical
        
        mapView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        return outerStackView
    }
}

final class UserLoginView: UIView {
    // MARK: - Location
    private let loginTitle = UILabel()
    lazy var showMoreButton = UIButton()
    private let username = UILabel()
    private let password = UILabel()
    private let md5 = UILabel()
    private let sha1 = UILabel()
    private let sha256 = UILabel()
    private let salt = UILabel()
    var containerView: UIView!
    var bottomConstraint: Constraint?

    init() {
        super.init(frame: .zero)
        containerView = create()
        backgroundColor = .systemBackground
        addSubview(containerView)
        
        containerView.snp.makeConstraints { [weak self] make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            self?.bottomConstraint = make.height.equalTo(50).constraint
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shouldShowMore(_ showMore: Bool) {
        if showMore {
            bottomConstraint?.deactivate()
        } else {
            bottomConstraint?.activate()
        }
    }
    
    func configure(user: User) {
        username.text = "Username: \(user.login.username)"
        password.text = "Password: \(user.login.password)"
        md5.text = "Md5: \(user.login.md5)"
        sha1.text = "Sha1: \(user.login.sha1)"
        salt.text = "Salt: \(user.login.salt)"
        sha256.text = "Sha256: \(user.login.sha256)"
    }

    func create() -> UIView {
        loginTitle.text = "User Login Information"
        loginTitle.font = UIFont.preferredFont(forTextStyle: .title2)
        loginTitle.textColor = .label
        username.normalize(with: .subheadline)
        password.normalize(with: .subheadline)
        md5.normalize(with: .subheadline)
        sha1.normalize(with: .subheadline)
        sha256.normalize(with: .subheadline)
        salt.normalize(with: .subheadline)

        showMoreButton.setTitle("Show More", for: UIControl.State())
        showMoreButton.setTitleColor(.label, for: UIControl.State())
        showMoreButton.backgroundColor = .systemBackground
        
        let bottomInnerStackView = UIStackView(arrangedSubviews: [username, password, salt, md5, sha1, sha256])
        bottomInnerStackView.spacing = 3
        bottomInnerStackView.axis = .vertical

        let headerStackView = UIStackView(arrangedSubviews: [loginTitle, showMoreButton])
        headerStackView.spacing = 3
        headerStackView.axis = .horizontal
        
        let outerStackView = UIStackView(arrangedSubviews: [headerStackView, bottomInnerStackView])
        outerStackView.spacing = 10
        outerStackView.axis = .vertical

        return outerStackView
    }
}

extension UILabel {
    func normalize(with style : UIFont.TextStyle) {
        self.font = UIFont.preferredFont(forTextStyle: style)
        self.textColor = .secondaryLabel
    }
}
