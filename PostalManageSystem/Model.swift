//
//  Model.swift
//  POST
//
//  Created by QiaoLibo on 15/9/5.
//  Copyright (c) 2015年 Qiaolibo. All rights reserved.
//

import Foundation
class ChangeUserInfo : NSObject{
    var bianGengShiXiang: String?
    var changSuoMingCheng: String?
    var dengJiBianHao: String?
    var changSuoDiZhi: String?
    var shangJiDanWei: String?
    var youZhengBianMa: String?
}

//class yeWuFanWeiItems : NSObject {
//    //业务范围所需的字符串
//    var XinJian: String?
//    var WuLiu: String?
//    var JiYou: String?
//    var BaoGuo: String?
//    var YinShuaPin: String?
//    var BaoKanLingShou: String?
//    var YouZhengChuXu: String?
//    var MangRenDuWu: String?
//    var TeKuaiZhuangDi: String?
//    var BaoKanDingYue: String?
//    var YouZhengHuiDui: String?
//    var YIWuBingXinHan: String?
//    var LieShiBaoGuo: String?
//    var QiTa: String?
//}
//@objc(ApplyAddBranch)
class ApplyAddBranch : NSObject{
    var shiXiang: String?
    var jingYingFangShi: String?
    var fangWuChanQuan: String?
    var changSuoMingCheng: String?
    var shi: String?    //场所地址市
    var xian: String?   //场所地址县
    var jieDao: String? //场所地址街道
    var menPaiHao: String? //场所地址门牌号
    var jingDu: String? //场所地址经度
    var weiDu: String?  //场所地址纬度
    var youBian: String?  //场所地址邮编
    var shangJiDanWei: String?
    var cangSuoFuZeRen: String?
    var lianXiDianHua: String?
    var sheZhiDiYu: String?
    var kaiYeShiJian: String?
    var jianZhuMianJi: String?
    var menQianYouTong: String?
    var zhouKaiQuTianShu: String?
    var riTouDiPinCi: String?
    var fuWuBanJing: String?
    var fuWuRenKou: String?
    
    var yeWuFanWei: [String?] = []
    
    var fenGongSi: String?
}

class ApplyResignBranch : NSObject {
//    撤销申请书
    var shiYouZhengGuanLiJu: String?
    var shenQinCheXiaoYuanYin: String?
    var cheXiaoShiJian: String?
    var cheXiaoWeiZhi_Shi: String?
    var cheXiaoWeiZhi_Xian: String?
    var cheXiaoWeiZhi_Jie: String?
    var cheXiaoWeiZhi_ChangSuo: String?
    var niCaiQuCuoShi: String?
    var yuanFuWuShuiPing: String?
    
//    撤销基本情况表
    var changSuoMingCheng: String?
    var jingYingFangShi: String?
    var cheXiaoDiZhi_Shi: String?
    var cheXiaoDiZhi_Xian: String?
    var cheXiaoDiZhi_Jie: String?
    var cheXiaoDiZhi_Hao: String?
    var cheXiaoDiZhi_JingDu: String?
    var cheXiaoDiZhi_WeiDu: String?
    var youZhengBianMa: String?
    var shangJiDanWei: String?
    var lianXiDianHua: String?
    var yingYeChangSuoFuZeRen: String?
    var fuWuBanJing: String?
    var fuWuRenKou: String?
    var suoZaiDiDian: String?
    var kaiYeShiJian: String?
    var fangWuChanQuan: String?
    var jianZhuMianJi: String?
    var yingYeShiJian_ZhouJi: String?
    var yingYeShiJian_ZhiZhouJi: String?
    var riYingYeShiJian_JiDian: String?
    var riYingYeShiJian_ZhiJiDian: String?
    var kaiXiangPinCi: String?
    var riTouDiPinCi: String?
    var zhouTouDiPinCi: String?
    
    var yeWuFanWei: [String?] = []
    
    var jinYiNianShouRu: String?
    var zongShouRu: String?
    var zongShouRu_XinJian: String?
    var zongShouRu_BaoGuo: String?
    var zongShouRu_YinShuaPin: String?
    var zongShouRu_HuiDui: String?
    var zongShouRu_BaoKan: String?
    var zongShouRu_DaiLiYeWu: String?
    var zongShouRu_QiTa: String?
    
    var yeWuLiang_HanJian: String?
    var yeWuLiang_BaoGuo: String?
    var yeWuLiang_YinShuaPin: String?
    var yeWuLiang_HuiDui: String?
    var yeWuLiang_BaoKan: String?
    var yeWuLiang_QiTa: String?
    
    var shenQingRiQi: String?
    
}

