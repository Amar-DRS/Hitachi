//
//  SITSPOPDetails.m
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSPOPDetails.h"
#import "define.h"
#import "CustomAlbum.h"
#import "MyCustomClass.h"

@interface SITSPOPDetails ()

@end

@implementation SITSPOPDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.POPLBL.text=self.POPName;
    self.POPDetailsIV.image=nil;
    self.POPDetailsIV.showActivityIndicator=YES;
    self.POPDetailsIV.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    self.POPDetailsIV.imageURL=[NSURL URLWithString:self.POPIMGURL];
    
    self.POPSV.contentSize = self.POPDetailsIV.frame.size;
    self.POPSV.delegate=self;
    self.POPSV.scrollEnabled = NO;
    
    // For supporting zoom,
    self.POPSV.minimumZoomScale = 1.0;
    self.POPSV.maximumZoomScale = 2.0;
    [self createAlbum];
    // Do any additional setup after loading the view from its nib.
}
// Implement a single scroll view delegate method
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
    return self.POPDetailsIV;
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
- (IBAction)BackAct:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)DownloadAct:(id)sender {
     [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    
    NSURL *url = [NSURL URLWithString:self.POPIMGURL];
    
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
   
    [MyCustomClass SVProgressMessageWithImmediateDismiss];

    
    if (error) {
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"ERROR"
                                                         message:Download_POP_Failed
                                                        delegate:self
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles: nil];
        [alert show];    }
    
    else {
        
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Success"
                                                         message:Download_POP_Success
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles: nil];
        [alert show];
        
    }
}

- (IBAction)ShareAct:(id)sender {
//    NSString *textToShare = POP_SHARE_TEXT;
//    NSURL *myWebsite = [NSURL URLWithString:self.POPIMGURL];
    UIImage *ShareIMG=self.POPDetailsIV.image;
    NSArray *objectsToShare = @[ShareIMG];
    
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
