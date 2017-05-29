//
//  SITSDashboardCell.h
//  Hitachi
//
//  Created by Apple on 05/01/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@protocol CellActionDelegate <NSObject>

-(void) FirstButtonSelection:(long)str;

@end


@interface SITSDashboardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *OfferFirIMG;
@property (weak, nonatomic) IBOutlet AsyncImageView *OfferSecIMG;
@property (weak, nonatomic) IBOutlet UIButton *OfferFirBTN;
@property (weak, nonatomic) IBOutlet UIButton *OfferSecBTN;
@property (weak, nonatomic) IBOutlet UILabel *DashFirLBL;
@property (weak, nonatomic) IBOutlet UILabel *DashSecLBL;
@property (nonatomic,strong) id<CellActionDelegate> delegate;


@end
