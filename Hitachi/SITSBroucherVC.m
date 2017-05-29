//
//  SITSBroucherVC.m
//  Hitachi
//
//  Created by Apple on 13/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSBroucherVC.h"

@interface SITSBroucherVC ()
{
    MyWebServiceHelper *helper;
}
@end

@implementation SITSBroucherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    NSDictionary *BrouchersInput;
    BrouchersInput=  @{@"action":@"product_brochures_details",};
    
    [helper BroucherList:BrouchersInput];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)BackAct:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    
    if([apiName isEqualToString:@"BroucherList"])
    {
        
        
        
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
            
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MyCustomClass SVProgressMessageDismissWithSuccess:@""  timeDalay:0.0];
                
                [self MoveToDetail];
            });
        }
        else
        {
            [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:0.0];
        }
    }
    
    
    
}


-(void)MoveToDetail
{
    SITSBroucherDetailVC *BroucherDetail=[[SITSBroucherDetailVC alloc] init];
    [self.navigationController pushViewController:BroucherDetail animated:YES];
    

}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:0.0];
}


@end
