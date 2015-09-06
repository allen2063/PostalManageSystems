//
//  GeneralTableViewCell.h
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/20.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeneralTableViewCell : UITableViewCell
- (void)addPicLayout;
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UILabel * writerLabel;
@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,strong) UIImageView * picImageView;
@end
