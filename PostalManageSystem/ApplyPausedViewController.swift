//
//  ApplyPausedViewController.swift
//  PostalManageSystem
//
//  Created by QiaoLibo on 15/9/10.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

import UIKit

class ApplyPausedViewController: UIViewController, UIActionSheetDelegate, UITextFieldDelegate, UIScrollViewDelegate {
    @IBOutlet weak var changSuoMingCheng: UITextField!
    @IBOutlet weak var shangJiDanWei: UITextField!
    @IBOutlet weak var fuWuQuYu: UITextField!
    @IBOutlet weak var diZhi: UITextField!
    @IBOutlet weak var youBian: UITextField!
    @IBOutlet weak var lianXiRenXingMing: UITextField!
    @IBOutlet weak var lianXiDianHua: UITextField!
    @IBOutlet weak var zanTingShiJian: UITextField!
    @IBOutlet weak var zanXianYuanYin: UITextField!
    @IBOutlet weak var buJiuCuoShi: UITextField!
    
    
    @IBOutlet weak var XinJian: UIButton! //
    @IBOutlet weak var YouZhengHuiDui: UIButton! //
    @IBOutlet weak var MangRenDuWu: UIButton! //
    @IBOutlet weak var YinShuaPin: UIButton! //
    @IBOutlet weak var BaoGuo: UIButton! //
    @IBOutlet weak var LieShiBaoGuo: UIButton! //
    @IBOutlet weak var GuoJiaGuiDingBaoKanDeFaXing: UIButton!
    @IBOutlet weak var YiWuBingXinHan: UIButton! //
    
    @IBAction func touchInsideBtm(sender: AnyObject) {
        
        if let sender = sender as? UIButton {
            if sender == XinJian {
                if XinJian.selected == false {
                    XinJian.selected = true
                } else {
                    XinJian.selected = false
                }
            }
            
            if sender == YouZhengHuiDui {
                if YouZhengHuiDui.selected == false {
                    YouZhengHuiDui.selected = true
                } else {
                    YouZhengHuiDui.selected = false
                }
                
            }
            if sender == MangRenDuWu {
                if MangRenDuWu.selected == false {
                    MangRenDuWu.selected = true
                } else {
                    MangRenDuWu.selected = false
                }
                
            }
            if sender == YinShuaPin {
                if YinShuaPin.selected == false {
                    YinShuaPin.selected = true
                } else {
                    YinShuaPin.selected = false
                }
                
            }
            if sender == BaoGuo {
                if BaoGuo.selected == false {
                    BaoGuo.selected = true
                } else {
                    BaoGuo.selected = false
                }
            }
            if sender == LieShiBaoGuo {
                if LieShiBaoGuo.selected == false {
                    LieShiBaoGuo.selected = true
                } else {
                    LieShiBaoGuo.selected = false
                }
                
            }
            if sender == GuoJiaGuiDingBaoKanDeFaXing {
                if GuoJiaGuiDingBaoKanDeFaXing.selected == false {
                    GuoJiaGuiDingBaoKanDeFaXing.selected = true
                } else {
                    GuoJiaGuiDingBaoKanDeFaXing.selected = false
                }
                
            }
            if sender == YiWuBingXinHan {
                if YiWuBingXinHan.selected == false {
                    YiWuBingXinHan.selected = true
                } else {
                    YiWuBingXinHan.selected = false
                }
            }
            
        }
    }
    
    @IBOutlet weak var chooseBanLiShiXiangLabel: UILabel!
    
    @IBAction func printActionSheet(sender: AnyObject) {
        if (sender as? UIGestureRecognizer != nil) {
            if sender.view == chooseBanLiShiXiangLabel {
                let actionSheet = UIActionSheet(title: "选择办理事项", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "暂时停止办理业务事项", "暂时限制办理业务事项")
                actionSheet.showInView(self.view)
            }
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet.buttonTitleAtIndex(buttonIndex) != "取消"{
                chooseBanLiShiXiangLabel.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseBanLiShiXiangLabel.textColor = UIColor.blackColor()
        }
    }

    
     override func viewDidLoad() {
        super.viewDidLoad()

//          NSNotificationCenter.defaultCenter().addObserver(self, selector: nil, name: UIKeyboardDidShowNotification, object: nil)
        }
    
//    func getKeyboardHeight(notif: NSNotification)
//    {
//        var info: NSDictionary = notif.userInfo!
//        var value: AnyObject? = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)
//        var keyboardSize: CGSize = value!.CGSizeValue()
//        println("\(keyboardSize)")
//    }
    
    var viewUp: Bool = false
    var shouldDragDismiss: Bool = false

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        //-----------------------------------------------------------
        var rootView: UIScrollView = self.view as! UIScrollView
        if textField.frame.origin.y - rootView.contentOffset.y > 300 && (viewUp == false) {
            UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
                rootView.contentOffset.y += 250
//                self.view.center.y -= 300
                }, completion: nil)
            viewUp = true
            shouldDragDismiss = true
        }
        //-----------------------------------------------------------
//        if textField == zanTingShiJian {
//            UIView.animateWithDuration(0.3, animations: {
//                self.view.center.y -= 216
//            })
//            self.viewUp = true
//        }
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        var rootView: UIScrollView = self.view as! UIScrollView
        if viewUp == true {
            UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
                rootView.contentOffset.y -= 250
//                self.view.center.y += 300
                }, completion: nil)
            viewUp = false
            shouldDragDismiss = false
        }
