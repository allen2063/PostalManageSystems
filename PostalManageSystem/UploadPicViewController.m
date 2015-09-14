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

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
       
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        //得到选择后沙盒中图片的完整路径

        //filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        //关闭相册界面

        [picker dismissViewControllerAnimated:YES completion:nil];
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        UIImageView *smallimage = [[UIImageView alloc] initWithFrame:CGRectMake(50, NAVIGATIONHEIGHT + UISCREENWIDTH, 200, 200)];
        smallimage.image = image;
        //加在视图中
        [self.view addSubview:smallimage];
    }

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
