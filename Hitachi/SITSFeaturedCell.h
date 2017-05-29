//
//  SITSFeaturedCell.h
//  Hitachi
//
//  Created by Apple on 26/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@protocol SelectedVideoDelegate <NSObject>
-(void) selectedVideoItem:( long)TagValue;
@end

@interface SITSFeaturedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *FVFirIMG;
@property (weak, nonatomic) IBOutlet AsyncImageView *FVSecIMG;
@property (weak, nonatomic) IBOutlet UILabel *FVFirLBL;
@property (weak, nonatomic) IBOutlet UILabel *FVSecLBL;
@property (weak, nonatomic) IBOutlet UIButton *FVFirBTN;
@property (weak, nonatomic) IBOutlet UIButton *FVSecBTN;
@property (nonatomic,strong) id<SelectedVideoDelegate> delegate;

@end
