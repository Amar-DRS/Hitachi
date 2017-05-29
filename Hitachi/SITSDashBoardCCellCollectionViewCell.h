//
//  SITSDashBoardCCellCollectionViewCell.h
//  Hitachi
//
//  Created by Apple on 01/02/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface SITSDashBoardCCellCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *TagLBL;
@end
