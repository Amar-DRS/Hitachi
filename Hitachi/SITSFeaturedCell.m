//
//  SITSFeaturedCell.m
//  Hitachi
//
//  Created by Apple on 26/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSFeaturedCell.h"

@implementation SITSFeaturedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   // [self.FVFirBTN addTarget:self action:@selector(FVFirAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)FVFirAction:(id)sender
{
    [self.FVFirBTN setHighlighted:YES];
    [self.FVFirBTN setImage:[UIImage imageNamed:@"Download.png"] forState:UIControlStateHighlighted];
    [self.delegate selectedVideoItem:[self.FVFirBTN tag]];
}
@end
