//
//  EventCellTableViewCell.h
//  LearningHouse
//
//  Created by Alok Singh on 8/11/16.
//  Copyright © 2016 Supra IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"


@interface EventCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet AsyncImageView *ProductFirIMG;

@property (weak, nonatomic) IBOutlet AsyncImageView *ProductSecIMG;
@property (weak, nonatomic) IBOutlet UILabel *ProductFirLBL;
@property (weak, nonatomic) IBOutlet UILabel *ProductSecLBL;
@property (weak, nonatomic) IBOutlet UIButton *ProductFirBTN;
@property (weak, nonatomic) IBOutlet UIButton *ProductSecBTN;

@end
