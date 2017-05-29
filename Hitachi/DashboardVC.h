//
//  DashboardVC.h
//  Hitachi
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsVC.h"
#import "OffersVC.h"
#import "SITSPOPVC.h"
#import "SITSGuidelineVC.h"
#import "SITSFeaturedVC.h"
#import "SITSBroucherVC.h"
#import "SITSProductVideosVC.h"
#import "SITSBroucherDetailVC.h"









@interface DashboardVC : UIViewController
- (IBAction)BackBtnAction:(id)sender;
- (IBAction)ProductAction:(id)sender;
- (IBAction)BrocherAction:(id)sender;
- (IBAction)FeaturedVideosAction:(id)sender;
- (IBAction)ProductVideosAction:(id)sender;
- (IBAction)OffersAction:(id)sender;
- (IBAction)AvailablePOPAction:(id)sender;
- (IBAction)ProductSpecsAction:(id)sender;
@end
