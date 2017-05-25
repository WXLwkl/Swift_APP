

import UIKit

class TableViewHeaderView: UIView {
 
    lazy var nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        UIColor(240, 240, 240, 0.8)
        backgroundColor = UIColor.init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        nameLabel.frame = CGRect(x: 15, y: 0, width: 200, height: 20)
        nameLabel.font = UIFont.systemFont(ofSize: 13)
        addSubview(nameLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
