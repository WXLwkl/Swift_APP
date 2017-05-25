
import UIKit

fileprivate let WeChatSearchTintColor = RGBA(r: 0.12, g: 0.74, b: 0.13, a: 1.00)

class WeChatSearchController: UISearchController {
    
    lazy var hasFindCancelBtn: Bool = {
        return false
    }()
    lazy var link: CADisplayLink = {
        CADisplayLink(target: self, selector: #selector(findCancel))
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        searchBar.barTintColor = kSectionColor

        // 搜索框
        searchBar.barStyle = .default
        searchBar.tintColor = WeChatSearchTintColor
        // 去除上下两条横线
        searchBar.setBackgroundImage(kSectionColor.trans2Image(), for: .any, barMetrics: .default)
        // 右侧语音
        searchBar.showsBookmarkButton = true
        searchBar.setImage(#imageLiteral(resourceName: "VoiceSearchStartBtn"), for: .bookmark, state: .normal)
        
        searchBar.delegate = self
        
    }
    
    func findCancel() {
        let btn = searchBar.value(forKey: "_cancelButton") as AnyObject
        if btn.isKind(of: NSClassFromString("UINavigationButton")!) {
            printLog("就是它")
            link.invalidate()
            link.remove(from: RunLoop.current, forMode: .commonModes)
            hasFindCancelBtn = true
            let cancel = btn as! UIButton
            cancel.setTitleColor(WeChatSearchTintColor, for: .normal)
            // cancel.setTitleColor(UIColor.orange, for: .highlighted)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置状态栏颜色
        UIApplication.shared.statusBarStyle = .default
    }
}

extension WeChatSearchController: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        printLog("点击了语音按钮")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        if !hasFindCancelBtn {
            link.add(to: RunLoop.current, forMode: .commonModes)
        }
    }
}
