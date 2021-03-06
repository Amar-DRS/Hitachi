//
//  SITSTVCVC.h
//  Hitachi
//
//  Created by Apple on 28/02/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebServiceHelper.h"
#import "SITSPVCell.h"
#import "YTPlayerView.h"
#import "define.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface SITSTVCVC : UIViewController<WebServiceResponseProtocal,UITableViewDelegate,UITableViewDataSource,YTPlayerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ProductTV;
- (IBAction)BackAct:(id)sender;
- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *PVNameLBL;

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *ShareBTN;
@property (weak, nonatomic) IBOutlet UIButton *DownloadBTN;
@end
