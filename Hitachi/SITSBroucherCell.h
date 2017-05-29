//
//  SITSBroucherCell.h
//  Hitachi
//
//  Created by Apple on 03/01/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"


@interface SITSBroucherCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *BrouchIMG;
@property (weak, nonatomic) IBOutlet UILabel *BrouchLBL;

@end
