//
//  LeftSlideMenuController.swift
//  PaperPlane
//
//  Created by Kenneth Zhang on 16/4/14.
//  Copyright © 2016年 me.yzo. All rights reserved.
//

import UIKit

class LeftSlideMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var functionTableView: UITableView!
    @IBOutlet weak var tempButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    
    fileprivate var backgroundImageView: UIImageView!
    
    var delegate: SlideMenuDelegate?
    var closeDelegate: CloseSlideMenuDelegate?
    
    // 左边栏功能
    let slidebarFunction = ["Swift","Github","@yonient","http://yzo.me","Kenneth","Zhang"]
    // 左边栏图标
    let slidebarIcon = ["Swift":"vip","Github":"wallet","@yonient":"style","http://yzo.me":"favorite","Kenneth":"gallery","Zhang":"file"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.layer.cornerRadius = 22.5
        avatarImageView.layer.masksToBounds = true
        
        functionTableView.delegate = self
        functionTableView.dataSource = self
        
        functionTableView.backgroundColor = .clear
        
        backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width*0.8, height: UIScreen.main.bounds.size.height))
        backgroundImageView.image = UIImage(named: "slideBackground")
        backgroundImageView.contentMode = .scaleToFill
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
        
        view.frame = CGRect(x: -UIScreen.main.bounds.size.width*0.3, y: 0, width: UIScreen.main.bounds.size.width*0.8, height: UIScreen.main.bounds.size.height)
        view.layoutIfNeeded()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slidebarFunction.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "leftViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            let cellSlideIcon = UIImage(named: slidebarIcon["\(slidebarFunction[indexPath.row])"]!)
            let cellSlideIconSize = CGSize(width: 24, height: 20)
            UIGraphicsBeginImageContextWithOptions(cellSlideIconSize, false, 0)
            let cellSlideIconRect = CGRect(x: 0, y: 0, width: cellSlideIconSize.width, height: cellSlideIconSize.height)
            cellSlideIcon?.draw(in: cellSlideIconRect)
            cell?.imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            cell?.textLabel!.text = slidebarFunction[indexPath.row]
            cell?.textLabel?.textColor = .white
        }
        
        if let cell = cell {
            cell.backgroundColor = UIColor.clear
            cell.selectedBackgroundView?.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.8)
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alterWindows = UIAlertController(title: slidebarFunction[indexPath.row], message: "http://www.github.com/yonient", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alterWindows.addAction(okAction)
        self.present(alterWindows, animated: true, completion: nil)
    }
    

    @IBAction func pressQRButton(_ sender: UIButton) {
        delegate?.showQRCode()
        closeDelegate?.closeSlideMenu()
    }
}
