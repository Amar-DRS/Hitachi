//
//  SITSPOPVC.m
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSPOPVC.h"

@interface SITSPOPVC ()
{
    SITSPOPCell * POPCell;
    NSMutableArray *POPArr;
    MyWebServiceHelper *helper;

}
@end

@implementation SITSPOPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    POPArr=[[NSMutableArray alloc] init];
    self.POPTV.delegate=self;
    self.POPTV.dataSource=self;
    [self.POPTV setBackgroundColor:[UIColor clearColor]];
    POPCell=[[SITSPOPCell alloc]init];
    
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
   
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    NSDictionary *POPInput;
    POPInput=  @{@"action":@"avilable_pop",};
    
    [helper POPList:POPInput];

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowcount=(int)[POPArr count]/2;
    if ([POPArr count]%2==1)
    {
        rowcount=rowcount+1;
    }
    return rowcount;
    //return [POPArr count]/2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"EventCellTableViewCell";
    POPCell = (SITSPOPCell *)[self.POPTV dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (POPCell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"SITSPOPCell" owner:self options:nil];
        POPCell = [cellArray objectAtIndex:0];
    }
    POPCell.selectionStyle=UITableViewCellSelectionStyleNone;
    [POPCell.POPFirBTN addTarget:self action:@selector(POPFirAction:) forControlEvents:UIControlEventTouchUpInside];
    [POPCell.POPSecBTN addTarget:self action:@selector(POPSecAction:) forControlEvents:UIControlEventTouchUpInside];
    
    POPCell.selectionStyle=UITableViewCellSelectionStyleNone;
    POPCell.POPFirIMG.image=nil;
    POPCell.POPFirIMG.showActivityIndicator=YES;
    POPCell.POPFirIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    NSLog(@"URL1>>%@",[NSURL URLWithString:[[[POPArr objectAtIndex:2*indexPath.row] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
    POPCell.POPFirIMG.imageURL=[NSURL URLWithString:[[[POPArr objectAtIndex:2*indexPath.row] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    POPCell.NameFirLBL.text=[[POPArr objectAtIndex:2*indexPath.row] valueForKey:@"name"];
    [POPCell.POPFirBTN addTarget:self action:@selector(POPFirAction:) forControlEvents:UIControlEventTouchUpInside];
    POPCell.POPFirBTN.tag=2*indexPath.row;
    
    // ssecond image data filling
    if (indexPath.row+1<=[POPArr count]/2)
    {
        POPCell.NameSecLBL.text=[[POPArr objectAtIndex:2*indexPath.row+1] valueForKey:@"name"];
        POPCell.POPSecIMG.image=nil;
        POPCell.POPSecIMG.showActivityIndicator=YES;
        POPCell.POPSecIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
        NSLog(@"URL2>>%@",[NSURL URLWithString:[[[POPArr objectAtIndex:2*indexPath.row+1] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
        POPCell.POPSecIMG.imageURL=[NSURL URLWithString:[[[POPArr objectAtIndex:2*indexPath.row+1] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [POPCell.POPSecBTN addTarget:self action:@selector(POPSecAction:) forControlEvents:UIControlEventTouchUpInside];
        POPCell.POPSecBTN.tag=2*indexPath.row+1;
    }
    return  POPCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100
    ;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)POPFirAction:(id)sender
{
    [self MoveOfferDetail:sender];
    
}


-(void)POPSecAction:(id)sender
{
    [self MoveOfferDetail:sender];
    
}

-(void)MoveOfferDetail:(id)sender
{
    

    SITSPOPDetails *POPDetail=[[SITSPOPDetails alloc] init];
    POPDetail.POPName=[[POPArr objectAtIndex:[sender tag]] valueForKey:@"name"];
    POPDetail.POPIMGURL=[[[POPArr objectAtIndex:[sender tag]] valueForKey:@"attachment"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.navigationController pushViewController:POPDetail animated:YES];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    
    if([apiName isEqualToString:@"POPList"])
    {
        
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
            
        {
            [POPArr removeAllObjects];
            [POPArr addObjectsFromArray:[dataDic objectForKey:@"avilable_pop"]];
            NSLog(@"OfferArr>>%@",POPArr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.POPTV reloadData];
                [MyCustomClass SVProgressMessageDismissWithSuccess:@""  timeDalay:0.0];
                
                
            });
        }
        else
        {
            
            [MyCustomClass SVProgressMessageDismissWithError:[dataDic objectForKey:@"Data Not available"] timeDalay:0.0];
        }
    }
    
    
    
}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:2.0];
}

@end
