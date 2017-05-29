//
//  HomeVC.h
//  Hitachi
//
//  Created by Apple on 29/11/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardVC.h"
#import "define.h"
#import "UIView+Glow.h"
#import "SITSDashboardVC.h"






@interface HomeVC : UIViewController<UITextFieldDelegate>
{
  CGRect  LoginVWFrame;
  CGRect  RoleVWFrame;
  NSNumber *UserType;

}
@property (weak, nonatomic) IBOutlet UIView *RoleVW;
@property (weak, nonatomic) IBOutlet UIView *PasswordVW;
@property (weak, nonatomic) IBOutlet UIView *LoginVW;
@property (weak, nonatomic) IBOutlet UITextField *PasscodeTXT;
@property (weak, nonatomic) IBOutlet UIImageView *RoleIMG;
- (IBAction)infoBTN:(id)sender;
- (IBAction)LOginAction:(id)sender;

- (IBAction)GuestUserAction:(id)sender;
- (IBAction)SalesAction:(id)sender;
- (IBAction)DealerAction:(id)sender;

-(void)hideViewWithAnimation;
-(void)showViewWithAnimation;
@property (weak, nonatomic) IBOutlet UIButton *GuestBTN;
@property (weak, nonatomic) IBOutlet UIButton *DealerBTN;
@property (weak, nonatomic) IBOutlet UIImageView *RoleSliceIMG;

@property (weak, nonatomic) IBOutlet UIButton *SalesBTN;
@end
