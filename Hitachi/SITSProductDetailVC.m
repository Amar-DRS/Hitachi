//
//  SITSProductDetailVC.m
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSProductDetailVC.h"
#import <SafariServices/SafariServices.h>
#import "CustomAlbum.h"
#import "define.h"
#import "SITSTVCVC.h"
#import "SITSProductVideosVC.h"

@interface SITSProductDetailVC ()
{
    MyWebServiceHelper *helper;
    BSEDropDownVW *DDView;
    NSMutableString *BroucherURL;
    BOOL IsDDViewOpen;
}
@end

@implementation SITSProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    IsDDViewOpen=NO;
    // Do any additional setup after loading the view from its nib.
    self.ProductSVW.contentSize = self.FeaturesSpecIMG.frame.size;
    self.ProductSVW.delegate=self;
    self.ProductSVW.scrollEnabled = NO;
    
    // For supporting zoom,
    self.ProductSVW.minimumZoomScale = 1.0;
    self.ProductSVW.maximumZoomScale = 2.0;
    

    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    //add the your gestureRecognizer , where to detect the touch..
    [self.ProductSVW addGestureRecognizer:rightRecognizer];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.ProductSVW addGestureRecognizer:leftRecognizer];

    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self.FeaturesSpecIMG setUserInteractionEnabled:YES];
    [self.FeaturesSpecIMG addGestureRecognizer:singleTap];
  
    DDView =[[BSEDropDownVW alloc] initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width-200, self.DDBTN.frame.origin.y+self.DDBTN.frame.size.height-5, 200,200)];
    DDView.dropDownData=[NSArray arrayWithObjects:@"Watch Demo",@"Watch TVC",@"Download Brochure",@"Share", nil];
    DDView.dropDownIMGData=[NSArray arrayWithObjects:@"pdemo1.png",@"ptvc1.png",@"pdb1.png",@"pshare1.png", nil];

    [self.view addSubview:DDView];
    DDView.bseDropDownVWDelegateObj=self;
   
    //
  //  [self createAlbum];
    BroucherURL=[[NSMutableString alloc] initWithString:@""];
    [self HideDDView];
    [self ShowProductDetail:[self.ProductsArr objectAtIndex:self.CurrentProduct]];

}
-(void)tapDetected{
    [self HideDDView];

    if ([BroucherURL isEqualToString:@""])
    {
        return;
    }
    [self ViewPDF];
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self HideDDView];
    if(self.CurrentProduct<=0)
    {
        return;
    }
    self.CurrentProduct=self.CurrentProduct-1;
    [self ShowProductDetail:[self.ProductsArr objectAtIndex:self.CurrentProduct]];

}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self HideDDView];

    NSLog(@"leftSwipeHandle1");
    if(self.CurrentProduct>=[_ProductsArr count]-1)
    {
        return;
    }
    self.CurrentProduct=self.CurrentProduct+1;
    [self ShowProductDetail:[self.ProductsArr objectAtIndex:self.CurrentProduct]];

    
    NSLog(@"leftSwipeHandle2");

}
- (void)createAlbum
{
    [CustomAlbum makeAlbumWithTitle:ALBUM_NAME onSuccess:^(NSString *AlbumId)
     {
         SETVALUE(AlbumId, ALBUM_ID);
     }
                            onError:^(NSError *error) {
                                NSLog(@"probelm in creating album");
                            }];
}

// Implement a single scroll view delegate method
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
    return self.FeaturesSpecIMG;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)DemoAction:(id)sender
{
    
}

-(void)TVCAction:(id)sender
{
    
}

-(void)ShareAction:(id)sender
{

}
-(void)DownloadBroucherAction
{        [self HideDDView];

    if ([BroucherURL isEqualToString:@""])
    {
        [MyCustomClass SVProgressViewWithShowingMessage:@"Downloading..."];
        NSURL *url = [NSURL URLWithString: [[[self.ProductsArr objectAtIndex:self.CurrentProduct] valueForKey:@"product_pic"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        // download the image asynchronously
        [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
            }
        }];
    }
    
    
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   image=[UIImage imageWithData:data];
                                   UIImageWriteToSavedPhotosAlbum(image,
                                                                  self, // send the message to 'self' when calling the callback
                                                                  @selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:), // the selector to tell the method to call on completion
                                                                  NULL); // you generally won't need a contextInfo here
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}
- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo {
    
    [MyCustomClass SVProgressMessageWithImmediateDismiss];
    
}

