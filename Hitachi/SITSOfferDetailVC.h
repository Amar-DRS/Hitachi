//
//  SITSOfferDetailVC.h
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"


@interface SITSOfferDetailVC : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet AsyncImageView *OfferIV;
- (IBAction)BackAct:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *OfferTitleLBL;
@property (strong, nonatomic)  NSString *OfferName;
@property (strong, nonatomic)  NSString *OfferIMGURL;

- (IBAction)DownloadAct:(id)sender;
- (IBAction)Share:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *OfferSW;

@end
