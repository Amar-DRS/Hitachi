//
//  SITSBroucherDetailVC.m
//  Hitachi
//
//  Created by Apple on 29/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSBroucherDetailVC.h"
#import "define.h"
#import <SafariServices/SafariServices.h>


@interface SITSBroucherDetailVC ()
{
    NSMutableString *BroucherURL;
    NSMutableString *BroucherPDFURL;
    NSMutableArray *BroucherARR;
    MyWebServiceHelper *helper;

}
@end

@implementation SITSBroucherDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    BroucherURL=[[NSMutableString alloc] initWithString:@""];
    BroucherPDFURL=[[NSMutableString alloc] initWithString:@""];

    [self.BroucherCV registerNib:[UINib nibWithNibName:@"SITSBroucherCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.BroucherCV.delegate=self;
    self.BroucherCV.dataSource=self;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    BroucherARR =[[NSMutableArray alloc] init];
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    NSDictionary *BrouchersInput;
    BrouchersInput=  @{@"action":@"product_brochures_details",};
    
    [helper BroucherList:BrouchersInput];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnSingleTapViewPDF)];
    singleTap.numberOfTapsRequired = 1;
    [self.BrouchDetailIMG setUserInteractionEnabled:YES];
    [self.BrouchDetailIMG addGestureRecognizer:singleTap];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    
    if([apiName isEqualToString:@"BroucherList"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            [BroucherARR removeAllObjects];
            BroucherARR =[dataDic valueForKey:@"brochures"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_BroucherCV reloadData];
                [self SelectFirstItem];
                [MyCustomClass SVProgressMessageDismissWithSuccess:@""  timeDalay:1.0];
                
            });
        }
        else
        {
            [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:0.0];
        }
    }
    
    
    
}




-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:2.0];
}


-(void)SelectFirstItem
{
    NSIndexPath *selection = [NSIndexPath indexPathForItem:0
                                                 inSection:0];
    [self.BroucherCV selectItemAtIndexPath:selection
                                  animated:YES
                            scrollPosition:UICollectionViewScrollPositionNone];
    [self UpdateBroucherIMG:[NSURL URLWithString:[[[BroucherARR objectAtIndex:0] valueForKey:@"product_brochures"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    BroucherPDFURL=[[BroucherARR objectAtIndex:0] valueForKey:@"product_brochures_pdf"];

}


- (IBAction)BackAct:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)DownloadAct:(id)sender {
    NSURL *url = [NSURL URLWithString:BroucherURL];
    
    // download the image asynchronously
    [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            
        }
    }];
}
- (IBAction)ShareAct:(id)sender {
    
    NSString *textToShare = BROUCHER_SHARE_TEXT;
    NSURL *myWebsite = [NSURL URLWithString:BroucherPDFURL];
    UIImage *SharingImage=self.BrouchDetailIMG.image;
    //NSArray *objectsToShare = @[SharingImage];
    NSArray *objectsToShare;
    if ([BroucherPDFURL isEqualToString:@""])
    {
        objectsToShare = @[SharingImage];
        
        
    }
    else
    {
        objectsToShare = @[textToShare,myWebsite];
        
    }
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
//    if (IS_IPAD)
//    {
//        NSLog(@"iPad");
//        activityVC.popoverPresentationController.sourceView = self.view;
//        //        activityViewController.popoverPresentationController.sourceRect = self.frame;
//        [self presentViewController:activityVC
//                           animated:YES
//                         completion:nil];
//    }
//    else
//    {
        NSLog(@"iPhone");
        [self presentViewController:activityVC animated:YES completion:nil];

   // }
    

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
    if (error) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"ERROR"
                                                         message:Download_Broucher_Failed
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert show];    }
    
    else {
        
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Success"
                                                         message:Download_Broucher_Success
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   //
    return [BroucherARR count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(125,125);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *identifier = @"cell";
        SITSBroucherCell *cell;
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
       // cell.BrouchLBL.text=[NSString stringWithFormat:@"%@",[[BroucherARR objectAtIndex:indexPath.row] objectForKey:@"title"]];
       //    UIImageView *BGVIEW=[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"splash.png"]]]
    cell.selectedBackgroundView=  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Frame.png"]];
    
    cell.BrouchIMG.image=nil;
    cell.BrouchIMG.showActivityIndicator=YES;
    cell.BrouchIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    cell.BrouchIMG.imageURL=[NSURL URLWithString:[[[BroucherARR objectAtIndex:indexPath.row] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        //cell.BrouchIMG.image=[UIImage imageNamed:@"splash.png"];
    cell.BrouchLBL.text=[[BroucherARR objectAtIndex:indexPath.row] valueForKey:@"brochures_title"];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"item clicked");
    [self UpdateBroucherIMG:[NSURL URLWithString:[[[BroucherARR objectAtIndex:indexPath.row] valueForKey:@"product_brochures"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    BroucherPDFURL=[[BroucherARR objectAtIndex:indexPath.row] valueForKey:@"product_brochures_pdf"];
}

-(void)UpdateBroucherIMG:(NSURL *)imgURL
{
    BroucherURL=[imgURL.absoluteString mutableCopy];
     self.BrouchDetailIMG.image=nil;
     self.BrouchDetailIMG.showActivityIndicator=YES;
     self.BrouchDetailIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
     // NSLog(@"URL1>>%@",[NSURL URLWithString:[[[FVArr objectAtIndex:2*indexPath.row] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
     self.BrouchDetailIMG.imageURL=imgURL;
}

-(void)ViewPDF
{
   // NSString *sURL = @"http://www.adobe.com/content/dam/Adobe/en/devnet/acrobat/pdfs/pdf_open_parameters.pdf";
    NSURL *URL = [NSURL URLWithString:BroucherPDFURL];
    // SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL]; // 1.
    SFSafariViewController *safari = [[SFSafariViewController alloc] initWithURL:URL entersReaderIfAvailable:YES]; // 2.
    [self presentViewController:safari animated:YES completion:nil];
}

-(void)OnSingleTapViewPDF{
    [self ViewPDF];
    NSLog(@"single Tap on imageview");
}

@end
