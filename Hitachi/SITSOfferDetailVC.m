//
//  SITSOfferDetailVC.m
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSOfferDetailVC.h"
#import "define.h"


@interface SITSOfferDetailVC ()

@end

@implementation SITSOfferDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.OfferTitleLBL.text=self.OfferName;
    self.OfferIV.image=nil;
    self.OfferIV.showActivityIndicator=YES;
    self.OfferIV.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    self.OfferIV.imageURL=[NSURL URLWithString:self.OfferIMGURL];
    
    self.OfferSW.contentSize = self.OfferIV.frame.size;
    self.OfferSW.delegate=self;
    self.OfferSW.scrollEnabled = NO;
    
    // For supporting zoom,
    self.OfferSW.minimumZoomScale = 1.0;
    self.OfferSW.maximumZoomScale = 2.0;
    // Do any additional setup after loading the view from its nib.
}
// Implement a single scroll view delegate method
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
    return self.OfferIV;
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
- (IBAction)DownloadAct:(id)sender {
   // [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];

    NSURL *url = [NSURL URLWithString:self.OfferIMGURL];
    
    // download the image asynchronously
    [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
          
        }
    }];
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
                                                         message:Download_OFFER_Failed
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert show];    }
    
    else {
     
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Success"
                                                         message:Download_OFFER_Success
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        
    }
}
- (IBAction)Share:(id)sender {
    NSString *textToShare = OFFER_SHARE_TEXT;
    NSURL *myWebsite = [NSURL URLWithString:self.OfferIMGURL];
    
    NSArray *objectsToShare = @[textToShare, myWebsite];
    
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
@end
