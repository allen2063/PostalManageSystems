//
//  ApplyAddBranchViewController.swift
//  POST
//
//  Created by QiaoLibo on 15/9/6.
//  Copyright (c) 2015年 Qiaolibo. All rights reserved.
//

import UIKit

class ApplyAddBranchViewController: UIViewController, UIActionSheetDelegate {
    
    @IBOutlet weak var chooseShiXiang: UILabel!
    @IBOutlet weak var chooseJingYingFangShi: UILabel!
    @IBOutlet weak var chooseFangWuChangQuan: UILabel!
    @IBOutlet weak var chooseSheZhiDiYu: UILabel!
    @IBOutlet weak var chooseMenQianYouTong: UILabel!

    var tapedLabel = 0
    @IBAction func printActionSheet(sender: AnyObject) {
        if (sender as? UIGestureRecognizer != nil) {
            if sender.view == chooseShiXiang {
                let actionSheet = UIActionSheet(title: "选择事项", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "设置邮政普遍服务营业场所", "设置其他营业场所")
                actionSheet.showInView(self.view)
                tapedLabel = 1
            }
            
            if sender.view == chooseJingYingFangShi {
                let actionSheet = UIActionSheet(title: "选择经营方式", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自办","委办")
                actionSheet.showInView(self.view)
                tapedLabel = 2
            }
            
            if sender.view == chooseFangWuChangQuan {
                let actionSheet = UIActionSheet(title: "选择房屋产权", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自有","租用","无偿使用","其他")
                actionSheet.showInView(self.view)
                tapedLabel = 3
            }
            
            if sender.view == chooseSheZhiDiYu {
                let actionSheet = UIActionSheet(title: "选择地域", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "城市地区","乡镇地区","农村地区")
                actionSheet.showInView(self.view)
                tapedLabel = 4
            }
            
            if sender.view == chooseMenQianYouTong {
                let actionSheet = UIActionSheet(title: "选择有无门前邮筒", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "有","无")
                actionSheet.showInView(self.view)
                tapedLabel = 5
            }
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet.buttonTitleAtIndex(buttonIndex) != "取消"{
            if  tapedLabel == 1 {
                chooseShiXiang.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseShiXiang.textColor = UIColor.blackColor()
            }
            
            if tapedLabel == 2 {
                chooseJingYingFangShi.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseJingYingFangShi.textColor = UIColor.blackColor()
            }
            
            if tapedLabel == 3 {
                chooseFangWuChangQuan.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseFangWuChangQuan.textColor = UIColor.blackColor()
            }
            
            if tapedLabel == 4 {
                chooseSheZhiDiYu.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseSheZhiDiYu.textColor = UIColor.blackColor()
            }
            
            if tapedLabel == 5 {
                chooseMenQianYouTong.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseMenQianYouTong.textColor = UIColor.blackColor()
            }
        }
    }

    //TextField
    @IBOutlet weak var changSuoMingCheng: UITextField!
    @IBOutlet weak var shi: UITextField!    //场所地址市
    @IBOutlet weak var xian: UITextField!   //场所地址县
    @IBOutlet weak var jieDao: UITextField! //场所地址街道
    @IBOutlet weak var menPaiHao: UITextField! //场所地址门牌号
    @IBOutlet weak var jingDu: UITextField! //场所地址经度
    @IBOutlet weak var weiDu: UITextField!  //场所地址纬度
    @IBOutlet weak var youBian: UITextField!  //场所地址邮编
    @IBOutlet weak var shangJiDanWei: UITextField!
    @IBOutlet weak var cangSuoFuZeRen: UITextField!
    @IBOutlet weak var lianXiDianHua: UITextField!
    @IBOutlet weak var kaiYeShiJian: UITextField!
    @IBOutlet weak var jianZhuMianJi: UITextField!
    @IBOutlet weak var yingYeShiJianZhouJi: UITextField!
    @IBOutlet weak var yingYeShiJianZhiZhouJi: UITextField!
    @IBOutlet weak var yingYeShiJianJiDian: UITextField!
    @IBOutlet weak var yingYeShiJianZhiJiDian: UITextField!
    @IBOutlet weak var zhouKaiQuTianShu: UITextField!
    @IBOutlet weak var riKaiQuPinCi: UITextField!
    @IBOutlet weak var fuWuQuYu: UITextField!
    @IBOutlet weak var zhouTouDiTianShu: UITextField!
    @IBOutlet weak var riTouDiPinCi: UITextField!
    @IBOutlet weak var fuWuBanJing: UITextField!
    @IBOutlet weak var fuWuRenKou: UITextField!
    
    
    @IBOutlet weak var XinJian: UIButton!
    @IBOutlet weak var WuLiu: UIButton!
    @IBOutlet weak var JiYou: UIButton!
    @IBOutlet weak var BaoGuo: UIButton!
    @IBOutlet weak var YinShuaPin: UIButton!
    @IBOutlet weak var BaoKanLingShou: UIButton!
    @IBOutlet weak var YouZhengChuXu: UIButton!
    @IBOutlet weak var MangRenDuWu: UIButton!
    @IBOutlet weak var TeKuaiZhuangDi: UIButton!
    @IBOutlet weak var BaoKanDingYue: UIButton!
    @IBOutlet weak var YouZhengHuiDui: UIButton!
    @IBOutlet weak var YIWuBingXinHan: UIButton!
    @IBOutlet weak var LieShiBaoGuo: UIButton!
    @IBOutlet weak var QiTa: UIButton!
    
    @IBAction func touchInsideBtm(sender: AnyObject) {
        
        if let sender = sender as? UIButton {
            if sender == XinJian {
                if XinJian.selected == false {
                    XinJian.selected = true
                } else {
                    XinJian.selected = false
                }
            }
            
            if sender == WuLiu {
                if WuLiu.selected == false {
                    WuLiu.selected = true
                } else {
                    WuLiu.selected = false
                }
                
            }
            if sender == JiYou {
                if JiYou.selected == false {
                    JiYou.selected = true
                } else {
                    JiYou.selected = false
                }
                
            }
            if sender == BaoGuo {
                if BaoGuo.selected == false {
                    BaoGuo.selected = true
                } else {
                    BaoGuo.selected = false
                }
                
            }
            if sender == YinShuaPin {
                if YinShuaPin.selected == false {
                    YinShuaPin.selected = true
                } else {
                    YinShuaPin.selected = false
                }
            }
            if sender == BaoKanLingShou {
                if BaoKanLingShou.selected == false {
                    BaoKanLingShou.selected = true
                } else {
                    BaoKanLingShou.selected = false
                }
                
            }
            if sender == YouZhengChuXu {
                if YouZhengChuXu.selected == false {
                    YouZhengChuXu.selected = true
                } else {
                    YouZhengChuXu.selected = false
                }
                
            }
            if sender == MangRenDuWu {
                if MangRenDuWu.selected == false {
                    MangRenDuWu.selected = true
                } else {
                    MangRenDuWu.selected = false
                }
                
            }
            if sender == TeKuaiZhuangDi {
                if TeKuaiZhuangDi.selected == false {
                    TeKuaiZhuangDi.selected = true
                } else {
                    TeKuaiZhuangDi.selected = false
                }
                
            }
            if sender == BaoKanDingYue {
                if BaoKanDingYue.selected == false {
                    BaoKanDingYue.selected = true
                } else {
                    BaoKanDingYue.selected = false
                }
                
            }
            if sender == YouZhengHuiDui {
                if YouZhengHuiDui.selected == false {
                    YouZhengHuiDui.selected = true
                } else {
                    YouZhengHuiDui.selected = false
                }
                
            }
            if sender == YIWuBingXinHan {
                if YIWuBingXinHan.selected == false {
                    YIWuBingXinHan.selected = true
                } else {
                    YIWuBingXinHan.selected = false
                }
                
            }
            if sender == LieShiBaoGuo {
                if LieShiBaoGuo.selected == false {
                    LieShiBaoGuo.selected = true
                } else {
                    LieShiBaoGuo.selected = false
                }
                
            }
            if sender == QiTa {
                if QiTa.selected == false {
                    QiTa.selected = true
                } else {
                    QiTa.selected = false
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func commit(sender: AnyObject) {
        var infoOfYzqyszyzyycsdjb = InfoOfYzqyszyzyycsdjb()
        if (chooseShiXiang.text == "设置邮政普遍服务营业场所")  {
            infoOfYzqyszyzyycsdjb.sx = "szyzpbfwyycs"
        }
        if(chooseShiXiang.text == "设置其他营业场所") {
            infoOfYzqyszyzyycsdjb.sx = "szqtyzyycs"
        }
        
        if (chooseJingYingFangShi.text == "自办")  {
            infoOfYzqyszyzyycsdjb.jyfs = "zb"
        }
        if(chooseJingYingFangShi.text == "委办") {
            infoOfYzqyszyzyycsdjb.jyfs = "wb"
        }
        
        if (chooseFangWuChangQuan.text == "自有")  {
            infoOfYzqyszyzyycsdjb.fwcq = "ziy"
        }
        if(chooseFangWuChangQuan.text == "租用") {
            infoOfYzqyszyzyycsdjb.fwcq = "zuy"
        }
        if (chooseFangWuChangQuan.text == "无偿使用")  {
            infoOfYzqyszyzyycsdjb.fwcq = "wucsy"
        }
        if(chooseFangWuChangQuan.text == "其他") {
            infoOfYzqyszyzyycsdjb.fwcq = "qt"
        }
        
        if (chooseSheZhiDiYu.text == "城市地区")  {
            infoOfYzqyszyzyycsdjb.szdy = "csdq"
        }
        if(chooseSheZhiDiYu.text == "乡镇地区") {
            infoOfYzqyszyzyycsdjb.szdy = "xzdq"
        }
        if(chooseSheZhiDiYu.text == "农村地区") {
            infoOfYzqyszyzyycsdjb.szdy = "ncdq"
        }
        
        if (chooseMenQianYouTong.text == "有")  {
            infoOfYzqyszyzyycsdjb.mqyt = "y"
        }
        if(chooseMenQianYouTong.text == "无") {
            infoOfYzqyszyzyycsdjb.mqyt = "w"
        }
        
        infoOfYzqyszyzyycsdjb.yzyycsmc = changSuoMingCheng.text
        infoOfYzqyszyzyycsdjb.csdz_s = shi.text
        infoOfYzqyszyzyycsdjb.csdz_xqs = xian.text
        infoOfYzqyszyzyycsdjb.csdz_jx = jieDao.text
        infoOfYzqyszyzyycsdjb.csdz_h = menPaiHao.text
        infoOfYzqyszyzyycsdjb.csdz_jd = jingDu.text
        infoOfYzqyszyzyycsdjb.csdz_wd = weiDu.text
        
        infoOfYzqyszyzyycsdjb.yzbm = youBian.text
        infoOfYzqyszyzyycsdjb.sjdw = shangJiDanWei.text
        infoOfYzqyszyzyycsdjb.yycsfzr = cangSuoFuZeRen.text
        infoOfYzqyszyzyycsdjb.lxdh = lianXiDianHua.text
        
        infoOfYzqyszyzyycsdjb.kysj = kaiYeShiJian.text

        infoOfYzqyszyzyycsdjb.jzmj = jianZhuMianJi.text
        infoOfYzqyszyzyycsdjb.zyyr_ks = yingYeShiJianZhouJi.text
        infoOfYzqyszyzyycsdjb.zyyr_js = yingYeShiJianZhiZhouJi.text
        infoOfYzqyszyzyycsdjb.ryysj_ks = yingYeShiJianJiDian.text
        infoOfYzqyszyzyycsdjb.ryysj_js = yingYeShiJianZhiJiDian.text
        
        
        infoOfYzqyszyzyycsdjb.zkqts = zhouKaiQuTianShu.text
        infoOfYzqyszyzyycsdjb.rkqpc = riKaiQuPinCi.text
        
        infoOfYzqyszyzyycsdjb.fwqy  = fuWuQuYu.text

        infoOfYzqyszyzyycsdjb.ztdts = zhouTouDiTianShu.text
        infoOfYzqyszyzyycsdjb.rtdpc = riTouDiPinCi.text
        
        infoOfYzqyszyzyycsdjb.fwbj = fuWuBanJing.text
        infoOfYzqyszyzyycsdjb.fwrk = fuWuRenKou.text
        
        if XinJian.selected {
            infoOfYzqyszyzyycsdjb.ywfw += "xj"
        }
        if WuLiu.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",wl"
        }
        if JiYou.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",jy"
        }
        if BaoGuo.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",bgs"
        }
        if YinShuaPin.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",ysp"
        }
        if BaoKanLingShou.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",bkls"
        }
        if YouZhengChuXu.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",yzcx"
        }
        if MangRenDuWu.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",mrdw"
        }
        if TeKuaiZhuangDi.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",tkzd"
        }
        if BaoKanDingYue.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",bkdy"
        }
        if YouZhengHuiDui.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",yzhd"
        }
        if YIWuBingXinHan.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",ywbxh"
        }
        if LieShiBaoGuo.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",lsywbg"
        }
        if QiTa.selected {
            infoOfYzqyszyzyycsdjb.ywfw += ",qt"
        }
        
        println("\(infoOfYzqyszyzyycsdjb.ywfw)")
        println("\(ClassToJSON.getObjectData(infoOfYzqyszyzyycsdjb))")
    }
    
    func initTingZhi(dict: NSDictionary) {

        if (dict.valueForKey("sx") as! String == "szyzpbfwyycs")   {
            chooseShiXiang.text = "设置邮政普遍服务营业场所"
        }
        if(dict.valueForKey("sx") as! String == "szqtyzyycs") {
            chooseShiXiang.text = "设置其他营业场所"
        }
        
        if (dict.valueForKey("jyfs") as! String == "zb")   {
            chooseJingYingFangShi.text = "自办"
        }
        if(dict.valueForKey("jyfs") as! String == "wb") {
            chooseJingYingFangShi.text = "委办"
        }
        
        if (dict.valueForKey("fwcq") as! String == "ziy")   {
            chooseFangWuChangQuan.text = "自有"
        }
        if(dict.valueForKey("fwcq") as! String == "zuy") {
            chooseFangWuChangQuan.text = "租用"
        }
        if (dict.valueForKey("fwcq") as! String == "wucsy")   {
            chooseFangWuChangQuan.text = "无偿使用"
        }
        if(dict.valueForKey("fwcq") as! String == "qt") {
            chooseFangWuChangQuan.text = "其他"
        }
        
        if(dict.valueForKey("szdy") as! String == "csdq") {
            chooseSheZhiDiYu.text = "城市地区"
        }
        if (dict.valueForKey("szdy") as! String == "xzdq")   {
            chooseSheZhiDiYu.text = "乡镇地区"
        }
        if(dict.valueForKey("szdy") as! String == "ncdq") {
            chooseSheZhiDiYu.text = "农村地区"
        }
        
        if (dict.valueForKey("mqyt") as! String == "y")   {
            chooseMenQianYouTong.text = "有"
        }
        if(dict.valueForKey("mqyt") as! String == "w") {
            chooseMenQianYouTong.text = "无"
        }
        
        changSuoMingCheng.text = dict.valueForKey("yzyycsmc") as! String
        shi.text = dict.valueForKey("csdz_s") as! String
        xian.text = dict.valueForKey("csdz_xqs") as! String
        jieDao.text = dict.valueForKey("csdz_jx") as! String
        menPaiHao.text = dict.valueForKey("csdz_h") as! String
        jingDu.text = dict.valueForKey("csdz_jd") as! String
        weiDu.text = dict.valueForKey("csdz_wd") as! String
        
        youBian.text = dict.valueForKey("yzbm") as! String
        shangJiDanWei.text = dict.valueForKey("sjdw") as! String
        cangSuoFuZeRen.text = dict.valueForKey("yycsfzr") as! String
        lianXiDianHua.text = dict.valueForKey("lxdh") as! String
        
        kaiYeShiJian.text = dict.valueForKey("kysj") as! String
        
        jianZhuMianJi.text = dict.valueForKey("jzmj") as! String
        yingYeShiJianZhouJi.text = dict.valueForKey("zyyr_ks") as! String
        yingYeShiJianZhiZhouJi.text = dict.valueForKey("zyyr_js") as! String
        yingYeShiJianJiDian.text = dict.valueForKey("sryysj_ksx") as! String
        yingYeShiJianZhiJiDian.text = dict.valueForKey("ryysj_js") as! String
        
        
        zhouKaiQuTianShu.text = dict.valueForKey("zkqts") as! String
        riKaiQuPinCi.text = dict.valueForKey("rkqpc") as! String
        
        fuWuQuYu.text = dict.valueForKey("fwqy") as! String
        
        zhouTouDiTianShu.text = dict.valueForKey("ztdts") as! String
        riTouDiPinCi.text = dict.valueForKey("rtdpc") as! String
        
        fuWuBanJing.text = dict.valueForKey("fwbj") as! String
        fuWuRenKou.text = dict.valueForKey("fwrk") as! String

        var ywsxArray = dict.valueForKey("ywfw") as! String
        if (ywsxArray.rangeOfString("xj") != nil) {
            XinJian.selected = true
        }
        if (ywsxArray.rangeOfString("wl") != nil) {
            WuLiu.selected = true
        }
        if (ywsxArray.rangeOfString("jy") != nil) {
            JiYou.selected = true
        }
        if (ywsxArray.rangeOfString("bgs") != nil) {
            BaoGuo.selected = true
        }
        if (ywsxArray.rangeOfString("ysp") != nil) {
            YinShuaPin.selected = true
        }
        if (ywsxArray.rangeOfString("bkls") != nil) {
            BaoKanLingShou.selected = true
        }
        if (ywsxArray.rangeOfString("yzcx") != nil) {
            YouZhengChuXu.selected = true
        }
        if (ywsxArray.rangeOfString("ywfw") != nil) {
            MangRenDuWu.selected = true
        }
        if (ywsxArray.rangeOfString("tkzd") != nil) {
            TeKuaiZhuangDi.selected = true
        }
        if (ywsxArray.rangeOfString("bkdy") != nil) {
            BaoKanDingYue.selected = true
        }
        if (ywsxArray.rangeOfString("yzhd") != nil) {
            YouZhengHuiDui.selected = true
        }
        if (ywsxArray.rangeOfString("ywbxh") != nil) {
            YIWuBingXinHan.selected = true
        }
        if (ywsxArray.rangeOfString("lsywbg") != nil) {
            LieShiBaoGuo.selected = true
        }
        if (ywsxArray.rangeOfString("qt") != nil) {
            QiTa.selected = true
        }
        
    }
}
