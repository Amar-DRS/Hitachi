//
//  SITSFeaturedVC.h
//  Hitachi
//
//  Created by Apple on 13/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebServiceHelper.h"
#import "SITSFeaturedCell.h"
#import "YTPlayerView.h"
#import "AsyncImageView.h"
#import "define.h"




@interface SITSFeaturedVC : UIViewController<WebServiceResponseProtocal,UITableViewDelegate,UITableViewDataSource,YTPlayerViewDelegate>

- (IBAction)BackAct:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *FeatureProdTV;
@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;
- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *DownloadBTN;
@property (weak, nonatomic) IBOutlet UIButton *ShareBTN;

@property (weak, nonatomic) IBOutlet UILabel *FVNameLBL;
@end
