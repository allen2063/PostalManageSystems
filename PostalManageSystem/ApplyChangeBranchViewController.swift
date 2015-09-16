//
//  ApplyChangeBranchViewController.swift
//  POST
//
//  Created by QiaoLibo on 15/9/3.
//  Copyright (c) 2015年 Qiaolibo. All rights reserved.
//

import UIKit

class ApplyChangeBranchViewController: UIViewController, UIActionSheetDelegate {
    @IBOutlet weak var applyChangeBranchInfoView: UIView!
    @IBOutlet weak var applyChangeBranchLocationView: UIView!
    @IBOutlet weak var SegmentedControl: UISegmentedControl!

    @IBAction func changeBranchSegmentedControlValueChanged(sender: AnyObject) {
        if let segmentedControl = sender as? UISegmentedControl {
            var index = segmentedControl.selectedSegmentIndex
            println("Index: \(index)")
            switch index {
            case 0:
                applyChangeBranchInfoView.hidden = false
                applyChangeBranchLocationView.hidden = true
                if let rootView = self.view as? UIScrollView {
                    rootView.contentSize = CGSize(width: 320, height: 1570)
                }
            case 1:
                applyChangeBranchInfoView.hidden = true
                applyChangeBranchLocationView.hidden = false
                if let rootView = self.view as? UIScrollView {
                    rootView.contentSize = CGSize(width: 320, height: 1779)
                }
            default:
                break;
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyChangeBranchLocationView.hidden = true
        if let rootView = self.view as? UIScrollView {
            rootView.contentSize = CGSize(width: 320, height: 1570)
            println("\(self.view.debugDescription)")
            // Do any additional setup after loading the view.
        }
    }
    
    @IBOutlet weak var mingChengBianGeng: UIButton! //名称变更
    @IBOutlet weak var jingYingShiJianBianGeng: UIButton! //经营时间变更
    @IBOutlet weak var jingYingFangShiBianGeng: UIButton! //经营方式变更
    @IBOutlet weak var changQuanXingZhiBianGeng: UIButton!  //产权性质变更
    @IBAction func touchInsideChooseChangeIssueBtn(sender: AnyObject) {
        if let sender = sender as? UIButton {
            if sender == mingChengBianGeng {
                if mingChengBianGeng.selected == false {
                    mingChengBianGeng.selected = true
//                    jingYingShiJianBianGeng.enabled = false
//                    jingYingFangShiBianGeng.enabled = false
//                    changQuanXingZhiBianGeng.enabled = false
                } else {
                    mingChengBianGeng.selected = false
//                    jingYingShiJianBianGeng.enabled = true
//                    jingYingFangShiBianGeng.enabled = true
//                    changQuanXingZhiBianGeng.enabled = true
                }
            }
        }
        if let sender = sender as? UIButton {
            if sender == jingYingShiJianBianGeng {
                if jingYingShiJianBianGeng.selected == false {
                    jingYingShiJianBianGeng.selected = true
//                    mingChengBianGeng.enabled = false
//                    jingYingFangShiBianGeng.enabled = false
//                    changQuanXingZhiBianGeng.enabled = false
                } else {
                    jingYingShiJianBianGeng.selected = false
//                    mingChengBianGeng.enabled = true
//                    jingYingFangShiBianGeng.enabled = true
//                    changQuanXingZhiBianGeng.enabled = true
                }
            }
        }
        if let sender = sender as? UIButton {
            if sender == jingYingFangShiBianGeng {
                if jingYingFangShiBianGeng.selected == false {
                    jingYingFangShiBianGeng.selected = true
//                    mingChengBianGeng.enabled = false
//                    jingYingShiJianBianGeng.enabled = false
//                    changQuanXingZhiBianGeng.enabled = false
                } else {
                    jingYingFangShiBianGeng.selected = false
//                    mingChengBianGeng.enabled = true
//                    jingYingShiJianBianGeng.enabled = true
//                    changQuanXingZhiBianGeng.enabled = true
                }
            }
        }
        if let sender = sender as? UIButton {
            if sender == changQuanXingZhiBianGeng {
                if changQuanXingZhiBianGeng.selected == false {
                    changQuanXingZhiBianGeng.selected = true
//                    mingChengBianGeng.enabled = false
//                    jingYingFangShiBianGeng.enabled = false
//                    jingYingFangShiBianGeng.enabled = false
                } else {
                    changQuanXingZhiBianGeng.selected = false
//                    mingChengBianGeng.enabled = true
//                    jingYingFangShiBianGeng.enabled = true
//                    jingYingFangShiBianGeng.enabled = true
                }
            }
        }
    }

    @IBOutlet weak var chooseJingYingFangShiBianGengQian: UILabel!
    @IBOutlet weak var chooseFangWuChangQuanBianGengQian: UILabel!
    
    @IBOutlet weak var chooseJIngYingFangShi: UILabel!
    @IBOutlet weak var chooseSuoZaiDiDian: UILabel!
    @IBOutlet weak var chooseFangWuChangQuan: UILabel!
    
    @IBOutlet weak var chooseJIngYingFangShi1: UILabel!
    @IBOutlet weak var chooseSuoZaiDiDian1: UILabel!
    @IBOutlet weak var chooseFangWuChangQuan1: UILabel!
    
    @IBOutlet weak var chooseJIngYingFangShi2: UILabel!
    @IBOutlet weak var chooseSuoZaiDiDian2: UILabel!
    @IBOutlet weak var chooseFangWuChangQuan2: UILabel!
    
    var tapedLabel = 0
    @IBAction func printActionSheet(sender: AnyObject) {
        if (sender as? UIGestureRecognizer != nil) {
            if sender.view == chooseJIngYingFangShi {
                let actionSheet = UIActionSheet(title: "选择经营方式", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自办", "委办")
                actionSheet.showInView(self.view)
                tapedLabel = 1
            }
            
            if sender.view == chooseSuoZaiDiDian {
                let actionSheet = UIActionSheet(title: "选择所在地点", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "城市地区","乡镇地区","农村地区")
                actionSheet.showInView(self.view)
                tapedLabel = 2
            }
            
            if sender.view == chooseFangWuChangQuan{
                let actionSheet = UIActionSheet(title: "选择房屋产权", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自有","租用","无偿使用","其他")
                actionSheet.showInView(self.view)
                tapedLabel = 3
            }
            
            if sender.view == chooseJingYingFangShiBianGengQian{
                let actionSheet = UIActionSheet(title: "选择经营方式", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自办","委办")
                actionSheet.showInView(self.view)
                tapedLabel = 4
            }
            
            if sender.view == chooseFangWuChangQuanBianGengQian{
                let actionSheet = UIActionSheet(title: "选择房屋产权", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自有","租用","无偿使用","其他")
                actionSheet.showInView(self.view)
                tapedLabel = 5
            }
        }
    }
    
    var tapedLabel1 = 0
    @IBAction func printActionSheet1(sender: AnyObject) {
        if (sender as? UIGestureRecognizer != nil) {
            if sender.view == chooseJIngYingFangShi1 {
                let actionSheet = UIActionSheet(title: "选择经营方式", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自办", "委办")
                actionSheet.showInView(self.view)
                tapedLabel1 = 1
            }
            
            if sender.view == chooseSuoZaiDiDian1 {
                let actionSheet = UIActionSheet(title: "选择所在地点", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "城市地区","乡镇地区","农村地区")
                actionSheet.showInView(self.view)
                tapedLabel1 = 2
            }
            
            if sender.view == chooseFangWuChangQuan1{
                let actionSheet = UIActionSheet(title: "选择房屋产权", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自有","租用","无偿使用","其他")
                actionSheet.showInView(self.view)
                tapedLabel1 = 3
            }
        }
    }

    var tapedLabel2 = 0
    @IBAction func printActionSheet2(sender: AnyObject) {
        if (sender as? UIGestureRecognizer != nil) {
            if sender.view == chooseJIngYingFangShi2 {
                let actionSheet = UIActionSheet(title: "选择经营方式", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自办", "委办")
                actionSheet.showInView(self.view)
                tapedLabel2 = 1
            }
            
            if sender.view == chooseSuoZaiDiDian2 {
                let actionSheet = UIActionSheet(title: "选择所在地点", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "城市地区","乡镇地区","农村地区")
                actionSheet.showInView(self.view)
                tapedLabel2 = 2
            }
            
            if sender.view == chooseFangWuChangQuan2{
                let actionSheet = UIActionSheet(title: "选择房屋产权", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "自有","租用","无偿使用","其他")
                actionSheet.showInView(self.view)
                tapedLabel2 = 3
            }
        }
    }

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet.buttonTitleAtIndex(buttonIndex) != "取消"{
            if  tapedLabel == 1 {
                chooseJIngYingFangShi.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseJIngYingFangShi.textColor = UIColor.blackColor()
            }
            if  tapedLabel1 == 1 {
                chooseJIngYingFangShi1.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseJIngYingFangShi1.textColor = UIColor.blackColor()
            }
            if  tapedLabel2 == 1 {
                chooseJIngYingFangShi2.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseJIngYingFangShi2.textColor = UIColor.blackColor()
            }
            
            if tapedLabel == 2 {
                chooseSuoZaiDiDian.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseSuoZaiDiDian.textColor = UIColor.blackColor()
            }
            if tapedLabel1 == 2 {
                chooseSuoZaiDiDian1.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseSuoZaiDiDian1.textColor = UIColor.blackColor()
            }
            if tapedLabel2 == 2 {
                chooseSuoZaiDiDian2.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseSuoZaiDiDian2.textColor = UIColor.blackColor()
            }
            
            if tapedLabel == 3{
                chooseFangWuChangQuan.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseFangWuChangQuan.textColor = UIColor.blackColor()
            }
            if tapedLabel1 == 3{
                chooseFangWuChangQuan1.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseFangWuChangQuan1.textColor = UIColor.blackColor()
            }
            if tapedLabel2 == 3{
                chooseFangWuChangQuan2.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseFangWuChangQuan2.textColor = UIColor.blackColor()
            }
            if tapedLabel == 4{
                chooseJingYingFangShiBianGengQian.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseJingYingFangShiBianGengQian.textColor = UIColor.blackColor()
            }
            if tapedLabel == 5{
                chooseFangWuChangQuanBianGengQian.text = actionSheet.buttonTitleAtIndex(buttonIndex)
                chooseFangWuChangQuanBianGengQian.textColor = UIColor.blackColor()
            }
        }
    }

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
    
    @IBOutlet weak var XinJian1: UIButton!
    @IBOutlet weak var WuLiu1: UIButton!
    @IBOutlet weak var JiYou1: UIButton!
    @IBOutlet weak var BaoGuo1: UIButton!
    @IBOutlet weak var YinShuaPin1: UIButton!
    @IBOutlet weak var BaoKanLingShou1: UIButton!
    @IBOutlet weak var YouZhengChuXu1: UIButton!
    @IBOutlet weak var MangRenDuWu1: UIButton!
    @IBOutlet weak var TeKuaiZhuangDi1: UIButton!
    @IBOutlet weak var BaoKanDingYue1: UIButton!
    @IBOutlet weak var YouZhengHuiDui1: UIButton!
    @IBOutlet weak var YIWuBingXinHan1: UIButton!
    @IBOutlet weak var LieShiBaoGuo1: UIButton!
    @IBOutlet weak var QiTa1: UIButton!
    
    @IBAction func touchInsideBtm1(sender: AnyObject) {
        
        if let sender = sender as? UIButton {
            if sender == XinJian1 {
                if XinJian1.selected == false {
                    XinJian1.selected = true
                } else {
                    XinJian1.selected = false
                }
            }
            
            if sender == WuLiu1 {
                if WuLiu1.selected == false {
                    WuLiu1.selected = true
                } else {
                    WuLiu1.selected = false
                }
                
            }
            if sender == JiYou1 {
                if JiYou1.selected == false {
                    JiYou1.selected = true
                } else {
                    JiYou1.selected = false
                }
                
            }
            if sender == BaoGuo1 {
                if BaoGuo1.selected == false {
                    BaoGuo1.selected = true
                } else {
                    BaoGuo1.selected = false
                }
                
            }
            if sender == YinShuaPin1 {
                if YinShuaPin1.selected == false {
                    YinShuaPin1.selected = true
                } else {
                    YinShuaPin1.selected = false
                }
            }
            if sender == BaoKanLingShou1 {
                if BaoKanLingShou1.selected == false {
                    BaoKanLingShou1.selected = true
                } else {
                    BaoKanLingShou1.selected = false
                }
                
            }
            if sender == YouZhengChuXu1 {
                if YouZhengChuXu1.selected == false {
                    YouZhengChuXu1.selected = true
                } else {
                    YouZhengChuXu1.selected = false
                }
                
            }
            if sender == MangRenDuWu1 {
                if MangRenDuWu1.selected == false {
                    MangRenDuWu1.selected = true
                } else {
                    MangRenDuWu1.selected = false
                }
                
            }
            if sender == TeKuaiZhuangDi1 {
                if TeKuaiZhuangDi1.selected == false {
                    TeKuaiZhuangDi1.selected = true
                } else {
                    TeKuaiZhuangDi1.selected = false
                }
                
            }
            if sender == BaoKanDingYue1 {
                if BaoKanDingYue1.selected == false {
                    BaoKanDingYue1.selected = true
                } else {
                    BaoKanDingYue1.selected = false
                }
                
            }
            if sender == YouZhengHuiDui1 {
                if YouZhengHuiDui1.selected == false {
                    YouZhengHuiDui1.selected = true
                } else {
                    YouZhengHuiDui1.selected = false
                }
                
            }
            if sender == YIWuBingXinHan1 {
                if YIWuBingXinHan1.selected == false {
                    YIWuBingXinHan1.selected = true
                } else {
                    YIWuBingXinHan1.selected = false
                }
                
            }
            if sender == LieShiBaoGuo1 {
                if LieShiBaoGuo1.selected == false {
                    LieShiBaoGuo1.selected = true
                } else {
                    LieShiBaoGuo1.selected = false
                }
                
            }
            if sender == QiTa1 {
                if QiTa1.selected == false {
                    QiTa1.selected = true
                } else {
                    QiTa1.selected = false
                }
            }
        }
    }

    @IBOutlet weak var XinJian2: UIButton!
    @IBOutlet weak var WuLiu2: UIButton!
    @IBOutlet weak var JiYou2: UIButton!
    @IBOutlet weak var BaoGuo2: UIButton!
    @IBOutlet weak var YinShuaPin2: UIButton!
    @IBOutlet weak var BaoKanLingShou2: UIButton!
    @IBOutlet weak var YouZhengChuXu2: UIButton!
    @IBOutlet weak var MangRenDuWu2: UIButton!
    @IBOutlet weak var TeKuaiZhuangDi2: UIButton!
    @IBOutlet weak var BaoKanDingYue2: UIButton!
    @IBOutlet weak var YouZhengHuiDui2: UIButton!
    @IBOutlet weak var YIWuBingXinHan2: UIButton!
    @IBOutlet weak var LieShiBaoGuo2: UIButton!
    @IBOutlet weak var QiTa2: UIButton!
    
    @IBAction func touchInsideBtm2(sender: AnyObject) {
        
        if let sender = sender as? UIButton {
            if sender == XinJian2 {
                if XinJian2.selected == false {
                    XinJian2.selected = true
                } else {
                    XinJian2.selected = false
                }
            }
            
            if sender == WuLiu2 {
                if WuLiu2.selected == false {
                    WuLiu2.selected = true
                } else {
                    WuLiu2.selected = false
                }
                
            }
            if sender == JiYou2 {
                if JiYou2.selected == false {
                    JiYou2.selected = true
                } else {
                    JiYou2.selected = false
                }
                
            }
            if sender == BaoGuo2 {
                if BaoGuo2.selected == false {
                    BaoGuo2.selected = true
                } else {
                    BaoGuo2.selected = false
                }
                
            }
            if sender == YinShuaPin2 {
                if YinShuaPin2.selected == false {
                    YinShuaPin2.selected = true
                } else {
                    YinShuaPin2.selected = false
                }
            }
            if sender == BaoKanLingShou2 {
                if BaoKanLingShou2.selected == false {
                    BaoKanLingShou2.selected = true
                } else {
                    BaoKanLingShou2.selected = false
                }
                
            }
            if sender == YouZhengChuXu2 {
                if YouZhengChuXu2.selected == false {
                    YouZhengChuXu2.selected = true
                } else {
                    YouZhengChuXu2.selected = false
                }
                
            }
            if sender == MangRenDuWu2 {
                if MangRenDuWu2.selected == false {
                    MangRenDuWu2.selected = true
                } else {
                    MangRenDuWu2.selected = false
                }
                
            }
            if sender == TeKuaiZhuangDi2 {
                if TeKuaiZhuangDi2.selected == false {
                    TeKuaiZhuangDi2.selected = true
                } else {
                    TeKuaiZhuangDi2.selected = false
                }
                
            }
            if sender == BaoKanDingYue2 {
                if BaoKanDingYue2.selected == false {
                    BaoKanDingYue2.selected = true
                } else {
                    BaoKanDingYue2.selected = false
                }
                
            }
            if sender == YouZhengHuiDui2 {
                if YouZhengHuiDui2.selected == false {
                    YouZhengHuiDui2.selected = true
                } else {
                    YouZhengHuiDui2.selected = false
                }
                
            }
            if sender == YIWuBingXinHan2 {
                if YIWuBingXinHan2.selected == false {
                    YIWuBingXinHan2.selected = true
                } else {
                    YIWuBingXinHan2.selected = false
                }
                
            }
            if sender == LieShiBaoGuo2 {
                if LieShiBaoGuo2.selected == false {
                    LieShiBaoGuo2.selected = true
                } else {
                    LieShiBaoGuo2.selected = false
                }
                
            }
            if sender == QiTa2 {
                if QiTa2.selected == false {
                    QiTa2.selected = true
                } else {
                    QiTa2.selected = false
                }
            }
        }
    }
    
    
    // 邮政营业场所备案信息变更登记表 TextField
    //变更前
    @IBOutlet weak var changSuoMingChengBianGengQian: UITextField!
    @IBOutlet weak var dengJiBianHaoBianGengQian: UITextField!
    @IBOutlet weak var bgqCangSuoDiZhiShi: UITextField!
    @IBOutlet weak var bgqCangSuoDiZhiXian: UITextField!
    @IBOutlet weak var bgqCangSuoDiZhiJie: UITextField!
    @IBOutlet weak var bgqCangSuoDiZhiHao: UITextField!
    @IBOutlet weak var bgqCangSuoDiZhiJingDu: UITextField!
    @IBOutlet weak var bgqCangSuoDiZhiWeiDu: UITextField!
    @IBOutlet weak var bgqShangJiDanWei: UITextField!
    @IBOutlet weak var bgqYouZhengBianMa: UITextField!
    @IBOutlet weak var bgqKaiYeShiJian: UITextField!
    @IBOutlet weak var bgqJianZhuMianJi: UITextField!
    
    @IBOutlet weak var bgqYingYeShiJianZhouJi: UITextField!
    @IBOutlet weak var bgqYingYeShiJianZhiZhouJi: UITextField!
    @IBOutlet weak var bgqYingYeShiJianJiDian: UITextField!
    @IBOutlet weak var bgqYingYeShiJianZhiJiDian: UITextField!
    
    @IBOutlet weak var bgqKaiXiangPinCi: UITextField!
    @IBOutlet weak var bgqZhouTouDiPinCi: UITextField!
    @IBOutlet weak var bgqRiTouDiPinCi: UITextField!
    
    //变更后
    @IBOutlet weak var bghChangSuoMingCheng: UITextField!
    @IBOutlet weak var bghChangSuoMingChengBianGengYuanYin: UITextField!
    
    @IBOutlet weak var bghYingYeShiJianZhouJi: UITextField!
    @IBOutlet weak var bghYingYeShiJianZhiZhouJi: UITextField!
    @IBOutlet weak var bghYingYeShiJianJiDian: UITextField!
    @IBOutlet weak var bghYingYeShiJianZhiJiDian: UITextField!
    @IBOutlet weak var bghYingYeShiJianBianGengYuanYin: UITextField!
    
    @IBOutlet weak var bghJingYingFangShiBianGengYuanYin: UITextField!
    
    @IBOutlet weak var bghFangWuChanQuanBianGengYuanYin: UITextField!
    
    @IBOutlet weak var bghChangSuoDiZhi: UITextField!
    @IBOutlet weak var bghChangSuoDiZhiBianGengYuanYin: UITextField!
    
    
    //邮政普遍服务营业场所就近迁址登记表 
    //迁址前
    @IBOutlet weak var qzqChangSuoMingCheng: UITextField!
    @IBOutlet weak var qzqDengJiBianHao: UITextField!
    
    @IBOutlet weak var qzqChangSuoDiZhiShi: UITextField!
    @IBOutlet weak var qzqChangSuoDiZhiXian: UITextField!
    @IBOutlet weak var qzqChangSuoDiZhiJie: UITextField!
    @IBOutlet weak var qzqChangSuoDiZhiHao: UITextField!
    @IBOutlet weak var qzqChangSuoDiZhiJingDu: UITextField!
    @IBOutlet weak var qzqChangSuoDiZhiWeiDu: UITextField!
    
    @IBOutlet weak var qzqShangJiDanWei: UITextField!
    @IBOutlet weak var qzqYouZhengBianMa: UITextField!
    @IBOutlet weak var qzqKaiYeShiJian: UITextField!
    @IBOutlet weak var qzqJianZhuMianJi: UITextField!
    
    @IBOutlet weak var qzqYingYeShiJianZhouJi: UITextField!
    @IBOutlet weak var qzqYingYeShiJianZhiZhouJi: UITextField!
    @IBOutlet weak var qzqYingYeShiJianJiDian: UITextField!
    @IBOutlet weak var qzqYingYeShiJianZhiJiDian: UITextField!
    
    @IBOutlet weak var qzqKaiXiangPinCi: UITextField!
    @IBOutlet weak var qzqZhouTouDiPinCi: UITextField!
    @IBOutlet weak var qzqRiTouDiPinCi: UITextField!
    
    @IBOutlet weak var qzqQianZhiYuanYin: UITextField!
    
    //迁址后
    @IBOutlet weak var qzhChangSuoDiZhiShi: UITextField!
    @IBOutlet weak var qzhChangSuoDiZhiXian: UITextField!
    @IBOutlet weak var qzhChangSuoDiZhiJie: UITextField!
    @IBOutlet weak var qzhChangSuoDiZhiHao: UITextField!
    @IBOutlet weak var qzhChangSuoDiZhiJingDu: UITextField!
    @IBOutlet weak var qzhChangSuoDiZhiWeiDu: UITextField!
    @IBOutlet weak var qzhYuYuanZhiZhiXianJuLi: UITextField!
    
    @IBOutlet weak var qzhyouZhengBianMa: UITextField!
    @IBOutlet weak var qzhKaiYeShiJian: UITextField!
    @IBOutlet weak var qzhJianZhuMianJi: UITextField!
    
    @IBOutlet weak var qzhYingYeShiJianZhouJi: UITextField!
    @IBOutlet weak var qzhYingYeShiJianZhiZhouJi: UITextField!
    @IBOutlet weak var qzhYingYeShiJianJiDian: UITextField!
    @IBOutlet weak var qzhYingYeShiJianZhiJiDian: UITextField!
    
    @IBOutlet weak var qzhKaiXiangPinCi: UITextField!
    @IBOutlet weak var qzhZhouTouDiPinCi: UITextField!
    @IBOutlet weak var qzhRiTouDiPinCi: UITextField!
    
    
    //变更Commit
    @IBAction func commit(sender: AnyObject) {
        //变更前
        var infoOfYzqyyzyycsbaxxbgdjb = InfoOfYzqyyzyycsbaxxbgdjb()
        if mingChengBianGeng.selected {
            infoOfYzqyyzyycsbaxxbgdjb.bgsx += ",mcbg"
        }
        if jingYingShiJianBianGeng.selected {
            infoOfYzqyyzyycsbaxxbgdjb.bgsx += ",yysjbg"
        }
        if  jingYingFangShiBianGeng.selected {
            infoOfYzqyyzyycsbaxxbgdjb.bgsx += ",jyfsbg"
        }
        if  changQuanXingZhiBianGeng.selected {
            infoOfYzqyyzyycsbaxxbgdjb.bgsx += ",cqxzbg"
        }
        
        infoOfYzqyyzyycsbaxxbgdjb.csmc_bgq = changSuoMingChengBianGengQian.text
        infoOfYzqyyzyycsbaxxbgdjb.djbh_bgq = dengJiBianHaoBianGengQian.text
        infoOfYzqyyzyycsbaxxbgdjb.csdz_bgq_s = bgqCangSuoDiZhiShi.text
        infoOfYzqyyzyycsbaxxbgdjb.csdz_bgq_xqs = bgqCangSuoDiZhiXian.text
        infoOfYzqyyzyycsbaxxbgdjb.csdz_bgq_jx = bgqCangSuoDiZhiJie.text
        infoOfYzqyyzyycsbaxxbgdjb.csdz_bgq_h = bgqCangSuoDiZhiHao.text
        infoOfYzqyyzyycsbaxxbgdjb.csdz_bgq_jd = bgqCangSuoDiZhiJingDu.text
        infoOfYzqyyzyycsbaxxbgdjb.csdz_bgq_wd = bgqCangSuoDiZhiWeiDu.text
        
        infoOfYzqyyzyycsbaxxbgdjb.sjdw_bgq = bgqShangJiDanWei.text
        
        //infoOfYzqyyzyycsbaxxbgdjb.jyfs_bgq = chooseJingYingFangShiBianGengQian.text
        if (chooseJingYingFangShiBianGengQian.text == "自办")  {
            infoOfYzqyyzyycsbaxxbgdjb.jyfs_bgq = "zb"
        }
        if(chooseJingYingFangShiBianGengQian.text == "委办") {
            infoOfYzqyyzyycsbaxxbgdjb.jyfs_bgq = "wb"
        }

        
        infoOfYzqyyzyycsbaxxbgdjb.yzbm_bgq  = bgqYouZhengBianMa.text
        
        //infoOfYzqyyzyycsbaxxbgdjb.szdy_bgq = chooseSuoZaiDiDian.text
        if (chooseSuoZaiDiDian.text == "城市地区")  {
            infoOfYzqyyzyycsbaxxbgdjb.szdy_bgq = "csdq"
        }
        if(chooseSuoZaiDiDian.text == "乡镇地区") {
            infoOfYzqyyzyycsbaxxbgdjb.szdy_bgq = "xzdq"
        }
        if(chooseSuoZaiDiDian.text == "农村地区") {
            infoOfYzqyyzyycsbaxxbgdjb.szdy_bgq = "ncdq"
        }

        
        infoOfYzqyyzyycsbaxxbgdjb.kysj_bgq = bgqKaiYeShiJian.text
        
        //infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgq = chooseFangWuChangQuanBianGengQian.text
        if (chooseFangWuChangQuanBianGengQian.text == "自有")  {
             infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgq = "ziy"
        }
        if(chooseFangWuChangQuanBianGengQian.text == "租用") {
            infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgq = "zuy"
        }
        if (chooseFangWuChangQuanBianGengQian.text == "无偿使用")  {
             infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgq = "wucsy"
        }
        if(chooseFangWuChangQuanBianGengQian.text == "其他") {
             infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgq = "qt"
        }
        
        infoOfYzqyyzyycsbaxxbgdjb.jzmj_bgq = bgqJianZhuMianJi.text
        
        infoOfYzqyyzyycsbaxxbgdjb.zyyr_bgq_ks = bgqYingYeShiJianZhouJi.text
        infoOfYzqyyzyycsbaxxbgdjb.zyyr_bgq_js = bgqYingYeShiJianZhiZhouJi.text
        infoOfYzqyyzyycsbaxxbgdjb.ryysj_bgq_ks = bgqYingYeShiJianJiDian.text
        infoOfYzqyyzyycsbaxxbgdjb.ryysj_bgq_js = bgqYingYeShiJianZhiJiDian.text
        
        infoOfYzqyyzyycsbaxxbgdjb.kxpc_bgq = bgqKaiXiangPinCi.text
        infoOfYzqyyzyycsbaxxbgdjb.rtdpc_bgq = bgqRiTouDiPinCi.text
        infoOfYzqyyzyycsbaxxbgdjb.ztdpc_bgq = bgqZhouTouDiPinCi.text
        
        if XinJian.selected {
            if infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq == "" {
                infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += "xj"
            } else {
                infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",xj"
            }
        }
        if WuLiu.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",wl"
        }
        if JiYou.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",jy"
        }
        if BaoGuo.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",bgs"
        }
        if YinShuaPin.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",ysp"
        }
        if BaoKanLingShou.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",bkls"
        }
        if YouZhengChuXu.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",yzcx"
        }
        if MangRenDuWu.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",mrdw"
        }
        if TeKuaiZhuangDi.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",tkzd"
        }
        if BaoKanDingYue.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",bkdy"
        }
        if YouZhengHuiDui.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",yzhd"
        }
        if YIWuBingXinHan.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",ywbxh"
        }
        if LieShiBaoGuo.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",lsywbg"
        }
        if QiTa.selected {
            infoOfYzqyyzyycsbaxxbgdjb.ywfw_bgq += ",qt"
        }

        //变更后
        infoOfYzqyyzyycsbaxxbgdjb.csmc_bgh = bghChangSuoMingCheng.text
        infoOfYzqyyzyycsbaxxbgdjb.bgyy_bghcsmc = bghChangSuoMingChengBianGengYuanYin.text
        infoOfYzqyyzyycsbaxxbgdjb.zyyr_bgh_ks = bghYingYeShiJianZhouJi.text
        infoOfYzqyyzyycsbaxxbgdjb.zyyr_bgh_js = bghYingYeShiJianZhiZhouJi.text
        infoOfYzqyyzyycsbaxxbgdjb.ryysj_bgh_ks = bghYingYeShiJianJiDian.text
        infoOfYzqyyzyycsbaxxbgdjb.ryysj_bgh_js = bghYingYeShiJianZhiJiDian.text
        infoOfYzqyyzyycsbaxxbgdjb.bgyy_bghyysj = bghYingYeShiJianBianGengYuanYin.text
        
        //infoOfYzqyyzyycsbaxxbgdjb.jyfs_bgh = chooseJIngYingFangShi.text
        if (chooseJIngYingFangShi.text == "自办")  {
            infoOfYzqyyzyycsbaxxbgdjb.jyfs_bgh = "zb"
        }
        if(chooseJIngYingFangShi.text == "委办") {
            infoOfYzqyyzyycsbaxxbgdjb.jyfs_bgh = "wb"
        }
        
        infoOfYzqyyzyycsbaxxbgdjb.bgyy_bghjyfs = bghJingYingFangShiBianGengYuanYin.text
        
        //infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgh = chooseFangWuChangQuan.text
        if (chooseFangWuChangQuan.text == "自有")  {
            infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgh = "ziy"
        }
        if(chooseFangWuChangQuan.text == "租用") {
            infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgh = "zuy"
        }
        if (chooseFangWuChangQuan.text == "无偿使用")  {
            infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgh = "wucsy"
        }
        if(chooseFangWuChangQuan.text == "其他") {
            infoOfYzqyyzyycsbaxxbgdjb.fwcq_bgh = "qt"
        }
        
        infoOfYzqyyzyycsbaxxbgdjb.bgyy_bghfwcq = bghFangWuChanQuanBianGengYuanYin.text
        infoOfYzqyyzyycsbaxxbgdjb.csdz_bgh = bghChangSuoDiZhi.text
        infoOfYzqyyzyycsbaxxbgdjb.bgyy_bghcsmc = bghChangSuoDiZhiBianGengYuanYin.text
        
        println("\(ClassToJSON.getObjectData(infoOfYzqyyzyycsbaxxbgdjb))")
    }
    
    //迁址Commit
    @IBAction func commit2(sender: AnyObject) {
        var infoOfYzpbfwyycsjjqzdjb = InfoOfYzpbfwyycsjjqzdjb()
        infoOfYzpbfwyycsjjqzdjb.csmc_qzq = qzqChangSuoMingCheng.text
        infoOfYzpbfwyycsjjqzdjb.djbh_qzq = qzqDengJiBianHao.text
        infoOfYzpbfwyycsjjqzdjb.csdz_qzq_s = qzqChangSuoDiZhiShi.text
        infoOfYzpbfwyycsjjqzdjb.csdz_qzq_xqs = qzqChangSuoDiZhiXian.text
        infoOfYzpbfwyycsjjqzdjb.csdz_qzq_jx = qzqChangSuoDiZhiJie.text
        infoOfYzpbfwyycsjjqzdjb.csdz_qzq_h = qzqChangSuoDiZhiHao.text
        
        infoOfYzpbfwyycsjjqzdjb.sjdw_qzq = qzqShangJiDanWei.text
        infoOfYzpbfwyycsjjqzdjb.yzbm_qzq = qzqYouZhengBianMa.text
        
        //infoOfYzpbfwyycsjjqzdjb.jyfs_qzq = chooseJIngYingFangShi1.text
        if (chooseJIngYingFangShi1.text == "自办")  {
            infoOfYzpbfwyycsjjqzdjb.jyfs_qzq = "zb"
        }
        if(chooseJIngYingFangShi1.text == "委办") {
            infoOfYzpbfwyycsjjqzdjb.jyfs_qzq = "wb"
        }
        
        //infoOfYzpbfwyycsjjqzdjb.fwcq_qzq = chooseFangWuChangQuan1.text
        if (chooseFangWuChangQuan1.text == "自有")  {
            infoOfYzpbfwyycsjjqzdjb.fwcq_qzq = "ziy"
        }
        if(chooseFangWuChangQuan1.text == "租用") {
            infoOfYzpbfwyycsjjqzdjb.fwcq_qzq = "zuy"
        }
        if (chooseFangWuChangQuan1.text == "无偿使用")  {
            infoOfYzpbfwyycsjjqzdjb.fwcq_qzq = "wucsy"
        }
        if(chooseFangWuChangQuan1.text == "其他") {
            infoOfYzpbfwyycsjjqzdjb.fwcq_qzq = "qt"
        }

        //infoOfYzpbfwyycsjjqzdjb.szdy_qzq = chooseSuoZaiDiDian1.text
        if (chooseSuoZaiDiDian1.text == "城市地区")  {
            infoOfYzpbfwyycsjjqzdjb.szdy_qzq = "csdq"
        }
        if(chooseSuoZaiDiDian1.text == "乡镇地区") {
            infoOfYzpbfwyycsjjqzdjb.szdy_qzq = "xzdq"
        }
        if(chooseSuoZaiDiDian1.text == "农村地区") {
            infoOfYzpbfwyycsjjqzdjb.szdy_qzq = "ncdq"
        }

        
        
        infoOfYzpbfwyycsjjqzdjb.kysj_qzq = qzqKaiYeShiJian.text
        infoOfYzpbfwyycsjjqzdjb.jzmj_qzq = qzqJianZhuMianJi.text
        
        infoOfYzpbfwyycsjjqzdjb.zyyr_qzq_ks = qzqYingYeShiJianZhouJi.text
        infoOfYzpbfwyycsjjqzdjb.zyyr_qzq_js = qzqYingYeShiJianZhiZhouJi.text
        infoOfYzpbfwyycsjjqzdjb.ryysj_qzq_ks = qzqYingYeShiJianJiDian.text
        infoOfYzpbfwyycsjjqzdjb.ryysj_qzq_js = qzqYingYeShiJianZhiJiDian.text
        
        infoOfYzpbfwyycsjjqzdjb.kxpc_qzq = qzqKaiXiangPinCi.text
        infoOfYzpbfwyycsjjqzdjb.rtdpc_qzq = qzqZhouTouDiPinCi.text
        infoOfYzpbfwyycsjjqzdjb.ztdpc_qzq = qzqRiTouDiPinCi.text
        
        if XinJian1.selected {
            if infoOfYzpbfwyycsjjqzdjb.ywfw_qzq == "" {
                infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += "xj"
            } else {
                infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",xj"
            }
        }
        if WuLiu1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",wl"
        }
        if JiYou1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",jy"
        }
        if BaoGuo1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",bgs"
        }
        if YinShuaPin1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",ysp"
        }
        if BaoKanLingShou1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",bkls"
        }
        if YouZhengChuXu1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",yzcx"
        }
        if MangRenDuWu1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",mrdw"
        }
        if TeKuaiZhuangDi1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",tkzd"
        }
        if BaoKanDingYue1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",bkdy"
        }
        if YouZhengHuiDui1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",yzhd"
        }
        if YIWuBingXinHan1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",ywbxh"
        }
        if LieShiBaoGuo1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",lsywbg"
        }
        if QiTa1.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzq += ",qt"
        }

        infoOfYzpbfwyycsjjqzdjb.qzyy_qzq = qzqQianZhiYuanYin.text
        
        //迁址后
        infoOfYzpbfwyycsjjqzdjb.csdz_qzh_s = qzhChangSuoDiZhiShi.text
        infoOfYzpbfwyycsjjqzdjb.csdz_qzh_xqs = qzhChangSuoDiZhiXian.text
        infoOfYzpbfwyycsjjqzdjb.csdz_qzh_jx = qzhChangSuoDiZhiJie.text
        infoOfYzpbfwyycsjjqzdjb.csdz_qzh_h = qzhChangSuoDiZhiHao.text
        
        infoOfYzpbfwyycsjjqzdjb.yyzzxjl_qzh = qzhYuYuanZhiZhiXianJuLi.text
        
        //infoOfYzpbfwyycsjjqzdjb.jyfs_qzh = chooseJIngYingFangShi2.text
        if (chooseJIngYingFangShi2.text == "自办")  {
            infoOfYzpbfwyycsjjqzdjb.jyfs_qzh = "zb"
        }
        if(chooseJIngYingFangShi2.text == "委办") {
            infoOfYzpbfwyycsjjqzdjb.jyfs_qzh = "wb"
        }
        
        infoOfYzpbfwyycsjjqzdjb.yzbm_qzh = qzhyouZhengBianMa.text
        
        //infoOfYzpbfwyycsjjqzdjb.szdy_qzh = chooseSuoZaiDiDian2.text
        if (chooseSuoZaiDiDian2.text == "城市地区")  {
            infoOfYzpbfwyycsjjqzdjb.szdy_qzh = "csdq"
        }
        if(chooseSuoZaiDiDian2.text == "乡镇地区") {
            infoOfYzpbfwyycsjjqzdjb.szdy_qzh = "xzdq"
        }
        if(chooseSuoZaiDiDian2.text == "农村地区") {
            infoOfYzpbfwyycsjjqzdjb.szdy_qzh = "ncdq"
        }
        
        infoOfYzpbfwyycsjjqzdjb.kysj_qzh = qzhKaiYeShiJian.text
        
        //infoOfYzpbfwyycsjjqzdjb.fwcq_qzh = chooseFangWuChangQuan2.text
        if (chooseFangWuChangQuan2.text == "自有")  {
            infoOfYzpbfwyycsjjqzdjb.fwcq_qzh = "ziy"
        }
        if(chooseFangWuChangQuan2.text == "租用") {
            infoOfYzpbfwyycsjjqzdjb.fwcq_qzh = "zuy"
        }
        if (chooseFangWuChangQuan2.text == "无偿使用")  {
            infoOfYzpbfwyycsjjqzdjb.fwcq_qzh = "wucsy"
        }
        if(chooseFangWuChangQuan2.text == "其他") {
            infoOfYzpbfwyycsjjqzdjb.fwcq_qzh = "qt"
        }
        
        infoOfYzpbfwyycsjjqzdjb.jzmj_qzh = qzhJianZhuMianJi.text
        
        infoOfYzpbfwyycsjjqzdjb.zyyr_qzh_ks = qzhYingYeShiJianZhouJi.text
        infoOfYzpbfwyycsjjqzdjb.zyyr_qzh_js = qzhYingYeShiJianZhiZhouJi.text
        infoOfYzpbfwyycsjjqzdjb.ryysj_qzh_ks = qzhYingYeShiJianJiDian.text
        infoOfYzpbfwyycsjjqzdjb.ryysj_qzh_js = qzhYingYeShiJianZhiJiDian.text
        
        infoOfYzpbfwyycsjjqzdjb.kxpc_qzh = qzhKaiXiangPinCi.text
        infoOfYzpbfwyycsjjqzdjb.rtdpc_qzh = qzhZhouTouDiPinCi.text
        infoOfYzpbfwyycsjjqzdjb.ztdpc_qzh = qzhRiTouDiPinCi.text
        
        if XinJian2.selected {
            if infoOfYzpbfwyycsjjqzdjb.ywfw_qzh == "" {
                infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += "xj"
            } else {
                infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",xj"
            }
        }
        if WuLiu2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",wl"
        }
        if JiYou2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",jy"
        }
        if BaoGuo2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",bgs"
        }
        if YinShuaPin2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",ysp"
        }
        if BaoKanLingShou2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",bkls"
        }
        if YouZhengChuXu2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",yzcx"
        }
        if MangRenDuWu2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",mrdw"
        }
        if TeKuaiZhuangDi2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",tkzd"
        }
        if BaoKanDingYue2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",bkdy"
        }
        if YouZhengHuiDui2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",yzhd"
        }
        if YIWuBingXinHan2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",ywbxh"
        }
        if LieShiBaoGuo2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",lsywbg"
        }
        if QiTa2.selected {
            infoOfYzpbfwyycsjjqzdjb.ywfw_qzh += ",qt"
        }

        println("\(ClassToJSON.getObjectData(infoOfYzpbfwyycsjjqzdjb))")
    }
    
    func initBianGeng(dict: NSDictionary, segmentedControlIndex index:Int)
    {
        if index == 0 {
           initBianGengXinXi(dict)
        } else if index == 1{
            initBianGengQianZhi(dict)
        }
    }
    
    func initBianGengXinXi(dict: NSDictionary) {
        //segmentedControl预选定
        SegmentedControl.selectedSegmentIndex = 0
        applyChangeBranchInfoView.hidden = false
        applyChangeBranchLocationView.hidden = true
        if let rootView = self.view as? UIScrollView {
            rootView.contentSize = CGSize(width: 320, height: 1570)
            
        //属性预置
            if (dict.valueForKey("bgsx") as! String == "mcbg")   {
                mingChengBianGeng.selected = true
            }
            if(dict.valueForKey("bgsx") as! String == "yysjbg") {
                jingYingShiJianBianGeng.selected = true
            }
            if (dict.valueForKey("bgsx") as! String == "jyfsbg")   {
                jingYingFangShiBianGeng.selected = true
            }
            if(dict.valueForKey("bgsx") as! String == "cqxzbg") {
                changQuanXingZhiBianGeng.selected = true
            }
            
            changSuoMingChengBianGengQian.text = dict.valueForKey("csmc_bgq") as! String
            dengJiBianHaoBianGengQian.text = dict.valueForKey("djbh_bgq") as! String
            bgqCangSuoDiZhiShi.text = dict.valueForKey("csdz_bgq_s") as! String
            bgqCangSuoDiZhiXian.text = dict.valueForKey("csdz_bgq_xqs") as! String
            bgqCangSuoDiZhiJie.text = dict.valueForKey("csdz_bgq_jx") as! String
            bgqCangSuoDiZhiHao.text = dict.valueForKey("csdz_bgq_h") as! String
            bgqCangSuoDiZhiJingDu.text = dict.valueForKey("csdz_bgq_jd") as! String
            bgqCangSuoDiZhiWeiDu.text = dict.valueForKey("csdz_bgq_wd") as! String
            
            bgqShangJiDanWei.text = dict.valueForKey("sjdw_bgq") as! String

            if (dict.valueForKey("jyfs_bgq") as! String == "zb")   {
                chooseJingYingFangShiBianGengQian.text = "自办"
            }
            if(dict.valueForKey("jyfs_bgq") as! String == "wb") {
                chooseJingYingFangShiBianGengQian.text = "委办"
            }
            
            bgqYouZhengBianMa.text = dict.valueForKey("yzbm_bgq") as! String
            
            if(dict.valueForKey("szdy_bgq") as! String == "csdq") {
                chooseSuoZaiDiDian.text = "城市地区"
            }
            if (dict.valueForKey("szdy_bgq") as! String == "xzdq")   {
                chooseSuoZaiDiDian.text = "乡镇地区"
            }
            if(dict.valueForKey("szdy_bgq") as! String == "ncdq") {
                chooseSuoZaiDiDian.text = "农村地区"
            }
            
            bgqKaiYeShiJian.text = dict.valueForKey("kysj_bgq") as! String
            
            if (dict.valueForKey("fwcq_bgq") as! String == "ziy")   {
                chooseFangWuChangQuanBianGengQian.text = "自有"
            }
            if(dict.valueForKey("fwcq_bgq") as! String == "zuy") {
                chooseFangWuChangQuanBianGengQian.text = "租用"
            }
            if (dict.valueForKey("fwcq_bgq") as! String == "wucsy")   {
                chooseFangWuChangQuanBianGengQian.text = "无偿使用"
            }
            if(dict.valueForKey("fwcq_bgq") as! String == "qt") {
                chooseFangWuChangQuanBianGengQian.text = "其他"
            }
            
            bgqJianZhuMianJi.text = dict.valueForKey("jzmj_bgq") as! String
            
            bgqYingYeShiJianZhouJi.text = dict.valueForKey("zyyr_bgq_ks") as! String
            bgqYingYeShiJianZhiZhouJi.text = dict.valueForKey("zyyr_bgq_js") as! String
            bgqYingYeShiJianJiDian.text = dict.valueForKey("ryysj_bgq_ks") as! String
            bgqYingYeShiJianZhiJiDian.text = dict.valueForKey("ryysj_bgq_js") as! String
            
            bgqKaiXiangPinCi.text = dict.valueForKey("kxpc_bgq") as! String
            bgqRiTouDiPinCi.text = dict.valueForKey("rtdpc_bgq") as! String
            bgqZhouTouDiPinCi.text = dict.valueForKey("ztdpc_bgq") as! String
            
            var ywsxArray = dict.valueForKey("ywfw_bgq") as! String
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
        
            //变更后
            bghChangSuoMingCheng.text = dict.valueForKey("csmc_bgh") as! String
            bghChangSuoMingChengBianGengYuanYin.text = dict.valueForKey("bgyy_bghcsmc") as! String
            bghYingYeShiJianZhouJi.text = dict.valueForKey("zyyr_bgh_ks") as! String
            bghYingYeShiJianZhiZhouJi.text = dict.valueForKey("zyyr_bgh_js") as! String
            bghYingYeShiJianJiDian.text = dict.valueForKey("ryysj_bgh_ks") as! String
            bghYingYeShiJianZhiJiDian.text = dict.valueForKey("ryysj_bgh_js") as! String
            bghYingYeShiJianBianGengYuanYin.text = dict.valueForKey("bgyy_bghyysj") as! String
            
            if (dict.valueForKey("jyfs_bgh") as! String == "zb")   {
                chooseJIngYingFangShi.text = "自办"
            }
            if(dict.valueForKey("jyfs_bgh") as! String == "wb") {
                chooseJIngYingFangShi.text = "委办"
            }

            bghJingYingFangShiBianGengYuanYin.text = dict.valueForKey("bgyy_bghjyfs") as! String

            if (dict.valueForKey("fwcq_bgh") as! String == "ziy")   {
                chooseFangWuChangQuan.text = "自有"
            }
            if(dict.valueForKey("fwcq_bgh") as! String == "zuy") {
                chooseFangWuChangQuan.text = "租用"
            }
            if (dict.valueForKey("fwcq_bgh") as! String == "wucsy")   {
                chooseFangWuChangQuan.text = "无偿使用"
            }
            if(dict.valueForKey("fwcq_bgh") as! String == "qt") {
                chooseFangWuChangQuan.text = "其他"
            }
            
            bghFangWuChanQuanBianGengYuanYin.text = dict.valueForKey("bgyy_bghfwcq") as! String
            bghChangSuoDiZhi.text = dict.valueForKey("csdz_bgh") as! String
            bghChangSuoDiZhiBianGengYuanYin.text = dict.valueForKey("bgyy_bghcsmc") as! String
        }
}
    
    
    func initBianGengQianZhi(dict: NSDictionary) {
        //segmentedControl预选定
        SegmentedControl.selectedSegmentIndex = 1
        applyChangeBranchInfoView.hidden = true
        applyChangeBranchLocationView.hidden = false
        if let rootView = self.view as? UIScrollView {
            rootView.contentSize = CGSize(width: 320, height: 1779)
            
         //属性预置
         //迁址前
        qzqChangSuoMingCheng.text = dict.valueForKey("csmc_qzq") as! String
        qzqDengJiBianHao.text = dict.valueForKey("djbh_qzq") as! String
        qzqChangSuoDiZhiShi.text = dict.valueForKey("csdz_qzq_s") as! String
        qzqChangSuoDiZhiXian.text = dict.valueForKey("csdz_qzq_xqs") as! String
        qzqChangSuoDiZhiJie.text = dict.valueForKey("csdz_qzq_jx") as! String
        qzqChangSuoDiZhiHao.text = dict.valueForKey("csdz_qzq_h") as! String
        
        qzqShangJiDanWei.text = dict.valueForKey("sjdw_qzq") as! String
        
        qzqYouZhengBianMa.text = dict.valueForKey("yzbm_qzq") as! String

        if (dict.valueForKey("jyfs_qzq") as! String == "zb")   {
            chooseJIngYingFangShi1.text = "自办"
        }
        if(dict.valueForKey("jyfs_qzq") as! String == "wb") {
            chooseJIngYingFangShi1.text = "委办"
        }
        
        if (dict.valueForKey("fwcq_qzq") as! String == "ziy")   {
            chooseFangWuChangQuan1.text = "自有"
        }
        if(dict.valueForKey("fwcq_qzq") as! String == "zuy") {
            chooseFangWuChangQuan1.text = "租用"
        }
        if (dict.valueForKey("fwcq_qzq") as! String == "wucsy")   {
            chooseFangWuChangQuan1.text = "无偿使用"
        }
        if(dict.valueForKey("fwcq_qzq") as! String == "qt") {
            chooseFangWuChangQuan1.text = "其他"
        }
        
        if(dict.valueForKey("szdy_qzq") as! String == "csdq") {
            chooseSuoZaiDiDian1.text = "城市地区"
        }
        if (dict.valueForKey("szdy_qzq") as! String == "xzdq")   {
            chooseSuoZaiDiDian1.text = "乡镇地区"
        }
        if(dict.valueForKey("szdy_qzq") as! String == "ncdq") {
            chooseSuoZaiDiDian1.text = "农村地区"
        }
        
        qzqKaiYeShiJian.text = dict.valueForKey("kysj_qzq") as! String
        qzqJianZhuMianJi.text = dict.valueForKey("jzmj_qzq") as! String
        
        qzqYingYeShiJianZhouJi.text = dict.valueForKey("zyyr_qzq_ks") as! String
        qzqYingYeShiJianZhiZhouJi.text = dict.valueForKey("zyyr_qzq_js") as! String
        qzqYingYeShiJianJiDian.text = dict.valueForKey("ryysj_qzq_ks") as! String
        qzqYingYeShiJianZhiJiDian.text = dict.valueForKey("ryysj_qzq_js") as! String
        
        qzqKaiXiangPinCi.text = dict.valueForKey("kxpc_qzq") as! String
        qzqZhouTouDiPinCi.text = dict.valueForKey("rtdpc_qzq") as! String
        qzqRiTouDiPinCi.text = dict.valueForKey("ztdpc_qzq") as! String
    
        var ywsxArray1 = dict.valueForKey("ywfw_qzq") as! String
        if (ywsxArray1.rangeOfString("xj") != nil) {
            XinJian1.selected = true
        }
        if (ywsxArray1.rangeOfString("wl") != nil) {
            WuLiu1.selected = true
        }
        if (ywsxArray1.rangeOfString("jy") != nil) {
            JiYou1.selected = true
        }
        if (ywsxArray1.rangeOfString("bgs") != nil) {
            BaoGuo1.selected = true
        }
        if (ywsxArray1.rangeOfString("ysp") != nil) {
            YinShuaPin1.selected = true
        }
        if (ywsxArray1.rangeOfString("bkls") != nil) {
            BaoKanLingShou1.selected = true
        }
        if (ywsxArray1.rangeOfString("yzcx") != nil) {
            YouZhengChuXu1.selected = true
        }
        if (ywsxArray1.rangeOfString("ywfw") != nil) {
            MangRenDuWu1.selected = true
        }
        if (ywsxArray1.rangeOfString("tkzd") != nil) {
            TeKuaiZhuangDi1.selected = true
        }
        if (ywsxArray1.rangeOfString("bkdy") != nil) {
            BaoKanDingYue1.selected = true
        }
        if (ywsxArray1.rangeOfString("yzhd") != nil) {
            YouZhengHuiDui1.selected = true
        }
        if (ywsxArray1.rangeOfString("ywbxh") != nil) {
            YIWuBingXinHan1.selected = true
        }
        if (ywsxArray1.rangeOfString("lsywbg") != nil) {
            LieShiBaoGuo1.selected = true
        }
        if (ywsxArray1.rangeOfString("qt") != nil) {
            QiTa1.selected = true
        }

        qzqQianZhiYuanYin.text = dict.valueForKey("qzyy_qzq") as! String
        
        //迁址后
        qzhChangSuoDiZhiShi.text = dict.valueForKey("csdz_qzh_s") as! String
        qzhChangSuoDiZhiXian.text = dict.valueForKey("csdz_qzh_xqs") as! String
        qzhChangSuoDiZhiJie.text = dict.valueForKey("csdz_qzh_jx") as! String
        qzhChangSuoDiZhiHao.text = dict.valueForKey("csdz_qzh_h") as! String
        
        qzhYuYuanZhiZhiXianJuLi.text = dict.valueForKey("yyzzxjl_qzh") as! String
        
        if (dict.valueForKey("jyfs_qzh") as! String == "zb")   {
            chooseJIngYingFangShi2.text = "自办"
        }
        if(dict.valueForKey("jyfs_qzh") as! String == "wb") {
            chooseJIngYingFangShi2.text = "委办"
        }
        
        if(dict.valueForKey("szdy_qzh") as! String == "csdq") {
            chooseSuoZaiDiDian2.text = "城市地区"
        }
        if (dict.valueForKey("szdy_qzh") as! String == "xzdq")   {
            chooseSuoZaiDiDian2.text = "乡镇地区"
        }
        if(dict.valueForKey("szdy_qzh") as! String == "ncdq") {
            chooseSuoZaiDiDian2.text = "农村地区"
        }
        
        qzhKaiYeShiJian.text = dict.valueForKey("kysj_qzh") as! String
        
        if (dict.valueForKey("fwcq_qzh") as! String == "ziy")   {
            chooseFangWuChangQuan2.text = "自有"
        }
        if(dict.valueForKey("fwcq_qzh") as! String == "zuy") {
            chooseFangWuChangQuan2.text = "租用"
        }
        if (dict.valueForKey("fwcq_qzh") as! String == "wucsy")   {
            chooseFangWuChangQuan2.text = "无偿使用"
        }
        if(dict.valueForKey("fwcq_qzh") as! String == "qt") {
            chooseFangWuChangQuan2.text = "其他"
        }
        
        qzhJianZhuMianJi.text = dict.valueForKey("jzmj_qzh") as! String
        
        qzhYingYeShiJianZhouJi.text = dict.valueForKey("zyyr_qzh_ks") as! String
        qzhYingYeShiJianZhiZhouJi.text = dict.valueForKey("zyyr_qzh_js") as! String
        qzhYingYeShiJianJiDian.text = dict.valueForKey("ryysj_qzh_ks") as! String
        qzhYingYeShiJianZhiJiDian.text = dict.valueForKey("ryysj_qzh_js") as! String
        
        qzhKaiXiangPinCi.text = dict.valueForKey("kxpc_qzh") as! String
        qzhZhouTouDiPinCi.text = dict.valueForKey("rtdpc_qzh") as! String
        qzhRiTouDiPinCi.text = dict.valueForKey("ztdpc_qzh") as! String
        
        var ywsxArray2 = dict.valueForKey("ywfw_qzh") as! String
        if (ywsxArray2.rangeOfString("xj") != nil) {
            XinJian2.selected = true
        }
        if (ywsxArray2.rangeOfString("wl") != nil) {
            WuLiu2.selected = true
        }
        if (ywsxArray2.rangeOfString("jy") != nil) {
            JiYou2.selected = true
        }
        if (ywsxArray2.rangeOfString("bgs") != nil) {
            BaoGuo2.selected = true
        }
        if (ywsxArray2.rangeOfString("ysp") != nil) {
            YinShuaPin2.selected = true
        }
        if (ywsxArray2.rangeOfString("bkls") != nil) {
            BaoKanLingShou2.selected = true
        }
        if (ywsxArray2.rangeOfString("yzcx") != nil) {
            YouZhengChuXu2.selected = true
        }
        if (ywsxArray2.rangeOfString("ywfw") != nil) {
            MangRenDuWu2.selected = true
        }
        if (ywsxArray2.rangeOfString("tkzd") != nil) {
            TeKuaiZhuangDi2.selected = true
        }
        if (ywsxArray2.rangeOfString("bkdy") != nil) {
            BaoKanDingYue2.selected = true
        }
        if (ywsxArray2.rangeOfString("yzhd") != nil) {
            YouZhengHuiDui2.selected = true
        }
        if (ywsxArray2.rangeOfString("ywbxh") != nil) {
            YIWuBingXinHan2.selected = true
        }
        if (ywsxArray2.rangeOfString("lsywbg") != nil) {
            LieShiBaoGuo2.selected = true
        }
        if (ywsxArray2.rangeOfString("qt") != nil) {
            QiTa2.selected = true
        }
    }
}
}