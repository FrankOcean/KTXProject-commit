//
//  WebViewController.h
//  KTXProject
//
//  Created by qianfeng on 16/2/18.
//  Copyright © 2016年 PY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic, copy) NSString * idStr;
@property (nonatomic, copy) NSString * thumbnail;
@property (nonatomic, copy) NSString * titleK;

@property (weak, nonatomic) IBOutlet UIWebView *WBView;
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;

- (IBAction)commentBtnClick:(id)sender;

- (IBAction)dismissBtnClick:(id)sender;
- (IBAction)shareBtnClick:(id)sender;
- (IBAction)storeBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *btnView;


@end
