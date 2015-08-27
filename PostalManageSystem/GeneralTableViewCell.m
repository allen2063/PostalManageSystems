//
//  GeneralTableViewCell.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/8/20.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "GeneralTableViewCell.h"
#define CELLWIDTH (self.frame.size.width-15)
@implementation GeneralTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] applicationFrame].size.width, 80);         //iPhone6上宽度实际是375
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width*3/4-15, self.frame.size.height*7/9)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = UIColorFromRGBValue(0x333333);
        self.titleLabel.numberOfLines = 2;
        [self addSubview:self.titleLabel];
        
        self.writerLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.frame.size.height*2/3, self.frame.size.width*3/8-7.5, self.frame.size.height*2/9)];
        self.writerLabel.backgroundColor = [UIColor clearColor];
        self.writerLabel.font = [UIFont systemFontOfSize:14];
        self.writerLabel.textColor = UIColorFromRGBValue(0x9e9e9e);
        self.writerLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.writerLabel];
        
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+self.writerLabel.frame.size.width, self.frame.size.height*2/3, self.frame.size.width*3/8-7.5, self.frame.size.height*2/9)];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont systemFontOfSize:14];
        self.timeLabel.textColor = UIColorFromRGBValue(0x9e9e9e);
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLabel];
        
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*3/4, 0, self.frame.size.width/4, self.frame.size.height)];
        self.picImageView.image = [UIImage imageNamed:@"logo"];
        [self addSubview:self.picImageView];
        //NSLog(@"titleLabel:%@ writerLabel:%@ timeLabel:%@ picImageView:%@ self:%@",NSStringFromCGRect(self.titleLabel.frame),NSStringFromCGRect(self.writerLabel.frame),NSStringFromCGRect(self.timeLabel.frame),NSStringFromCGRect(self.picImageView.frame),NSStringFromCGRect(self.frame));
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
