//
//  OffersVC.m
//  Hitachi
//
//  Created by Apple on 05/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "OffersVC.h"

@interface OffersVC ()
{
    SITSOfferCell * offerCell;
    MyWebServiceHelper *helper;
    NSMutableArray *OfferArr;

}
@end

@implementation OffersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    OfferArr=[[NSMutableArray alloc] init];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.OfferTV.delegate=self;
    self.OfferTV.dataSource=self;
    [self.OfferTV setBackgroundColor:[UIColor clearColor]];
    offerCell=[[SITSOfferCell alloc]init];
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    NSDictionary *OfferInput;
    OfferInput=  @{@"action":@"product_offers",};

    [helper OfferList:OfferInput];
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
    int rowcount=(int)[OfferArr count]/2;
    if ([OfferArr count]%2==1)
    {
        rowcount=rowcount+1;
    }
    return rowcount;
  //  return [OfferArr count]/2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"EventCellTableViewCell";
    offerCell = (SITSOfferCell *)[self.OfferTV dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (offerCell == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"SITSOfferCell" owner:self options:nil];
        offerCell = [cellArray objectAtIndex:0];
    }
    offerCell.selectionStyle=UITableViewCellSelectionStyleNone;
    offerCell.OfferFirIMG.image=nil;
    offerCell.OfferFirIMG.showActivityIndicator=YES;
    offerCell.OfferFirIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    NSLog(@"URL1>>%@",[NSURL URLWithString:[[[OfferArr objectAtIndex:2*indexPath.row] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
    offerCell.OfferFirIMG.imageURL=[NSURL URLWithString:[[[OfferArr objectAtIndex:2*indexPath.row] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    offerCell.NameFirLBL.text=[[OfferArr objectAtIndex:2*indexPath.row] valueForKey:@"offer_name"];

    // ssecond image data filling
    if (indexPath.row+1<=[OfferArr count]/2)
    {
        offerCell.NameSecLBL.text=[[OfferArr objectAtIndex:2*indexPath.row+1] valueForKey:@"offer_name"];

    offerCell.OfferSecIMG.image=nil;
    offerCell.OfferSecIMG.showActivityIndicator=YES;
    offerCell.OfferSecIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    NSLog(@"URL2>>%@",[NSURL URLWithString:[[[OfferArr objectAtIndex:2*indexPath.row+1] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
    offerCell.OfferSecIMG.imageURL=[NSURL URLWithString:[[[OfferArr objectAtIndex:2*indexPath.row+1] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [offerCell.OfferSecBTN addTarget:self action:@selector(OfferSecAction:) forControlEvents:UIControlEventTouchUpInside];
        offerCell.OfferSecBTN.tag=2*indexPath.row+1;


    }
    [offerCell.OfferFirBTN addTarget:self action:@selector(OfferFirAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //     NSLog(@"%ld",(long)indexPath.row);
    offerCell.OfferFirBTN.tag=2*indexPath.row;
//    offerCell.ProductFirBTN.tag=2*indexPath.row;
//    offerCell.ProductSecBTN.tag=2*indexPath.row+1;
    
    return  offerCell;
    
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

-(void)OfferFirAction:(id)sender
{
    UIButton *SelectBTN=(UIButton *)sender;
    [SelectBTN setHighlighted:YES];
    [self MoveOfferDetail:sender];

}


-(void)OfferSecAction:(id)sender
{
    [self MoveOfferDetail:sender];

}

-(void)MoveOfferDetail:(id)sender
{
    SITSOfferDetailVC *OfferDetail=[[SITSOfferDetailVC alloc] init];
    OfferDetail.OfferName=[[OfferArr objectAtIndex:[sender tag]] valueForKey:@"offer_name"];
    OfferDetail.OfferIMGURL=[[[OfferArr objectAtIndex:[sender tag]] valueForKey:@"attachment"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    [self.navigationController pushViewController:OfferDetail animated:YES];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    
    if([apiName isEqualToString:@"OfferList"])
    {
        
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
            
        {
            [OfferArr removeAllObjects];
            [OfferArr addObjectsFromArray:[dataDic objectForKey:@"offers"]];
            NSLog(@"OfferArr>>%@",OfferArr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.OfferTV reloadData];
                    [MyCustomClass SVProgressMessageDismissWithSuccess:@""  timeDalay:0.0];
                
 
            });
        }
        else
        {
            
            [MyCustomClass SVProgressMessageDismissWithError:[dataDic objectForKey:@"Data Not available"] timeDalay:2.0];
        }
    }
    
    
    
}

-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:2.0];
}

@end
