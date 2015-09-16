//
//  ApplyStopBranchViewController.swift
//  PostalManageSystem
//
//  Created by QiaoLibo on 15/9/10.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

import UIKit

class ApplyStopBranchViewController: UIViewController, UIActionSheetDelegate {
    //停止或限制办理普遍和特殊服务申请
    var infoOfYzyycstbhybyzpbfwywhtsfwywdsq = InfoOfYzyycstbhybyzpbfwywhtsfwywdsq()
    
    @IBOutlet weak var fenGongSi: UITextField!
    @IBOutlet weak var yingYeChangSuoMingCheng: UITextField!
    @IBOutlet weak var beiShenQingDanWeiMingCheng: UITextField!
    @IBOutlet weak var shenQingZhuYaoYuanYin: UITextField!
    @IBOutlet weak var niTingBanShiJianNian: UITextField!
    @IBOutlet weak var niTingBanShiJianYue: UITextField!
    @IBOutlet weak var changSuoDiZhiShi: UITextField!
    @IBOutlet weak var changSuoDiZhiXian: UITextField!
    @IBOutlet weak var changSuoDiJie: UITextField!
    @IBOutlet weak var youZhengYingYeChangSuoMingCeng: UITextField!
    @IBOutlet weak var jiTiYeWuMingCheng: UITextField!
    @IBOutlet weak var yeWuJuTiQingXing: UITextField!
    @IBOutlet weak var niCaiQuBuJiuCuoShi: UITextField!
    @IBOutlet weak var zongTiFuWuShuiPing: UITextField!
    
    
    //拟停止或限制办理业务营业场所基本情况表
    var infoOfNthybywyzyycsjbqkb = InfoOfNthybywyzyycsjbqkb()
    
    @IBOutlet weak var yingYeChangSuoMingCheng1: UITextField!
    @IBOutlet weak var shangJiDanWei1: UITextField!
    
    @IBOutlet weak var chooseBanLiShiXiangLabel: UILabel!
    @IBOutlet weak var chooseTingXianBanLiYeWuZhongLei: UILabel!
    @IBOutlet weak var fuWuQuYu1: UITextField!
    @IBOutlet weak var diZhi1: UITextField!
    @IBOutlet weak var youBian1: UITextField!
    @IBOutlet weak var lianXiRenXingMing1: UITextField!
    @IBOutlet weak var lianXiDianHua1: UITextField!
    
