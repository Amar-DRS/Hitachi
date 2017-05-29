//
//  SITSDashboardVC.h
//  Hitachi
//
//  Created by Apple on 05/01/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SITSDashboardCell.h"
#import "MyWebServiceHelper.h"
#import "ProductsVC.h"
#import "OffersVC.h"
#import "SITSPOPVC.h"
#import "SITSGuidelineVC.h"
#import "SITSFeaturedVC.h"
#import "SITSBroucherVC.h"
#import "SITSProductVideosVC.h"
#import "SITSBroucherDetailVC.h"
#import "AsyncImageView.h"
#import "SITSDashBoardCCellCollectionViewCell.h"
#import "SITSFAQsVC.h"






@interface SITSDashboardVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,WebServiceResponseProtocal>
@property (weak, nonatomic) IBOutlet UICollectionView *ItemTV;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *CollectioFL;
@property (strong, nonatomic)  NSArray *ItemArr;
@property (weak, nonatomic) IBOutlet UILabel *HItachiLBL;

@property (weak, nonatomic) IBOutlet UILabel *BGLBL;
@property (weak, nonatomic) IBOutlet UIImageView *BackIMG;
@end
