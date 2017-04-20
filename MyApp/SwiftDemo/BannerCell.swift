

import UIKit

class BannerCell: UICollectionViewCell {

    //声明属性
    lazy var iconImageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var bottomView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        setupUI()
    }
    var cycleModel : BannerModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            
            if (cycleModel?.imageUrl.hasPrefix("http"))! {
//                let url = URL(string: cycleModel?.imageUrl ?? "")!
//                let data = NSData(contentsOf: url)
//                iconImageView.image = UIImage(data: data as! Data)
                let iconURL = URL(string: cycleModel?.imageUrl ?? "")!
                iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "POS_TY633"))
            } else {
                iconImageView.image = UIImage(named: cycleModel?.imageUrl ?? "")
            }
        }
    }
}
extension BannerCell {

    fileprivate func setupUI() {

        iconImageView.frame = bounds
        
        bottomView.frame = CGRect(x: 0, y: iconImageView.bounds.height - 30, width: iconImageView.bounds.width, height: 30)
        titleLabel.frame = CGRect(x: 10, y: iconImageView.bounds.height - 25, width: iconImageView.bounds.width / 2, height: 20)

        //设置属性
        bottomView.backgroundColor = .black
        bottomView.alpha = 0.3
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 14)

        contentView.addSubview(iconImageView)
        contentView.addSubview(bottomView)
        contentView.addSubview(titleLabel)

    }

}
