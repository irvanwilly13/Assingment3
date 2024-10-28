
import UIKit

class ConfirmPaymentViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelSuccess: UILabel!
    @IBOutlet weak var backToDashboardButton: UIButton!
    @IBOutlet weak var viewDetailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    func setup() {
        backToDashboardButton.addTarget(self, action: #selector(actionToHome), for: .touchUpInside)
        
        viewDetailButton.setCornerRadius(16)
        backToDashboardButton.setCornerRadius(16)
    }
    @objc func actionToHome() {
        let vc = DashboardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
