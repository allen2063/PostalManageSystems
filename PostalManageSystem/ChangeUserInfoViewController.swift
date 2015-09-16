//
//  ChangeUserInfoViewController.swift
//  POST
//
//  Created by QiaoLibo on 15/9/6.
//  Copyright (c) 2015年 Qiaolibo. All rights reserved.
//

import UIKit

class ChangeUserInfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var bianGengShiXiangTextField: UITextField!
    @IBOutlet weak var changSuoMingChengTextField: UITextField!
    @IBOutlet weak var dengJiBianHaoTextField: UITextField!
    @IBOutlet weak var changSuoDiZhiTextField: UITextField!
    @IBOutlet weak var shangJiDanWeiTextField: UITextField!
    @IBOutlet weak var youZhengBianMaTextField: UITextField!

    @IBOutlet weak var changeUserInfoView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBAction func changeUserInfoSegmentedControlValueChanged(sender: AnyObject) {
        if let segmentedControl = sender as? UISegmentedControl {
            var index = segmentedControl.selectedSegmentIndex
            println("Index: \(index)")
            switch index {
            case 0:
                changeUserInfoView.hidden = false
                changePasswordView.hidden = true
                if let rootView = self.view as? UIScrollView {
                    rootView.contentSize = CGSize(width: 320, height: 1490)
                }
            case 1:
                changeUserInfoView.hidden = true
                changePasswordView.hidden = false
                if let rootView = self.view as? UIScrollView {
                    rootView.contentSize = CGSize(width: 320, height: 1779)
                }
            default:
                break;
            }
        }

    }
    
    @IBAction func commitInChangeUserInfo(sender: AnyObject) {
        var userInfo: ChangeUserInfo? = ChangeUserInfo()
        userInfo?.bianGengShiXiang = bianGengShiXiangTextField.text
        userInfo?.changSuoMingCheng = changSuoMingChengTextField.text
        userInfo?.dengJiBianHao = dengJiBianHaoTextField.text
        userInfo?.changSuoDiZhi = changSuoDiZhiTextField.text
        userInfo?.shangJiDanWei = shangJiDanWeiTextField.text
        userInfo?.youZhengBianMa = youZhengBianMaTextField.text
        
//        println("\(ClassToJSON.getObjectData(userInfo))")
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changePasswordView.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
