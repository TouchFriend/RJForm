//
//  RJFormPhotoPickerManager.m
//  Destination
//
//  Created by TouchWorld on 2018/11/14.
//  Copyright © 2018 Redirect. All rights reserved.
//

#import "RJFormPhotoPickerManager.h"
#import <Photos/Photos.h>

@interface RJFormPhotoPickerManager () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/********* 回调block *********/
@property(nonatomic,copy)RJFormPickImageCompletedBlock completed;
/********* 控制器 *********/
@property(nonatomic,weak)UIViewController * vc;
/********* 类型 *********/
@property(nonatomic,assign)RJFormPhotoPickerType type;

@end
@implementation RJFormPhotoPickerManager

static RJFormPhotoPickerManager * manager;

+ (instancetype)shareInstance
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RJFormPhotoPickerManager alloc] init];
    });
    
    return manager;
}

- (void)presentPicker:(RJFormPhotoPickerType)type target:(UIViewController *)vc completed:(RJFormPickImageCompletedBlock)completed
{
    if(![self isPhotoAuthorization])
    {
        return;
    }
    
    self.completed = completed;
    self.vc = vc;
    self.type = type;
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    NSString *errorMsg = @"";
    
    if(type == RJFormPhotoPickerTypeCamera)//拍照
    {
        //相机是否可用
        sourceType = UIImagePickerControllerSourceTypeCamera;
        errorMsg = @"相机不可用";
        
    }
    else if(type == RJFormPhotoPickerTypeSavedPhotosAlbum)//相册
    {
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        errorMsg = @"相册不可用";
    }
    else
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        errorMsg = @"相册不可用";
    }
    
    
    BOOL flag = [UIImagePickerController isSourceTypeAvailable:sourceType];
    if(!flag)
    {
        NSLog(@"%@", errorMsg);
        NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:500 userInfo:@{
                                                                                          NSLocalizedDescriptionKey : errorMsg
                                                                                          }];
        completed(nil, error);
        return;
    }
    
    UIImagePickerController * imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = NO;
    imagePickerVC.sourceType = sourceType;
    imagePickerVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [vc presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    __weak typeof(self) weakSelf = self;
//    NJLog(@"%@", info);
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage * image;
    if([mediaType isEqualToString:@"public.image"])
    {
        if([picker allowsEditing])//允许编辑
        {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else
        {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
    }
    
    //如果是相机，保存图片到相册
    if (self.type == RJFormPhotoPickerTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
    
    [self.vc dismissViewControllerAnimated:YES completion:^{
        weakSelf.completed(image, nil);
    }];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消拍照");
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}


- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        NSLog(@"保存图片到相册失败,error:%@", error);
        return;
    }
    
    NSLog(@"保存图片到相册成功");
    
}

#pragma mark - Private Methods

- (BOOL)isPhotoAuthorization
{
    AVAuthorizationStatus videoStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //是否授权
    if(videoStatus == AVAuthorizationStatusDenied)
    {
        [self guideUserOpenAuth];
        return NO;
    }
    
    return YES;
}

- (void)guideUserOpenAuth
{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请打开相机权限" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openAppSetting];
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:settingAction];
    alertController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.vc presentViewController:alertController animated:YES completion:nil];
}

//前往设置界面
- (void)openAppSetting
{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}


@end
