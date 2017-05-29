//
//  SITSPVCell.h
//  Hitachi
//
//  Created by Apple on 13/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"


@interface SITSPVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *ProductFirBTN;
@property (weak, nonatomic) IBOutlet AsyncImageView *ProductFirIMG;
@property (weak, nonatomic) IBOutlet UILabel *ProductFirLBL;
@property (weak, nonatomic) IBOutlet UILabel *ProductDescLBL;
@property (weak, nonatomic) IBOutlet UIButton *ProductDLBTN;
@property (weak, nonatomic) IBOutlet UIButton *ProductVPlayBTN;

@end
