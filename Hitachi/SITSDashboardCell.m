//
//  SITSDashboardCell.m
//  Hitachi
//
//  Created by Apple on 05/01/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import "SITSDashboardCell.h"

@implementation SITSDashboardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)FirBTnAction:(id)sender {
    
    if ([sender tag]%2==1) {
        self.OfferSecBTN.backgroundColor=[UIColor lightTextColor];
    }
    else
    {
        self.OfferFirBTN.backgroundColor=[UIColor lightTextColor];
    }
    [self.delegate FirstButtonSelection:[sender tag]];
}
@end
