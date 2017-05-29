//
//  SITSProductDetailVC.h
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWebServiceHelper.h"
#import "AsyncImageView.h"
#import "BSEDropDownVW.h"
#import "YTPlayerView.h"




@interface SITSProductDetailVC : UIViewController<WebServiceResponseProtocal,BSEDropDownVWDelegate,YTPlayerViewDelegate,UIScrollViewDelegate>
@property(strong,nonatomic) NSString *ProductId;
- (IBAction)BackAct:(id)sender;
@property (weak, nonatomic) IBOutlet AsyncImageView *FeaturesSpecIMG;
@property (weak, nonatomic) IBOutlet UILabel *ProdNameLBL;
@property (weak, nonatomic) IBOutlet UIButton *DDBTN;
@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@property (weak, nonatomic) IBOutlet UIScrollView *ProductSVW;
@property (weak, nonatomic)  NSArray *ProductsArr;
@property ( nonatomic)  long CurrentProduct;



@end
