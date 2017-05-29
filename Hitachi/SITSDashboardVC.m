//
//  SITSDashboardVC.m
//  Hitachi
//
//  Created by Apple on 05/01/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import "SITSDashboardVC.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <SafariServices/SafariServices.h>

@interface SITSDashboardVC ()
{
    NSMutableArray *OfferArr;
    MyWebServiceHelper *helper;
    long TouchedRow;
}
@end

@implementation SITSDashboardVC

- (void)viewDidLoad {
    
//    NSLog(@"getDeviceID>>%@",[MyCustomClass getDeviceID]);
//    NSLog(@"getDeviceMacAddress>>%@",[MyCustomClass getDeviceMacAddress]);
//    NSLog(@"getDeviceLocalIPAddress>>%@",[MyCustomClass getDeviceLocalIPAddress]);
//    NSLog(@"getIPAddress>>%@",[self getIPAddress]);
//
//    NSString *publicIP = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"https://icanhazip.com/"] encoding:NSUTF8StringEncoding error:nil];
//    publicIP = [publicIP stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]; // IP comes with a newline for some reason
//    NSLog(@"getIPAddress1>>%@",publicIP);

    
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.BackIMG.hidden=YES;
    self.BGLBL.hidden=NO;
    [self.BGLBL setBackgroundColor:[UIColor blackColor]];
    self.HItachiLBL.hidden=NO;

    self.ItemTV.delegate=self;
    self.ItemTV.dataSource=self;
    [self.ItemTV registerNib:[UINib nibWithNibName:@"SITSDashBoardCCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];

    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
//    NSArray *ItemArr;
 //   ItemArr=[NSArray arrayWithObjects:@1,@2,@3,@4,@5,@6,@7, nil];
    OfferArr =[[NSMutableArray alloc] init];

    // Do any additional setup after loading the view from its nib.
     NSDictionary *Input;
     Input=  @{@"action":@"acccess_folder",@"usertype":GETVALUE(SELECTED_USER_TYPE),};

     [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
     [helper DashboardList:Input];
}

//- (NSString *)getIPAddress
//
//{    NSString *address = @"error";    struct ifaddrs *interfaces = NULL;   struct ifaddrs *temp_addr = NULL;    int success = 0;
//    
//    // retrieve the current interfaces - returns 0 on success
//    
//    success= getifaddrs(&interfaces);    if (success == 0)
//    {
//        // Loop through linked list of interfaces
//        temp_addr = interfaces;
//        while (temp_addr != NULL)
//            
//        {
//            if( temp_addr->ifa_addr->sa_family == AF_INET)
//                
//            {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
//                    
//                {
//                    // Get NSString from C String
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//            
//            temp_addr = temp_addr->ifa_next;
//        }   
//        
//    }
//    
//    // Free memory   freeifaddrs(interfaces);
//    
//    return address; 
//    
//}
//
//



- (void)viewWillAppear:(BOOL)animated {
    [self.ItemTV reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackBtnAction:(id)sender {
  //  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- collection view delegate --


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier1 = @"CollectionCell";
    SITSDashBoardCCellCollectionViewCell *ItemCell= [collectionView dequeueReusableCellWithReuseIdentifier:MyIdentifier1 forIndexPath:indexPath];
    
    ItemCell.imgView.image=nil;
    ItemCell.imgView.showActivityIndicator=YES;
        ItemCell.imgView.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    ItemCell.imgView.imageURL=[NSURL URLWithString:[[[OfferArr objectAtIndex:indexPath.row] valueForKey:@"icon"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ItemCell.TagLBL.text=[[OfferArr objectAtIndex:indexPath.row] valueForKey:@"product_name"];
   // NSLog(@"ItemCell.TagLBL.text>>%@",ItemCell.TagLBL.text);
   // ItemCell.backgroundColor=[UIColor greenColor];
    return ItemCell;
}

//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"rowcoint???%lu",(unsigned long)[self.ItemArr count]);
    return [OfferArr count];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self OfferFirAction:indexPath.row];
}



#pragma mark Collection view layout things
// Layout: Set cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"SETTING SIZE FOR ITEM AT INDEX %ld", (long)indexPath.row);
    CGSize mElementSize;
    if (IS_IPAD) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        float cellWidth = screenWidth / 3.0; //Replace the divisor with the column count requirement. Make sure to have it in float.
        CGFloat screenHeight = screenRect.size.height;
        float cellHeight = screenHeight/4.0;
        mElementSize= CGSizeMake(cellWidth, cellHeight);
    }
    else
    {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        float cellWidth = screenWidth / 2.0; //Replace the divisor with the column count requirement. Make sure to have it in float.
        CGFloat screenHeight = screenRect.size.height-self.BGLBL.frame.size.height-2;
        float cellHeight = screenHeight/([OfferArr count]/2);
        mElementSize= CGSizeMake(cellWidth, cellHeight);
    }
    return mElementSize;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}


// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}




-(UIImage *)GetImageFromIndex:(int )Index
{
    UIImage *ListImage;
    switch (Index) {

        case 1:
            ListImage= [UIImage imageNamed:@"products.png"];
            break;
        case 2:
            ListImage= [UIImage imageNamed:@"brochures.png"];
            break;
        case 3:
            ListImage= [UIImage imageNamed:@"f-videos.png"];
            break;
        case 4:
            ListImage= [UIImage imageNamed:@"p-videos.png"];
            break;
        case 5:
            ListImage= [UIImage imageNamed:@"offers.png"];
            break;
        case 6:
            ListImage= [UIImage imageNamed:@"a-pop.png"];
            break;
        case 7:
            ListImage= [UIImage imageNamed:@"guidelines.png"];
            break;

        default:
            break;
    }
    return ListImage;

}



-(void)OfferFirAction:(long)sender
{
    
    
    
    
   // TouchedRow=[sender tag];
   // [self.ItemTV reloadData];
//    NSLog(@"%ld",[sender tag]);
//    NSLog(@"%@",[OfferArr objectAtIndex:[sender tag]]);

    NSString *ProdType=[[OfferArr objectAtIndex:sender] valueForKey:@"product_name"];
    
    if ([ProdType isEqualToString:@"PRODUCTS"]) {
        ProductsVC *ProductDash=[[ProductsVC alloc] init];
        [self.navigationController pushViewController:ProductDash animated:YES];
    } else if ([ProdType isEqualToString:@"BROCHURES"])
    {
        
    
        SITSBroucherDetailVC *BroucherDash=[[SITSBroucherDetailVC alloc] init];
        [self.navigationController pushViewController:BroucherDash animated:YES];
    }
    else if ([ProdType isEqualToString:@"FEATURE VIDEOS"])
    {
        SITSFeaturedVC *FeaturedDash=[[SITSFeaturedVC alloc] init];
        [self.navigationController pushViewController:FeaturedDash animated:YES];
    }
    else if ([ProdType isEqualToString:@"PRODUCT VIDEOS"])
    {
        SITSProductVideosVC *ProductDash=[[SITSProductVideosVC alloc] init];
        [self.navigationController pushViewController:ProductDash animated:YES];
    }
    else if ([ProdType isEqualToString:@"OFFERS"])
    {
        OffersVC *Offer=[[OffersVC alloc] init];
        [self.navigationController pushViewController:Offer animated:YES];
    }
    else if ([ProdType isEqualToString:@"AVAILABLE POP"])
    {
        SITSPOPVC *POP=[[SITSPOPVC alloc] init];
        [self.navigationController pushViewController:POP animated:YES];
    }
    else if ([ProdType isEqualToString:@"GUIDELINES"])
    {
        SITSGuidelineVC *Guideline=[[SITSGuidelineVC alloc] init];
        [self.navigationController pushViewController:Guideline animated:YES];
    }
    
    else if ([ProdType isEqualToString:@"FAQs"])
    {
        SITSFAQsVC *FAQs=[[SITSFAQsVC alloc] init];
        [self.navigationController pushViewController:FAQs animated:YES];
    }
    else if ([ProdType isEqualToString:@"Tonnage Calculator"])
    {
        
        NSString *sURL = @"http://www.jci-hitachi.in/tonnage-calculator";
        [self openBrowser:sURL];
    }
    else if ([ProdType isEqualToString:@"Contact"])
    {
        NSString *sURL = @"http://www.jci-hitachi.in/contact-us";
        [self openBrowser:sURL];
    }
    else if ([ProdType isEqualToString:@"Dealer Locator"])
    {
        NSString *sURL = @"http://www.jci-hitachi.in/service/dealer-locator";
        [self openBrowser:sURL];
    }
    else if ([ProdType isEqualToString:@"iCare"])
    {
        NSString *urlString = @"iCare://";
        NSURL *url = [NSURL URLWithString:urlString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://play.google.com/store/apps/details?id=com.sparrowice.icare&hl=en"]];
        }
        
        
        
    }
    
    
}

-(void)openBrowser:(NSString *)urlString
{
    NSURL *URL = [NSURL URLWithString:urlString];

      [[UIApplication sharedApplication] openURL:URL];
    
//    SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL entersReaderIfAvailable:YES]; // 2.
//    [self presentViewController:safari animated:YES completion:nil];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    
    if([apiName isEqualToString:@"DashboardList"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            OfferArr=[[dataDic valueForKey:@"assigned_product"] mutableCopy];
            [self addValueToArray];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.ItemTV reloadData];
                [MyCustomClass SVProgressMessageDismissWithSuccess:[dataDic valueForKey:@"msg"]  timeDalay:1.0];
            });
        }
        else
        {
            [MyCustomClass SVProgressMessageDismissWithError:[dataDic objectForKey:@"msg"] timeDalay:2.0];
        }
    }
    
    
    
}

-(void)addValueToArray
{
    
    NSDictionary *TempObj1=@{
        @"icon":@"http://sparrowice.devanorth.com/uploads/menu/ic_apop.png",
        @"product_list_id" : @10,
        @"product_name" : @"Contact"
        };
    [OfferArr addObject:TempObj1];
    
    NSDictionary *TempObj2=@{
                            @"icon":@"http://sparrowice.devanorth.com/uploads/menu/ic_apop.png",
                            @"product_list_id" : @11,
                            @"product_name" : @"Dealer Locator"
                            };
    [OfferArr addObject:TempObj2];
    
    NSDictionary *TempObj3=@{
                            @"icon":@"http://sparrowice.devanorth.com/uploads/menu/ic_apop.png",
                            @"product_list_id" : @12,
                            @"product_name" : @"Tonnage Calculator"
                            };
    [OfferArr addObject:TempObj3];
    
    NSDictionary *TempObj4=@{
                             @"icon":@"http://sparrowice.devanorth.com/uploads/menu/ic_apop.png",
                             @"product_list_id" : @13,
                             @"product_name" : @"FAQs"
                             };
    [OfferArr addObject:TempObj4];
    
    NSDictionary *TempObj5=@{
                             @"icon":@"http://sparrowice.devanorth.com/uploads/menu/ic_apop.png",
                             @"product_list_id" : @14,
                             @"product_name" : @"iCare"
                             };
    [OfferArr addObject:TempObj5];
   
}
-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:2.0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
