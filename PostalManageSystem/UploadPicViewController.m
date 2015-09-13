//
//  UploadPicViewController.m
//  PostalManageSystem
//
//  Created by ZengYifei on 15/9/13.
//  Copyright (c) 2015年 IOS-developer. All rights reserved.
//

#import "UploadPicViewController.h"
@interface UploadPicViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    AppDelegate *app;

}
@property (strong,nonatomic) UILabel * titleLabel;
@property (strong,nonatomic) UIImagePickerController * imagePicker;
@end

@implementation UploadPicViewController


#pragma mark - UI

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    
    //获取单例
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //设置导航栏label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor yellowColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = app.titleForCurrentPage;
    self.navigationItem.titleView = self.titleLabel;
    
    UIButton * imageFromAlbumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageFromAlbumBtn.frame = CGRectMake(UISCREENWIDTH/6, NAVIGATIONHEIGHT + UISCREENHEIGHT/6, UISCREENWIDTH/3, UISCREENHEIGHT/4);
    [imageFromAlbumBtn addTarget:self action:@selector(pickImageFromAlbum) forControlEvents:UIControlEventTouchUpInside];
    [imageFromAlbumBtn setTitle:@"图库" forState:UIControlStateNormal];
    imageFromAlbumBtn.backgroundColor = UIColorFromRGBValue(0x028e45);
    [imageFromAlbumBtn setTitleColor:[UIColor yellowColor]forState:UIControlStateNormal];
    [self.view addSubview:imageFromAlbumBtn];
    
    UIButton * imageFromCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    imageFromCameraBtn.frame = CGRectMake(UISCREENWIDTH*7/12, NAVIGATIONHEIGHT + UISCREENHEIGHT/6, UISCREENWIDTH/3, UISCREENHEIGHT/4);
    [imageFromCameraBtn addTarget:self action:@selector(pickImageFromCamera) forControlEvents:UIControlEventTouchUpInside];
    [imageFromCameraBtn setTitle:@"相机" forState:UIControlStateNormal];
    imageFromCameraBtn.backgroundColor = UIColorFromRGBValue(0x028e45);
    [imageFromCameraBtn setTitleColor:[UIColor yellowColor]forState:UIControlStateNormal];
    [self.view addSubview:imageFromCameraBtn];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGBValue(0x028e45)];//邮政的绿色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [[UINavigationBar appearance] setTintColor:[UIColor yellowColor]];    //导航栏按钮颜色
}

- (void)viewDidAppear:(BOOL)animated{
    //[self pickImageFromAlbum];
}

- (void)pickImageFromCamera
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor lightTextColor]];//邮政的绿色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];    //导航栏按钮颜色
    
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePicker.allowsEditing = YES;
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (void)pickImageFromAlbum{
    [[UINavigationBar appearance] setBarTintColor:[UIColor lightTextColor]];//邮政的绿色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];    //导航栏按钮颜色
    
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePicker.allowsEditing = NO;
    [self presentViewController:_imagePicker animated:YES completion:nil];

}
@end
