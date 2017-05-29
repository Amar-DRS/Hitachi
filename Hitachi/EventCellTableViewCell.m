//
//  EventCellTableViewCell.m
//  LearningHouse
//
//  Created by Alok Singh on 8/11/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import "EventCellTableViewCell.h"

@implementation EventCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ProductFirBTN.layer.borderColor=[UIColor blackColor].CGColor;
    self.ProductFirBTN.layer.borderWidth=2.0;
    self.ProductSecBTN.layer.borderColor=[UIColor blackColor].CGColor;
    self.ProductSecBTN.layer.borderWidth=2.0;
    self.ProductSecBTN.hidden=YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