/**
*
* @ClassName: InfoOfYzqyszyzyycsdjb
* @Description: 邮政企业设置邮政营业场所登记表
* @author LY
* @date 2015-7-31 下午5:02:48
*
*/
class InfoOfYzqyszyzyycsdjb: NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var sx: String?; // 事项   (szyzpbfwyycs,szqtyzyycs)
    var yzyycsmc: String?; // 邮政营业场所名称
    var jyfs: String?; // 经营方式 (zb,wb)
    var csdz_s: String?; // 场所地址_市
    var csdz_xqs: String?; // 场所地址_县区市
    var csdz_jx: String?; // 场所地址_街乡
    var csdz_h: String?; // 场所地址_号
    var csdz_jd: String?; // 场所地址_经度
    var csdz_wd: String?; // 场所地址_纬度
    
    var yzbm: String?; //邮政编码
    var sjdw: String?; // 上级单位
    var yycsfzr: String?; //营业场所负责人
    var lxdh: String?; // 联系电话
    var szdy: String?; // 设置地域 (csdq,xzdq,ncdq)
    var kysj: String?; // 开业时间
    var fwcq: String?; // 房屋产权 (ziy,zuy,wucsy,qt)
    var jzmj: String?; // 建筑面积
    
    var zyyr_ks: String?; // 周营业日_开始
    var zyyr_js: String?; // 周营业日_结束
    var ryysj_ks: String?; // 日营业时间_开始
    var ryysj_js: String?; // 日营业时间_结束
    
    var mqyt: String?; // 门前邮筒 (y,w)
    
    var zkqts: String?; // 周开取天数
    var rkqpc: String?; // 日开取频次
    
    var fwqy: String?; // 服务区域
    
    var ztdts: String?; // 周投递天数
    var rtdpc: String?; // 日投递频次
    
    var fwbj: String?; // 服务半径
    var fwrk: String?; // 服务人口
    
    var ywfw: String = ""; // 业务范围信件  (xj,ysp,bg,yzhd,qt,bkdy,ywbxh,mrdw,lsywbg,yzcx,tkzd,jy,wl,bkls)
    //	var String ywfwxj; // 业务范围信件
    //	var String ywfwysp; // 业务范围印刷品
    //	var String ywfwbg; // 业务范围包裹
    //	var String ywfwyzhd; // 业务范围邮政汇兑
    //	var String ywfwbkqt; // 业务范围其它
    //	var String ywfwbkdy; // 业务范围报刊订阅
    //	var String ywfwywbxh; // 业务范围义务兵信函
    //	var String ywfwmrdw; // 业务范围盲人读物
    //	var String ywfwlsywbg; // 业务范围烈士遗物包裹
    //	var String ywfwcx; // 业务范围邮政储蓄
    //	var String ywfwtkzd; // 业务范围特快专递
    //	var String ywfwjy; // 业务范围集邮
    //	var String ywfwwl; // 业务范围物流
    //	var String ywfwbkls; // 业务范围报刊零售
    
    //营业日戳戳样、投递日戳戳样是在提交表单时上传的两个图片附件。
    var yyrccy: String?; // 营业日戳戳样
    var tdrccy: String?; // 投递日戳戳样
    
    var sjhzsdjyzfgsfzrqz: String?; // 省级或者市地级邮政分公司负责人签章
    var sjhzsdjyzfgsfzrqzsj: String?; // 省级或者市地级邮政分公司负责人签章时间
    var yzglbmdjxx: String?; // 邮政管理部门登记信息
    var djbh: String?; // 登记编号
    var jbr: String?; // 经办人
    var yzglbmdjxxsj: String?	; // 邮政管理部门登记信息时间
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfYzqyyzyycsbaxxbgdjb
* @Description: 邮政营业场所备案信息变更登记表
* @author LY
* @date 2015-7-31 下午8:02:24
*
*/
class InfoOfYzqyyzyycsbaxxbgdjb : NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state:Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var bgsx: String = ""; // 变更事项
    var csmc_bgq: String?; // 场所名称_变更前
    var djbh_bgq: String?; // 登记编号_变更前
    var csdz_bgq_s: String?; // 场所地址_变更前_市
    var csdz_bgq_xqs: String?; // 场所地址_变更前_县区市
    var csdz_bgq_jx: String?; // 场所地址_变更前_街乡
    var csdz_bgq_h: String?; // 场所地址_变更前_号
    var csdz_bgq_jd: String?; // 场所地址_变更前_经度
    var csdz_bgq_wd: String?; // 场所地址_变更前_纬度
    
    var sjdw_bgq: String?; // 上级单位_变更前
    var jyfs_bgq: String?; // 经营方式_变更前
    var yzbm_bgq: String?; // 邮政编码_变更前
    var szdy_bgq: String?; // 设置地域_变更前
    var kysj_bgq: String?; // 开业时间_变更前
    var fwcq_bgq: String?; // 房屋产权_变更前
    var jzmj_bgq: String?; // 建筑面积_变更前
    
    var zyyr_bgq_ks: String?; // 周营业日_变更前_开始
    var zyyr_bgq_js: String?; // 周营业日_变更前_结束
    var ryysj_bgq_ks: String?; // 日营业时间_变更前_开始
    var ryysj_bgq_js: String?; // 日营业时间_变更前_结束
    
    var kxpc_bgq: String?; // 开箱频次_变更前
    var rtdpc_bgq: String?; // 日投递频次_变更前
    var ztdpc_bgq: String?; // 周投递频次_变更前
    
    var ywfw_bgq: String = ""; // 业务范围_变更前
    //	var String ywfwxj_bgq; // 业务范围信件_变更前
    //	var String ywfwysp_bgq; // 业务范围印刷品_变更前
    //	var String ywfwbg_bgq; // 业务范围包裹_变更前
    //	var String ywfwyzhd_bgq; // 业务范围邮政汇兑_变更前
    //	var String ywfwqt_bgq; // 业务范围其它_变更前
    //	var String ywfwbkdy_bgq; // 业务范围报刊订阅_变更前
    //	var String ywfwywbxh_bgq; // 业务范围义务兵信函_变更前
    //	var String ywfwmrdw_bgq; // 业务范围盲人读物_变更前
    //	var String ywfwlsywbg_bgq; // 业务范围烈士遗物包裹_变更前
    //	var String ywfwcx_bgq; // 业务范围邮政储蓄_变更前
    //	var String ywfwtkzd_bgq; // 业务范围特快专递_变更前
    //	var String ywfwjy_bgq; // 业务范围集邮_变更前
    //	var String ywfwwl_bgq; // 业务范围物流_变更前
    //	var String ywfwbkls_bgq; // 业务范围报刊零售_变更前
    
    var csmc_bgh: String?; // 场所名称_变更后
    var bgyy_bghcsmc: String?; // 变更原因_变更后场所名称
    
    var zyyr_bgh_ks: String?; // 周营业日_变更后_开始
    var zyyr_bgh_js: String?; // 周营业日_变更后_结束
    var ryysj_bgh_ks: String?; // 日营业时间_变更后_开始
    var ryysj_bgh_js: String?; // 日营业时间_变更后_结束
    var bgyy_bghyysj: String?; // 变更原因_变更后营业时间
    
    var jyfs_bgh: String?; // 经营方式_变更后
    var bgyy_bghjyfs: String?; // 变更原因_变更后营业方式
    var fwcq_bgh: String?; // 房屋产权_变更后
    var bgyy_bghfwcq: String?; // 变更原因_变更后房屋产权
    
    var csdz_bgh: String?; // 场所地址_变更后
    var bgyy_bghcsdz: String?; // 变更原因_变更后场所地址
    
    var sjhzsdjyzfgsfzrqz: String?; //省级或者市地级邮政分公司负责人签章
    var sjhzsdjyzfgsfzrqzsj: String?; //省级或者市地级邮政分公司负责人签章时间
    var yzglbmdjxx: String?; //邮政管理部门登记信息
    var djbh: String?; //登记编号
    var jbr: String?; //经办人
    var yzglbmdjxxsj: String?; //邮政管理部门登记信息时间
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfYzpbfwyycsjjqzdjb
* @Description: 邮政普遍服务营业场所就近迁址登记表
* @author LY
* @date 2015-7-31 下午8:47:41
*
*/
class InfoOfYzpbfwyycsjjqzdjb: NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var csmc_qzq: String?; // 场所名称_迁址前
    var djbh_qzq: String?; // 登记编号_迁址前
    var csdz_qzq_s: String?; // 场所地址_迁址前_市
    var csdz_qzq_xqs: String?; // 场所地址_迁址前_县区市
    var csdz_qzq_jx: String?; // 场所地址_迁址前_街乡
    var csdz_qzq_h: String?; // 场所地址_迁址前_号
    
    var sjdw_qzq: String?; // 上级单位_迁址前
    var jyfs_qzq: String?; // 经营方式_迁址前
    var yzbm_qzq: String?; // 邮政编码_迁址前
    var szdy_qzq: String?; // 设置地域_迁址前
    var kysj_qzq: String?; // 开业时间_迁址前
    var fwcq_qzq: String?; // 房屋产权_迁址前
    var jzmj_qzq: String?; // 建筑面积_迁址前
    
    var zyyr_qzq_ks: String?; // 周营业日_迁址前_开始
    var zyyr_qzq_js: String?; // 周营业日_迁址前_结束
    var ryysj_qzq_ks: String?; // 日营业时间_迁址前_开始
    var ryysj_qzq_js: String?; // 日营业时间_迁址前_结束
    
    var kxpc_qzq: String?; // 开箱频次_迁址前
    var rtdpc_qzq: String?; // 日投递频次_迁址前
    var ztdpc_qzq: String?; // 周投递频次_迁址前
    
    var ywfw_qzq: String = ""; // 业务范围_迁址前
    //	var String ywfwxj_qzq; // 业务范围信件_迁址前
    //	var String ywfwysp_qzq; // 业务范围印刷品_迁址前
    //	var String ywfwbg_qzq; // 业务范围包裹_迁址前
    //	var String ywfwyzhd_qzq; // 业务范围邮政汇兑_迁址前
    //	var String ywfwqt_qzq; // 业务范围其它_迁址前
    //	var String ywfwbkdy_qzq; // 业务范围报刊订阅_迁址前
    //	var String ywfwywbxh_qzq; // 业务范围义务兵信函_迁址前
    //	var String ywfwmrdw_qzq; // 业务范围盲人读物_迁址前
    //	var String ywfwlsywbg_qzq; // 业务范围烈士遗物包裹_迁址前
    //	var String ywfwcx_qzq; // 业务范围邮政储蓄_迁址前
    //	var String ywfwtkzd_qzq; // 业务范围特快专递_迁址前
    //	var String ywfwjy_qzq; // 业务范围集邮_迁址前
    //	var String ywfwwl_qzq; // 业务范围物流_迁址前
    //	var String ywfwbkls_qzq; // 业务范围报刊零售_迁址前
    var qzyy_qzq: String?; // 迁址原因_迁址前
    
    var csdz_qzh_s: String?; // 场所地址_迁址后_市
    var csdz_qzh_xqs: String?; // 场所地址_迁址后_县区市
    var csdz_qzh_jx: String?; // 场所地址_迁址后_街乡
    var csdz_qzh_h: String?; // 场所地址_迁址后_号
    
    var yyzzxjl_qzh: String?; // 与原址直线距离_迁址后
    var jyfs_qzh: String?; // 经营方式_迁址后
    
    var yzbm_qzh: String?; // 邮政编码_迁址后
    var szdy_qzh: String?; // 设置地域_迁址后
    var kysj_qzh: String?; // 开业时间_迁址后
    var fwcq_qzh: String?; // 房屋产权_迁址后
    var jzmj_qzh: String?; // 建筑面积_迁址后
    
    var zyyr_qzh_ks: String?; // 周营业日_迁址后_开始
    var zyyr_qzh_js: String?; // 周营业日_迁址后_结束
    var ryysj_qzh_ks: String?; // 日营业时间_迁址后_开始
    var ryysj_qzh_js: String?; // 日营业时间_迁址后_结束
    
    var kxpc_qzh: String?; // 开箱频次_迁址后
    var rtdpc_qzh: String?; // 日投递频次_迁址后
    var ztdpc_qzh: String?; // 周投递频次_迁址后
    
    var ywfw_qzh: String = ""; // 业务范围_迁址后
    //	var String ywfwxj_qzh; // 业务范围信件_迁址后
    //	var String ywfwysp_qzh; // 业务范围印刷品_迁址后
    //	var String ywfwbg_qzh; // 业务范围包裹_迁址后
    //	var String ywfwyzhd_qzh; // 业务范围邮政汇兑_迁址后
    //	var String ywfwqt_qzh; // 业务范围其它_迁址后
    //	var String ywfwbkdy_qzh; // 业务范围报刊订阅_迁址后
    //	var String ywfwywbxh_qzh; // 业务范围义务兵信函_迁址后
    //	var String ywfwmrdw_qzh; // 业务范围盲人读物_迁址后
    //	var String ywfwlsywbg_qzh; // 业务范围烈士遗物包裹_迁址后
    //	var String ywfwcx_qzh; // 业务范围邮政储蓄_迁址后
    //	var String ywfwtkzd_qzh; // 业务范围特快专递_迁址后
    //	var String ywfwjy_qzh; // 业务范围集邮_迁址后
    //	var String ywfwwl_qzh; // 业务范围物流_迁址后
    //	var String ywfwbkls_qzh; // 业务范围报刊零售_迁址后
    
    var sjhzsdjyzgsfzrqz: String?; // 省级或者市地级邮政公司负责人签章
    var sjhzsdjyzgsfzrqzsj: String?; // 省级或者市地级邮政公司负责人签章时间
    var yzglbmdjxx: String?; // 邮政管理部门登记信息
    var djbh: String?; // 登记编号
    var jbr: String?; // 经办人
    var yzglbmdjxxsj: String?; // 邮政管理部门登记信息时间
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfNcxyzpbfwyycsjbqkb
* @Description: 拟撤销邮政普遍服务营业场所基本情况表；业务关联表：撤销邮政普遍服务营业场所申请(InfoOfCxyzpbfwyycssq)
* @author LY
* @date 2015-7-31 下午10:01:21
*
*/
class InfoOfNcxyzpbfwyycsjbqkb: NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var yzcsmc: String?; // 邮政场所名称
    var jyfs: String?; // 经营方式
    //	var String csdz; // 场所地址
    
    var csdz_s: String?; // 场所地址_市
    var csdz_xqs: String?; // 场所地址_县区市
    var csdz_jx: String?; // 场所地址_街乡
    var csdz_h: String?; // 场所地址_号
    var csdz_jd: String?; // 场所地址_经度
    var csdz_wd: String?; // 场所地址_纬度
    
    var yzbm: String?; //邮政编码
    var sjdw: String?; // 上级单位
    
    var yycsf: String?;  //营业场所负责人
    var yycslxdh: String?; //营业场所联系电话
    
    var fwbj: String?; // 服务半径
    var szdd: String?; // 所在地点
    var fwrk: String?; // 服务人口
    var kysj: String?; // 开业时间
    var fwcq: String?; // 房屋产权
    var jzmj: String?; // 建筑面积
    var fwqy: String?; // 服务区域
    
    var zyyr_ks: String?; // 周营业日_开始
    var zyyr_js: String?; // 周营业日_结束
    var ryysj_ks: String?; // 日营业时间_开始
    var ryysj_js: String?; // 日营业时间_结束
    
    var kxpc: String?; // 开箱频次
    var rtdpc: String?; // 日投递频次
    var ztdpc: String?; // 周投递频次
    
    var ywfw: String = ""; // 业务范围
    //	var String ywfwxj; // 业务范围信件
    //	var String ywfwysp; // 业务范围印刷品
    //	var String ywfwbg; // 业务范围包裹
    //	var String ywfwyzhd; // 业务范围邮政汇兑
    //	var String ywfwqt; // 业务范围其它
    //	var String ywfwbkdy; // 业务范围报刊订阅
    //	var String ywfwywbxh; // 业务范围义务兵信函
    //	var String ywfwmrdw; // 业务范围盲人读物
    //	var String ywfwlsywbg; // 业务范围烈士遗物包裹
    //	var String ywfwcx; // 业务范围邮政储蓄
    //	var String ywfwtkzd; // 业务范围特快专递
    //	var String ywfwjy; // 业务范围集邮
    //	var String ywfwwl; // 业务范围物流
    //	var String ywfwbkls; // 业务范围报刊零售
    
    var ncxyzpbfwyycszsr: String?; // 拟撤销邮政普遍服务营业场所总收入
    var yycsjyndywsrhj: String?; // 营业场所近一年的业务收入函件
    var yycsjyndywsrbg: String?; // 营业场所近一年的业务收入包裹
    var yycsjyndywsrysp: String?; // 营业场所近一年的业务收入印刷品
    var yycsjyndywsrhd: String?; // 营业场所近一年的业务收入汇兑
    var yycsjyndywsrbk: String?; // 营业场所近一年的业务收入报刊
    var yycsjyndywsrdlyw: String?; // 营业场所近一年的业务收入代理业务
    var yycsjyndywsrqt: String?; // 营业场所近一年的业务收入其他
    var yycsjynzyywlhj: String?; // 营业场所近一年主要业务量函件
    var yycsjynzyywlbg: String?; // 营业场所近一年主要业务量包裹
    var yycsjynzyywlysp: String?; // 营业场所近一年主要业务量印刷品
    var yycsjynzyywlhd: String?; // 营业场所近一年主要业务量汇兑
    var yycsjynzyywlbk: String?; // 营业场所近一年主要业务量报刊
    var yycsjynzyywldlyw: String?; // 营业场所近一年主要业务量代理业务
    var sjhzsdjyzfgsfzrqz: String?; // 省级或者市地级邮政分公司负责人签章
    var sjhzsdjyzfgsfzrqzsj: String?; // 省级或者市地级邮政分公司负责人签章时间
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfCxyzpbfwyycssq
* @Description: 撤销邮政普遍服务营业场所申请,业务关联表：拟撤销邮政普遍服务营业场所基本情况表 (InfoOfNcxyzpbfwyycsjbqkb)
* @author zmf
* @date 2015年7月31日 下午1:49:47
*
*/
class InfoOfCxyzpbfwyycssq: NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var zgyzjtfgsmc: String?; // 中国邮政集团公司分公司名称
    var btyzpbfwyycsmc: String?; // 撤销邮政普遍服务营业场所名称
    var syzgljmc: String?; // 市邮政管理局名称
    var sqcxdzyyy: String?; // 申请撤销的主要原因
    
    var cxsj_n: String?; // 撤销时间_年
    var cxsj_y: String?; // 撤销时间_月
    
    var cxdz_s: String?; // 撤销地址_市
    var cxdz_xqs: String?; // 撤销地址_县区市
    var cxdz_jx: String?; // 撤销地址_街乡
    
    var yzpbfwyycsmc: String?; // 邮政普遍服务营业场所名称
    
    var ncqdtdxcs: String?; // 拟采取的替代性措施
    var yzpbyycsszhyzpbfwztsp: String?; // 邮政普遍营业场所设置和邮政普遍服务总体水
    
    var fgsmc: String?; // 分公司名称
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    //新加入2个字段，用于表单提交时上传照片附件
    var gsyyzzfyj: String?;	//拟撤销邮政普遍服务营业场所的工商营业执照复印件
    var zmwj: String?;		//申请撤销邮政普遍服务营业场所原因的证明文件
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfyzqycxyzyycsdjb
* @Description: 邮政企业撤销邮政营业场所登记表
* @author zmf
* @date 2015年8月11日 下午5:20:00
*
*/
class InfoOfyzqycxyzyycsdjb: NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var yzyycsmc: String?; // 邮政营业场所名称
    
    var csdz_s: String?; // 场所地址_市
    var csdz_xqs: String?; // 场所地址_县区市
    var csdz_jx: String?; // 场所地址_街乡
    var csdz_h: String?; // 场所地址_号
    var csdz_jd: String?; // 场所地址_经度
    var csdz_wd: String?; // 场所地址_纬度
    
    var fzr: String?; // 负责人
    var lxdh: String?; // 联系电话
    var yzbm: String?; //邮政编码
    var sjdw: String?; // 上级单位
    var fwqy: String?; // 服务区域
    var szdd: String?; // 设置地点
    var jyfs: String?; // 经营方式
    var ywfw: String = ""; // 业务范围
    var qtsx: String?; // 其他事项
    
    var cxyy: String?; // 撤销原因
    var ncxrq: String?; // 拟撤销日期
    
    var sjhzsdjyzfgsfzrqz: String?; // 省级或者市地级邮政分公司负责人签章
    var sjhzsdjyzfgsfzrqzsj: String?; // 省级或者市地级邮政分公司负责人签章时间
    var yzglbmdjxx: String?; // 邮政管理部门登记信息
    var djbh: String?; // 登记编号
    var jbr: String?; // 经办人
    var yzglbmdjxxsj: String?; // 邮政管理部门登记信息时间
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?; // 附件图片地址
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfZtbhxbyzpbfwhtsfwywdjb
* @Description: 暂停办或限办邮政普遍服务业务和特殊服务业务登记表
* @author LY
* @date 2015-7-31 下午9:07:07
*
*/
class InfoOfZtbhxbyzpbfwhtsfwywdjb : NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var yzyycsmc: String?; // 邮政营业场所名称
    var sjdw: String?; // 上级单位
    
    //删除路两个字段（zstzblywsx、zsxzblywsx），新增两个字段（xzblsx、xzblsx_ywfw）
    var xzblsx: String?;//选择办理事项	（zstzblywsx，zsxzblywsx）
    var xzblsx_ywfw: String = "";//业务范围		（xj,ysp,bgs,yzhd,gjgdbkdfx,ywbpcxh,mrdw,gmlsyw）
    //	var String zstzblywsx; // 暂时停止办理业务事项
    //	var String zstzblywsxxj; // 暂时停止办理业务事项信件
    //	var String zstzblywsxysp; // 暂时停止办理业务事项印刷品
    //	var String zstzblywsxbg; // 暂时停止办理业务事项包裹
    //	var String zstzblywsxyzhd; // 暂时停止办理业务事项邮政汇兑
    //	var String zstzblywsxgjgdbkdfx; // 暂时停止办理业务事项国家规定报刊的发行
    //	var String zstzblywsxywbpcxh; // 暂时停止办理业务事项义务兵平常信函
    //	var String zstzzblywsxmrdw; // 暂时停止办理业务事项盲人读物
    //	var String zstzblywsxgmlsyw; // 暂时停止办理业务事项革命烈士遗物
    
    //	var String zsxzblywsx; // 暂时限制办理业务事项
    //	var String zsxzblywsxxj; // 暂时限制办理业务事项信件
    //	var String zsxzblywsxysp; // 暂时限制办理业务事项印刷品
    //	var String zsxzblywsxbg; // 暂时限制办理业务事项包裹
    //	var String zsxzblywsxyzhd; // 暂时限制办理业务事项邮政汇兑
    //	var String zsxzblywsxgjgdbkdfx; // 暂时限制办理业务事项国家规定报刊的发行
    //	var String zsxzblywsxywbpcxh; // 暂时限制办理业务事项义务兵平常信函
    //	var String zsxzzblywsxmrdw; // 暂时限制办理业务事项盲人读物
    //	var String zsxzblywsxgmlsyw; // 暂时限制办理业务事项革命烈士遗物
    
    var zstzblhzxzblywdyzyycsdfwqy: String?;//暂时停止办理或者限制办理业务的邮政营业场所的服务区域
    var dz: String?; // 地址
    var yzbm: String?; // 邮政编码
    var lxrxm: String?; // 联系人姓名
    var lxdh: String?; // 联系电话
    var zstzblhzxzblywdsj: String?; // 暂时停止办理或者限制办理业务的时间
    var zstzblhzxzblywdyy: String?; // 暂时停止办理或者限制办理业务的原因
    var zstzblhzxzblywqjyzqycqdbjcs: String?; // 暂时停止办理或者限制办理业务期间邮政企业采取的补救措施
    
    var sjhzsdjyzfgsfzrqz: String?; // 省级或者市地级邮政分公司负责人签章
    var sjhzsdjyzfgsfzrqzsj: String?; // 省级或者市地级邮政分公司负责人签章时间
    var yzglbmdjxx: String?; // 邮政管理部门登记信息
    var djbh: String?; // 登记编号
    var jbr: String?; // 经办人
    var yzglbmdjxxsj: String?; // 邮政管理部门登记信息时间
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfNthybywyzyycsjbqkb
* @Description: 拟停或限办业务邮政营业场所基本情况表；业务关联表：邮政营业场所停办或限办邮政普遍服务业务和特殊服务业务的申请（InfoOfYzyycstbhybyzpbfwywhtsfwywdsq ）
* @author LY
* @date 2015-7-31 下午8:51:48
*
*/
class InfoOfNthybywyzyycsjbqkb: NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var yzyycsmc: String?; // 邮政营业场所名称
    var sjdw: String?; // 上级单位
    
    var tzblywsx: String = ""; // 停止办理业务事项
    //	var String tzblywsxxj; // 停止办理业务事项信件
    //	var String tzblywsxysp; // 停止办理业务事项印刷品
    //	var String tzblywsxbg; // 停止办理业务事项包裹
    //	var String tzblywsxyzhd; // 停止办理业务事项邮政汇兑
    //	var String tzblywsxgjgdbkdfx; // 停止办理业务事项国家规定报刊的发行
    //	var String tzblywsxywbpcxh; // 停止办理业务事项义务兵平常信函
    //	var String tzzblywsxmrdw; // 停止办理业务事项盲人读物
    //	var String tzblywsxgmlsyw; // 停止办理业务事项革命烈士遗物
    
    var xzblywsx: String = ""; // 限制办理业务事项
    //	var String xzblywsxxj; // 限制办理业务事项信件
    //	var String xzblywsxysp; // 限制办理业务事项印刷品
    //	var String xzblywsxbg; // 限制办理业务事项包裹
    //	var String xzblywsxyzhd; // 限制办理业务事项邮政汇兑
    //	var String xzblywsxgjgdbkdfx; // 限制办理业务事项国家规定报刊的发行
    //	var String xzblywsxywbpcxh; // 限制办理业务事项义务兵平常信函
    //	var String xzzblywsxmrdw; // 限制办理业务事项盲人读物
    //	var String xzblywsxgmlsyw; // 限制办理业务事项革命烈士遗物
    
    var tbhxbywyzyycsdfwqy: String?; // 停办或限办业务邮政营业场所的服务区域
    var dz: String?; // 地址
    var yzbm: String?; // 邮政编码
    var lxrxm: String?; // 联系人姓名
    var lxdh: String?; // 联系电话
    var sjhzsdjyzfgsfzrqz: String?; // 省级或者市地级邮政分公司负责人签章
    var sjhzsdjyzfgsfzrqzsj: String?; // 省级或者市地级邮政分公司负责人签章时间
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfYzyycstbhybyzpbfwywhtsfwywdsq
* @Description: 邮政营业场所停办或限办邮政普遍服务业务和特殊服务业务的申请 ；业务关联表：拟停或限办业务邮政营业场所基本情况表(InfoOfNthybywyzyycsjbqkb )
* @author LY
* @date 2015-7-31 下午10:31:49
*
*/
class InfoOfYzyycstbhybyzpbfwywhtsfwywdsq : NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var zgyzjtgsttfgsmc: String?; // 中国邮政集团公司分公司名称
    var btyzyycsmc: String?; // 标题邮政营业场所名称
    var syzgljmc: String?; // 市邮政管理局名称
    
    var sqtzblhzxzywdzyyy: String?; // 申请停止办理或者限制业务的主要原因
    //	var String tzblhzxzblsj; // 停止办理或者限制办理时间
    var tzblhzxzblsj_n: String?; // 停止办理或者限制办理时间_年
    var tzblhzxzblsj_y: String?; // 停止办理或者限制办理时间_月
    
    var tzblhzxzbl: String?; // 停止办理或者限制办理
    var tzblhzxzbldz_s: String?; // 停止办理或者限制办理地址_市
    var tzblhzxzbldz_xqs: String?; // 停止办理或者限制办理地址_县区市
    var tzblhzxzbldz_jx: String?; // 停止办理或者限制办理地址_街乡
    var yzyycsmc: String?; // 邮政营业场所名称
    var yzpbfwywhtsfwyw: String?; // 邮政普遍服务业务或特殊服务业务
    var jtywmc: String?; // 具体业务名称
    var xzblywdjtqx: String?; // 限制办理业务的具体情形
    var cqdbjcs: String?; // 采取的补救措施
    var yzpbfwztsp: String?; // 邮政普遍服务总体水平
    var fgsmc: String?; // 分公司名称
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    //新加入2个字段，用于表单提交时上传照片附件
    var gsyyzzfyj: String?;	//邮政营业场所的工商营业执照复印件
    var zmwj: String?;		//申请停限办业务原因的证明文件
    
    var sppl: String?; // 审批评论
}

