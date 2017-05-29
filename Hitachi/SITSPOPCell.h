//
//  SITSPOPCell.h
//  Hitachi
//
//  Created by Apple on 09/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface SITSPOPCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *POPFirBTN;
@property (weak, nonatomic) IBOutlet UIButton *POPSecBTN;
@property (weak, nonatomic) IBOutlet AsyncImageView *POPSecIMG;
@property (weak, nonatomic) IBOutlet AsyncImageView *POPFirIMG;
@property (weak, nonatomic) IBOutlet UILabel *NameFirLBL;
@property (weak, nonatomic) IBOutlet UILabel *NameSecLBL;

@end