-(void)DDShareAction
{
    [self HideDDView];

    
    
    NSString *textToShare = PRODDETAIL_SHARE_TEXT;
    NSURL *myWebsite = [NSURL URLWithString:BroucherURL];
    UIImage *ShareImage=_FeaturesSpecIMG.image;
    NSArray *objectsToShare;
    if ([BroucherURL isEqualToString:@""])
    {
        objectsToShare = @[ShareImage];
  
        
    }
    else
    {
        objectsToShare = @[textToShare,myWebsite];

    }
   // NSArray *objectsToShare = @[textToShare,myWebsite,ShareImage];
  //  NSMutableArray *objectsToShare=[[NSMutableArray alloc] initWithObjects:textToShare,textToShare1, nil];
   // NSArray *objectsToShare = @[textToShare,textToShare1,textToShare2];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;

    [self presentViewController:activityVC animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)DDBTNAct:(id)sender {
    [self ShowDDView];
}

- (IBAction)BackAct:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)ShowProductDetail:(NSDictionary*)Detail
{
    NSLog(@"dataDic>>>>%@",Detail);
    self.ProdNameLBL.text=[Detail valueForKey:@"Product_name"];
    _FeaturesSpecIMG.image=nil;
    _FeaturesSpecIMG.showActivityIndicator=YES;
    _FeaturesSpecIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    _FeaturesSpecIMG.imageURL=[NSURL URLWithString:[[Detail valueForKey:@"product_pic"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    if ([[Detail valueForKey:@"product_brochures_pdf"] isEqualToString:@""]) {
        BroucherURL=[@"" mutableCopy];
    }
    else
    {
    BroucherURL=[Detail valueForKey:@"product_brochures_pdf"];
    }
}


-(void)ShowDDView
{
    IsDDViewOpen=YES;
    DDView.hidden=NO;

}

-(void)HideDDView
{
    IsDDViewOpen=NO;
    DDView.hidden=YES;
    
}

-(void) selectedDropDownItem:(NSString *)str
{
    [self HideDDView];
    if([str isEqualToString:@"Watch Demo"])
    {
        SITSProductVideosVC *ProductVC=[[SITSProductVideosVC alloc] init];
        [self.navigationController pushViewController:ProductVC animated:YES];
    }
    else  if([str isEqualToString:@"Watch TVC"])
    {
        SITSTVCVC *TVC=[[SITSTVCVC alloc] init];
        [self.navigationController pushViewController:TVC animated:YES];
    }
    else  if([str isEqualToString:@"Download Brochure"])
    {
        [self DownloadBroucherAction];
    }
    else  if([str isEqualToString:@"Share"])
    {
        [self DDShareAction];
    }
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);

    if([apiName isEqualToString:@"ProductDetail"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self ShowProductDetail:[dataDic valueForKey:@"product_details"]];
                [MyCustomClass SVProgressMessageDismissWithSuccess:[dataDic valueForKey:@"msg"]  timeDalay:1.0];
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
-(void)ViewPDF
{
  //  NSString *sURL = BroucherURL;
    NSURL *URL = [NSURL URLWithString:BroucherURL];
    SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL entersReaderIfAvailable:YES]; // 2.
    [self presentViewController:safari animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    NSLog(@"touches began");
    if((IsDDViewOpen=YES)){
        [self HideDDView];
    }
}


- (IBAction)MoveToDashboard:(id)sender {
    
    NSArray *allViewControllers = [self.navigationController viewControllers];
    for (UIViewController *aViewController in allViewControllers) {
        if ([aViewController isKindOfClass:[SITSDashboardVC class]]) {
            [self.navigationController popToViewController:aViewController  animated:YES];
        }
    }
}

@end