/**
*
* @ClassName: InfoOfHfblyzpbhtsfwywbgb
* @Description: 恢复办理邮政普遍和特殊服务业务报告表
* @author LY
* @date 2015-7-31 下午9:25:47
*
*/
class InfoOfHfblyzpbhtsfwywbgb: NSObject {
    var id: Int = 0;
    
    var flowId: String?; // 流程编号
    var state: Int = 0; // 状态: 0初始录入;1.开始审批;2为审批通过;
    var sqsj: String?; // 申请时间
    var loginName: String?; // 申请人账号
    
    var yzyycsmc: String?; // 邮政营业场所名称对应企业名称
    var tzhxzblywsx: String = ""//停止或限制办理业务事项
    //var String tzblywsx; // 停止办理业务事项信件
    //var String xzblywsx; // 限制办理业务事项信件
    //	var String tzhzxzblywsxxj; // 停止或者限制办理业务事项信件
    //	var String tzhzxzblywsxysp; // 停止或者限制办理业务事项印刷品
    //	var String tzhzxzblywsxbg; // 停止或者限制办理业务事项包裹
    //	var String tzhzxzblywsxyzhd; // 停止或者限制办理业务事项邮政汇兑
    //	var String tzhzxzblywsxgjgdbkdfx; // 停止或者限制办理业务事项国家规定报刊的发行
    //	var String tzstzblywsxywbpcxh; // 停止或者限制办理业务事项义务兵平常信函
    //	var String tzstzzblywsxmrdw; // 停止或者限制办理业务事项盲人读物
    //	var String tzstzblywsxgmlsyw; // 停止或者限制办理业务事项革命烈士遗物
    