//        if textField == zanTingShiJian {
//            UIView.animateWithDuration(0.3, animations: {
//                self.view.center.y += 216
//            })
//            self.viewUp = false
//        }
        return true
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        println("asdhgkajhsfgsdalfkjhasdkjflhasdkjlfhjksd")
        if shouldDragDismiss && (viewUp == false) {
            UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseOut, animations: {
                self.view.center.y += 350
                }, completion: nil)
            
            viewUp = false
            shouldDragDismiss = false
        }
//        if self.viewUp {
//            UIView.animateWithDuration(0.3, animations: {
//                self.view.center.y += 216
//            })
//            self.viewUp = false
//        } else if !self.viewUp {
//            UIView.animateWithDuration(0.3, animations: {
//                self.view.center.y -= 216
//            })
//            self.viewUp = true
//        }
    }
    
    @IBAction func commit(sender: AnyObject) {
        var infoOfZtbhxbyzpbfwhtsfwywdjb = InfoOfZtbhxbyzpbfwhtsfwywdjb()
        infoOfZtbhxbyzpbfwhtsfwywdjb.yzyycsmc = changSuoMingCheng.text
        infoOfZtbhxbyzpbfwhtsfwywdjb.sjdw = shangJiDanWei.text
        
        //infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx = chooseBanLiShiXiangLabel.text
        if (chooseBanLiShiXiangLabel.text == "暂时停止办理业务事项")  {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx = "zstzblywsx"
        }
        if(chooseBanLiShiXiangLabel.text == "暂时限制办理业务事项") {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx = "zsxzblywsx"
        }
        
        if XinJian.selected {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx_ywfw += "xj"
        }
        if YouZhengHuiDui.selected {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx_ywfw += ",yzhd"
        }
        if MangRenDuWu.selected {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx_ywfw += ",mrdw"
        }
        if YinShuaPin.selected {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx_ywfw += ",ysp"
        }
        if BaoGuo.selected {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx_ywfw += ",bgs"
        }
        if LieShiBaoGuo.selected {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx_ywfw += ",gmlsyw"
        }
        if GuoJiaGuiDingBaoKanDeFaXing.selected {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx_ywfw += ",gjgdbkdfx"
        }
        if YiWuBingXinHan.selected {
            infoOfZtbhxbyzpbfwhtsfwywdjb.xzblsx_ywfw += ",ywbpcxh"
        }
        
        infoOfZtbhxbyzpbfwhtsfwywdjb.zstzblhzxzblywdyzyycsdfwqy = fuWuQuYu.text
        infoOfZtbhxbyzpbfwhtsfwywdjb.dz = diZhi.text
        infoOfZtbhxbyzpbfwhtsfwywdjb.yzbm = youBian.text
        infoOfZtbhxbyzpbfwhtsfwywdjb.lxrxm = lianXiRenXingMing.text
        infoOfZtbhxbyzpbfwhtsfwywdjb.lxdh = lianXiDianHua.text
        infoOfZtbhxbyzpbfwhtsfwywdjb.zstzblhzxzblywdsj = zanTingShiJian.text
        infoOfZtbhxbyzpbfwhtsfwywdjb.zstzblhzxzblywdyy = zanXianYuanYin.text
        infoOfZtbhxbyzpbfwhtsfwywdjb.zstzblhzxzblywqjyzqycqdbjcs = buJiuCuoShi.text
        
       println("\(ClassToJSON.getObjectData(infoOfZtbhxbyzpbfwhtsfwywdjb))")
    }
    
    func initZanTing(dict: NSDictionary) {
        changSuoMingCheng.text = dict.valueForKey("yzyycsmc") as! String
        shangJiDanWei.text = dict.valueForKey("sjdw") as! String
        
        if (dict.valueForKey("xzblsx") as! String == "zstzblywsx")  {
            chooseBanLiShiXiangLabel.text = "暂时停止办理业务事项"
        }
        if (dict.valueForKey("xzblsx") as! String == "zsxzblywsx") {
            chooseBanLiShiXiangLabel.text = "暂时限制办理业务事项"
        }
        
        var ywsxArray = dict.valueForKey("xzblsx_ywfw") as! String
        if (ywsxArray.rangeOfString("xj") != nil) {
            XinJian.selected = true
        }
        if (ywsxArray.rangeOfString("yzhd") != nil) {
            YouZhengHuiDui.selected = true
        }
        if (ywsxArray.rangeOfString("mrdw") != nil) {
            MangRenDuWu.selected = true
        }
        if (ywsxArray.rangeOfString("ysp") != nil) {
            YinShuaPin.selected = true
        }
        if (ywsxArray.rangeOfString("bgs") != nil) {
            BaoGuo.selected = true
        }
        if (ywsxArray.rangeOfString("gmlsyw") != nil) {
            LieShiBaoGuo.selected = true
        }
        if (ywsxArray.rangeOfString("gjgdbkdfx") != nil) {
            GuoJiaGuiDingBaoKanDeFaXing.selected = true
        }
        if (ywsxArray.rangeOfString("ywbpcxh") != nil) {
            YiWuBingXinHan.selected = true
        }
        
        fuWuQuYu.text = dict.valueForKey("zstzblhzxzblywdyzyycsdfwqy") as! String
        dict.valueForKey("dz") as! String
        youBian.text = dict.valueForKey("yzbm") as! String
        lianXiRenXingMing.text = dict.valueForKey("lxrxm") as! String
        lianXiDianHua.text = dict.valueForKey("lxdh") as! String
        zanTingShiJian.text = dict.valueForKey("zstzblhzxzblywdsj") as! String
        zanXianYuanYin.text = dict.valueForKey("zstzblhzxzblywdyy") as! String
        buJiuCuoShi.text = dict.valueForKey("zstzblhzxzblywqjyzqycqdbjcs") as! String
    }

}

