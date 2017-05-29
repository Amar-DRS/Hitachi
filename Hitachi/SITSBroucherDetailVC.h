//
//  SITSBroucherDetailVC.h
//  Hitachi
//
//  Created by Apple on 29/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SITSBroucherCell.h"
#import "MyWebServiceHelper.h"


@interface SITSBroucherDetailVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,WebServiceResponseProtocal>
@property (weak, nonatomic) IBOutlet UICollectionView *BroucherCV;
@property (weak, nonatomic) IBOutlet AsyncImageView *BrouchDetailIMG;

@end