    var tzhzyzblywqyhyycsmc: String?;//停止或者限制办理业务区域或营业场所名称
    var dz: String?; // 地址
    var yzbm: String?; // 邮政编码
    var lxrxm: String?; // 联系人姓名
    var lxdh: String?; // 联系电话
    var hfbldsj: String?; // 恢复办理的时间
    var qtxysmdsx: String?; // 其他需要说明的事项
    
    var ssxsjyzqyfzrqz: String?; // 所属县市级邮政企业负责人签字
    var ssxsjyzqyfzrqzsj: String?; // 所属县市级邮政企业负责人签字时间
    var sssdjyzqyfzrqz: String?; // 所属市地级邮政企业负责人签字
    var sssdjyzqyfzrqzsj: String?; // 所属市地级邮政企业负责人签字时间
    
    var ylzd1: String?; // 预留字段1
    var ylzd2: String?; // 预留字段2
    
    var imageUrl: String?;// 附件图片地址
    
    var sppl: String?; // 审批评论
}

class ApplyRecoveryBranch : NSObject {
    var qiYeMingCheng: String?
    var tingZhiBanLiYeWuShiXiang: [String?] = []
    var tingZhiBanLiYeWuQuYu: String?
    var diZhi: String?
    var youZhengBianMa: String?
    var lianXiRenXingMing: String?
    var huiFuBanLiShiJian: String?
    var qiTaXuYaoShuoMingDeShiXiang: String?
}


