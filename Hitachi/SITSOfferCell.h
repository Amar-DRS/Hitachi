//
//  SITSOfferCell.h
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"


@interface SITSOfferCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *OfferFirIMG;
@property (weak, nonatomic) IBOutlet AsyncImageView *OfferSecIMG;
@property (weak, nonatomic) IBOutlet UIButton *OfferFirBTN;
@property (weak, nonatomic) IBOutlet UIButton *OfferSecBTN;
@property (weak, nonatomic) IBOutlet UILabel *NameFirLBL;
@property (weak, nonatomic) IBOutlet UILabel *NameSecLBL;

@end
