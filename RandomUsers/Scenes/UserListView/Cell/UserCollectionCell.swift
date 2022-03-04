//
//  UserCollectionCell.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 01/03/2022.
//

import UIKit
import Combine
import SDWebImage
import SnapKit

final class UserCollectionCell: UICollectionViewCell, SelfConfiguringCell {
    static let reuseIdentifier: String = "UserCollectionCell"

    let name = UILabel()
    let subtitle = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        name.textColor = .label
        subtitle.font = UIFont.preferredFont(forTextStyle: .subheadline)
        subtitle.textColor = .secondaryLabel
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let innerStackView = UIStackView(arrangedSubviews: [name, subtitle])
        innerStackView.axis = .vertical

        let outerStackView = UIStackView(arrangedSubviews: [imageView, innerStackView])
        outerStackView.alignment = .center
        outerStackView.spacing = 10
        contentView.addSubview(outerStackView)

        outerStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
    }
    
    func configure(with user: User) {
        name.text = user.name.fullName
        subtitle.text = user.phone
        imageView.sd_setImage(with: URL(string: user.picture.medium),
                              placeholderImage:UIImage(systemName: "photo"))
    }

    required init?(coder: NSCoder) {
        fatalError("Just… no")
    }
}