    var tapedLabel = 0
    @IBAction func printActionSheet(sender: AnyObject) {
        if (sender as? UIGestureRecognizer != nil) {
            if sender.view == chooseBanLiShiXiangLabel {
                let actionSheet = UIActionSheet(title: "选择拟办理事项", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "停止办理", "限制办理")
                actionSheet.showInView(self.view)
                tapedLabel = 1
            }
            
            if sender.view == chooseTingXianBanLiYeWuZhongLei {
                let actionSheet = UIActionSheet(title: "选择停限办业务种类", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "邮政普遍服务业务","特殊服务业务")
                actionSheet.showInView(self.view)
                tapedLabel = 2
            }
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet.buttonTitleAtIndex(buttonIndex) != "取消"{
            if  tapedLabel == 1 {
                chooseBanLiShiXiangLabel.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseBanLiShiXiangLabel.textColor = UIColor.blackColor()
            }
            
            if tapedLabel == 2 {
                chooseTingXianBanLiYeWuZhongLei.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseTingXianBanLiYeWuZhongLei.textColor = UIColor.blackColor()
            }
        }
    }

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

    @IBOutlet weak var XinJian1: UIButton! //
    @IBOutlet weak var YouZhengHuiDui1: UIButton! //
    @IBOutlet weak var MangRenDuWu1: UIButton! //
    @IBOutlet weak var YinShuaPin1: UIButton! //
    @IBOutlet weak var BaoGuo1: UIButton! //
    @IBOutlet weak var LieShiBaoGuo1: UIButton! //
    @IBOutlet weak var GuoJiaGuiDingBaoKanDeFaXing1: UIButton!
    @IBOutlet weak var YiWuBingXinHan1: UIButton! //
    
    @IBAction func touchInsideBtm2(sender: AnyObject) {
        
        if let sender = sender as? UIButton {
            if sender == XinJian1 {
                if XinJian1.selected == false {
                    XinJian1.selected = true
                } else {
                    XinJian1.selected = false
                }
            }
            
            if sender == YouZhengHuiDui1 {
                if YouZhengHuiDui1.selected == false {
                    YouZhengHuiDui1.selected = true
                } else {
                    YouZhengHuiDui1.selected = false
                }
                
            }
            if sender == MangRenDuWu1 {
                if MangRenDuWu1.selected == false {
                    MangRenDuWu1.selected = true
                } else {
                    MangRenDuWu1.selected = false
                }
                
            }
            if sender == YinShuaPin1 {
                if YinShuaPin1.selected == false {
                    YinShuaPin1.selected = true
                } else {
                    YinShuaPin1.selected = false
                }
                
            }
            if sender == BaoGuo1 {
                if BaoGuo1.selected == false {
                    BaoGuo1.selected = true
                } else {
                    BaoGuo1.selected = false
                }
            }
            if sender == LieShiBaoGuo1 {
                if LieShiBaoGuo1.selected == false {
                    LieShiBaoGuo1.selected = true
                } else {
                    LieShiBaoGuo1.selected = false
                }
                
            }
            if sender == GuoJiaGuiDingBaoKanDeFaXing1 {
                if GuoJiaGuiDingBaoKanDeFaXing1.selected == false {
                    GuoJiaGuiDingBaoKanDeFaXing1.selected = true
                } else {
                    GuoJiaGuiDingBaoKanDeFaXing1.selected = false
                }
                
            }
            if sender == YiWuBingXinHan1 {
                if YiWuBingXinHan1.selected == false {
                    YiWuBingXinHan1.selected = true
                } else {
                    YiWuBingXinHan1.selected = false
                }
            }
            
        }
    }

    @IBAction func commit(sender: AnyObject) {
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.zgyzjtgsttfgsmc = fenGongSi.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.btyzyycsmc = yingYeChangSuoMingCheng.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.syzgljmc = beiShenQingDanWeiMingCheng.text
        
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.sqtzblhzxzywdzyyy = shenQingZhuYaoYuanYin.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzblsj_n = niTingBanShiJianNian.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzblsj_y = niTingBanShiJianYue.text
        
        //infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzbl = chooseBanLiShiXiangLabel.text
        if (chooseBanLiShiXiangLabel.text == "停止办理")  {
            infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzbl = "tzbl"
        }
        if(chooseBanLiShiXiangLabel.text == "限制办理") {
            infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzbl = "xzbl"
        }
        
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzbldz_s =  changSuoDiZhiShi.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzbldz_xqs = changSuoDiZhiXian.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzbldz_jx = changSuoDiJie.text
        
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.yzyycsmc = yingYeChangSuoMingCheng.text
        
        //infoOfYzyycstbhybyzpbfwywhtsfwywdsq.yzpbfwywhtsfwyw = chooseTingXianBanLiYeWuZhongLei.text
        if (chooseTingXianBanLiYeWuZhongLei.text == "邮政普遍服务业务")  {
            infoOfYzyycstbhybyzpbfwywhtsfwywdsq.yzpbfwywhtsfwyw = "yzpbfwyw"
        }
        if (chooseTingXianBanLiYeWuZhongLei.text == "特殊服务业务") {
            infoOfYzyycstbhybyzpbfwywhtsfwywdsq.yzpbfwywhtsfwyw = "tsfwyw"
        }
        
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.jtywmc = jiTiYeWuMingCheng.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.xzblywdjtqx = yeWuJuTiQingXing.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.cqdbjcs = niCaiQuBuJiuCuoShi.text
        infoOfYzyycstbhybyzpbfwywhtsfwywdsq.yzpbfwztsp = zongTiFuWuShuiPing.text
        
        //拟停止或限制办理业务营业场所基本情况表
       infoOfNthybywyzyycsjbqkb.yzyycsmc = yingYeChangSuoMingCheng1.text
        infoOfNthybywyzyycsjbqkb.sjdw = shangJiDanWei1.text
        
        if XinJian.selected {
             infoOfNthybywyzyycsjbqkb.tzblywsx += "xj"
        }
        if YouZhengHuiDui.selected {
            infoOfNthybywyzyycsjbqkb.tzblywsx += ",yzhd"
        }
        if MangRenDuWu.selected {
            infoOfNthybywyzyycsjbqkb.tzblywsx += ",mrdw"
        }
        if YinShuaPin.selected {
            infoOfNthybywyzyycsjbqkb.tzblywsx += ",ysp"
        }
        if BaoGuo.selected {
           infoOfNthybywyzyycsjbqkb.tzblywsx += ",bgs"
        }
        if LieShiBaoGuo.selected {
            infoOfNthybywyzyycsjbqkb.tzblywsx += ",gmlsyw"
        }
        if GuoJiaGuiDingBaoKanDeFaXing.selected {
            infoOfNthybywyzyycsjbqkb.tzblywsx += ",gjgdbkdfx"
        }
        if YiWuBingXinHan.selected {
            infoOfNthybywyzyycsjbqkb.tzblywsx += ",ywbpcxh"
        }
        
        //---------------
        if XinJian1.selected {
            infoOfNthybywyzyycsjbqkb.xzblywsx += "xj"
        }
        if YouZhengHuiDui1.selected {
            infoOfNthybywyzyycsjbqkb.xzblywsx += ",yzhd"
        }
        if MangRenDuWu1.selected {
            infoOfNthybywyzyycsjbqkb.xzblywsx += ",mrdw"
        }
        if YinShuaPin1.selected {
            infoOfNthybywyzyycsjbqkb.xzblywsx += ",ysp"
        }
        if BaoGuo1.selected {
            infoOfNthybywyzyycsjbqkb.xzblywsx += ",bgs"
        }
        if LieShiBaoGuo1.selected {
            infoOfNthybywyzyycsjbqkb.xzblywsx += ",lsywbg"
        }
        if GuoJiaGuiDingBaoKanDeFaXing1.selected {
            infoOfNthybywyzyycsjbqkb.xzblywsx += ",gjgdbkdfx"
        }
        if YiWuBingXinHan1.selected {
            infoOfNthybywyzyycsjbqkb.xzblywsx += ",ywbpcxh"
        }
        
        infoOfNthybywyzyycsjbqkb.tbhxbywyzyycsdfwqy = fuWuQuYu1.text
        infoOfNthybywyzyycsjbqkb.dz = diZhi1.text
        infoOfNthybywyzyycsjbqkb.yzbm = youBian1.text
        infoOfNthybywyzyycsjbqkb.lxrxm = lianXiRenXingMing1.text
        infoOfNthybywyzyycsjbqkb.lxdh = lianXiDianHua1.text
        
        println("\(ClassToJSON.getObjectData(infoOfYzyycstbhybyzpbfwywhtsfwywdsq))")
        
        println("\(ClassToJSON.getObjectData(infoOfNthybywyzyycsjbqkb))")
        
    }
    
    func initTingZhi(dict: NSDictionary) {
        fenGongSi.text = dict.valueForKey("zgyzjtgsttfgsmc") as! String
        yingYeChangSuoMingCheng.text = dict.valueForKey("btyzyycsmc") as! String
        beiShenQingDanWeiMingCheng.text = dict.valueForKey("syzgljmc") as! String
        
        shenQingZhuYaoYuanYin.text = dict.valueForKey("sqtzblhzxzywdzyyy") as! String
        niTingBanShiJianNian.text = dict.valueForKey("tzblhzxzblsj_n") as! String
        niTingBanShiJianYue.text = dict.valueForKey("tzblhzxzblsj_y") as! String
        
        //infoOfYzyycstbhybyzpbfwywhtsfwywdsq.tzblhzxzbl = chooseBanLiShiXiangLabel.text
        if (dict.valueForKey("tzblhzxzbl") as! String == "tzbl")   {
           chooseBanLiShiXiangLabel.text = "停止办理"
        }
        if(dict.valueForKey("tzblhzxzbl") as! String == "xzbl") {
            chooseBanLiShiXiangLabel.text = "限制办理"
        }
        
        changSuoDiZhiShi.text = dict.valueForKey("tzblhzxzbldz_s") as! String
        changSuoDiZhiXian.text = dict.valueForKey("tzblhzxzbldz_xqs") as! String
        changSuoDiJie.text = dict.valueForKey("tzblhzxzbldz_jx") as! String
        yingYeChangSuoMingCheng.text = dict.valueForKey("yzyycsmc") as! String
        
        //infoOfYzyycstbhybyzpbfwywhtsfwywdsq.yzpbfwywhtsfwyw = chooseTingXianBanLiYeWuZhongLei.text
        if (dict.valueForKey("yzpbfwywhtsfwyw") as! String == "yzpbfwyw")  {
            chooseTingXianBanLiYeWuZhongLei.text = "邮政普遍服务业务"
        }
        if (dict.valueForKey("yzpbfwywhtsfwyw") as! String == "tsfwyw") {
            chooseTingXianBanLiYeWuZhongLei.text = "特殊服务业务"
        }
        
        jiTiYeWuMingCheng.text = dict.valueForKey("jtywmc") as! String
        yeWuJuTiQingXing.text = dict.valueForKey("xzblywdjtqx") as! String
        niCaiQuBuJiuCuoShi.text = dict.valueForKey("cqdbjcs") as! String
        zongTiFuWuShuiPing.text = dict.valueForKey("yzpbfwztsp") as! String
        
        //拟停止或限制办理业务营业场所基本情况表
        yingYeChangSuoMingCheng1.text = dict.valueForKey("yzyycsmc") as! String
        shangJiDanWei1.text = dict.valueForKey("sjdw") as! String
        
        var ywsxArray = dict.valueForKey("tzblywsx") as! String
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

        var ywsxArray2 = dict.valueForKey("xzblywsx") as! String
        if (ywsxArray.rangeOfString("xj") != nil) {
            XinJian1.selected = true
        }
        if (ywsxArray.rangeOfString("yzhd") != nil) {
            YouZhengHuiDui1.selected = true
        }
        if (ywsxArray.rangeOfString("mrdw") != nil) {
            MangRenDuWu1.selected = true
        }
        if (ywsxArray.rangeOfString("ysp") != nil) {
            YinShuaPin1.selected = true
        }
        if (ywsxArray.rangeOfString("bgs") != nil) {
            BaoGuo1.selected = true
        }
        if (ywsxArray.rangeOfString("gmlsyw") != nil) {
            LieShiBaoGuo1.selected = true
        }
        if (ywsxArray.rangeOfString("gjgdbkdfx") != nil) {
            GuoJiaGuiDingBaoKanDeFaXing1.selected = true
        }
        if (ywsxArray.rangeOfString("ywbpcxh") != nil) {
            YiWuBingXinHan1.selected = true
        }
        
        fuWuQuYu1.text = dict.valueForKey("tbhxbywyzyycsdfwqy") as! String
        diZhi1.text = dict.valueForKey("dz") as! String
        youBian1.text = dict.valueForKey("yzbm") as! String
        lianXiRenXingMing1.text = dict.valueForKey("lxrxm") as! String
        lianXiDianHua1.text = dict.valueForKey("lxdh") as! String

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
