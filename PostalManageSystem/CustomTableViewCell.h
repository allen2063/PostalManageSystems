//
//  CustomTableViewCell.h
//  PostalManageSystem
//
//  Created by ZengYifei on 15/9/14.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyScrollView : UIScrollView

@end

@interface CustomTableViewCell : UITableViewCell<UIScrollViewDelegate>{
    BOOL scrollToRight;
}
@property(nonatomic,strong) UILabel * serviceTypeLabel;
@property(nonatomic,strong) UILabel * placeNameLabel;
@property(nonatomic,strong) UILabel * timeAndApllyPersonLabel;
@property(nonatomic,strong) MyScrollView * backgroundScrollView;
@property(nonatomic,strong) UIButton * deleteBtn;
@property(nonatomic,strong) UIButton * modifyBtn;
@property(nonatomic,strong) UIButton * uploadPicBtn;
@property  BOOL isScrolledToRight;


@end


