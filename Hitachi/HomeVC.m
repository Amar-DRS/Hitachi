//
//  HomeVC.m
//  Hitachi
//
//  Created by Apple on 29/11/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "HomeVC.h"
#import "MyWebServiceHelper.h"
#import "define.h"
@interface HomeVC ()<WebServiceResponseProtocal>
{
    MyWebServiceHelper *helper;
    NSArray *LearnArr;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;

    RoleVWFrame=self.RoleVW.frame;
    LoginVWFrame=self.LoginVW.frame;
    [self.view setBackgroundColor:[UIColor blueColor]];
    self.navigationController.navigationBar.hidden=YES;
    UserType =USER_TYPE_GUEST;
    
    
 
    self.PasscodeTXT.delegate=self;
    self.PasswordVW.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.PasswordVW.layer.borderWidth= 1.0f;
    self.PasscodeTXT.rightViewMode = UITextFieldViewModeAlways;// Set rightview mode
    UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right"]];
    self.PasscodeTXT.rightView = rightImageView;    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {

    UserType=USER_TYPE_GUEST;
    self.PasscodeTXT.text=@"";
    self.LoginVW.hidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];

    CGRect newRoleVW = self.RoleVW.frame;
    newRoleVW.origin.y += 100;    // shift below by 100pts
    
    CGRect newLoginVW = self.LoginVW.frame;
    newLoginVW.origin.y += 100;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.RoleVW.frame=newRoleVW;
                         self.LoginVW.frame=newLoginVW;
                     }];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    
    CGRect newRoleVW = self.RoleVW.frame;
    newRoleVW.origin.y -= 100;    // shift below by 50pts
    
    CGRect newLoginVW = self.LoginVW.frame;
    newLoginVW.origin.y -= 100;
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.RoleVW.frame=newRoleVW;
                         self.LoginVW.frame=newLoginVW;
                     }];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)infoBTN:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:PASSCODE_Alert
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)LOginAction:(id)sender {
    [self.view endEditing:YES];

    
    if(self.PasscodeTXT.text==nil || [self.PasscodeTXT.text length]<=0)
    {
        [SVProgressHUD show];

        [self.PasscodeTXT resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"please input passcode" timeDalay:1.0f];
    }
    
    else{
        NSDictionary *LoginDict;
        LoginDict=  @{@"password":self.PasscodeTXT.text,@"user_type":UserType,};
        
        [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
        [helper loginApi:LoginDict];
    }


  

}


-(void)moveToDashboard
{
    SITSDashboardVC *GuestDashboard =[[SITSDashboardVC alloc] init];
    [self.navigationController pushViewController:GuestDashboard animated:YES];
}
- (IBAction)GuestUserAction:(id)sender {
    SETVALUE(USER_TYPE_GUEST, SELECTED_USER_TYPE);
    self.LoginVW.hidden=YES;
    UserType=USER_TYPE_GUEST;

    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.RoleIMG.image=[UIImage imageNamed:@"guest.png"];


    } completion:^(BOOL finished)
     {
         [self moveToDashboard];
     }];
   
}

- (IBAction)SalesAction:(id)sender {
    SETVALUE(USER_TYPE_SALES, SELECTED_USER_TYPE);
    
    UserType=USER_TYPE_SALES;
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        self.RoleIMG.image=[UIImage imageNamed:@"sales.png"];
    } completion:^(BOOL finished)
     {

     }];

    self.LoginVW.hidden=NO;

}

- (IBAction)DealerAction:(id)sender {
    SETVALUE(USER_TYPE_RETAILERS, SELECTED_USER_TYPE);

    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        self.RoleIMG.image=[UIImage imageNamed:@"dealers.png"];

    } completion:^(BOOL finished)
     {
        
         
     }];

    UserType=USER_TYPE_RETAILERS;
    self.LoginVW.hidden=NO;


}
-(void)hideViewWithAnimation
{
    self.GuestBTN.layer.borderColor = [UIColor redColor].CGColor;
    self.GuestBTN.layer.borderWidth = 1;
    [[self.GuestBTN layer] setCornerRadius:5.0f];
    [[self.GuestBTN layer] setMasksToBounds:YES];
}


-(void)showViewWithAnimation
{
    
}
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);

    if([apiName isEqualToString:@"loginApi"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                SETVALUE(UserType, SELECTED_USER_TYPE);
                [MyCustomClass SVProgressMessageDismissWithSuccess:[dataDic valueForKey:@"msg"]  timeDalay:1.0];
                [self moveToDashboard];


                
            });
        }
        else
        {
            [MyCustomClass SVProgressMessageDismissWithError:[dataDic objectForKey:@"msg"] timeDalay:2.0];
        }
    }
    
    
    
}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:2.0];
}


@end
