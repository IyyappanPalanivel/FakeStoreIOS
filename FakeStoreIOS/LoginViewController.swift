//
//  LoginViewController.swift
//  FakeStoreIOS
//
//  Created by Apple on 17/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    

    @IBAction func loginAction(_ sender: Any) {
        
        if(isValid()){
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "HomeVc")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func isValid() -> Bool {
        
        if(emailInput.text!.isEmpty) {
            showAlert(message: "Please Enter Valid Email")
            return false
        }
        else if(passwordInput.text!.isEmpty) {
            showAlert(message: "Please Enter Valid Password")
            return false
        }else if(!isValidEmail(emailInput.text!)){
            showAlert(message: "Please Enter Valid Email")
            return false
        }else if(passwordInput.text!.count < 8){
            showAlert(message: "Password must contain minimum 8 Characters")
            return false
        }
            
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(message: String) {
            let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
              
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: false, completion: nil)
            }
        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

