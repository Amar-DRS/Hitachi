//
//  SITSFeaturedVC.m
//  Hitachi
//
//  Created by Apple on 13/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSFeaturedVC.h"
#import "define.h"
#import "SITSPVCell.h"


@interface SITSFeaturedVC ()
{
    SITSPVCell*event;
    MyWebServiceHelper *helper;
    SITSFeaturedCell *FeatureCell;
    NSMutableArray *FVArr;
    CGRect OrgFrame;
    CGRect NewFrame;
    NSMutableString *FVURL;
    NSMutableString *FVShareURL;
}
@end

@implementation SITSFeaturedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.DownloadBTN.hidden=YES;
    self.DownloadBTN.userInteractionEnabled=NO;

    if ([GETVALUE(SELECTED_USER_TYPE) isEqual:@1])
    {
        self.DownloadBTN.hidden=NO;
        self.DownloadBTN.userInteractionEnabled=YES;
    }
    FVURL=[[NSMutableString alloc] initWithString:@""];
    FVShareURL=[[NSMutableString alloc] initWithString:@""];

    FeatureCell=[[SITSFeaturedCell alloc]init];
    event=[[SITSPVCell alloc]init];

    self.FeatureProdTV.delegate=self;
    self.FeatureProdTV.dataSource=self;
    FVArr=[[NSMutableArray alloc] init];
    self.playerView.delegate = self;

    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    
   
    
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    NSDictionary *FeaturedVideoInput;
    FeaturedVideoInput=  @{@"action":@"feature_video",};
    [helper FeaturedVideoList:FeaturedVideoInput];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)initYoutube:(NSString*)videoId
{
    NSDictionary *playerVars = @{
                                 @"controls" : @1,
                                 @"playsinline" : @1,
                                 @"autohide" : @1,
                                 @"showinfo" : @0,
                                 @"modestbranding" : @1,
                                 @"autoplay" : @1,
                                 };
    [self.playerView loadWithVideoId:videoId playerVars:playerVars];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedPlaybackStartedNotification:)
                                                 name:@"Playback started"
                                               object:nil];
    [self.playerView playVideo];
}
-(void)PlayYouTubeVideo:(NSString*)videoId
{
 [self.playerView cueVideoById:videoId startSeconds:0.0 suggestedQuality:kYTPlaybackQualityAuto];
 [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedPlaybackStartedNotification:)
                                                 name:@"Playback started"
                                               object:nil];
 [self.playerView playVideo];
}

- (void)playerView:(YTPlayerView *)ytPlayerView didChangeToState:(YTPlayerState)state {
   // NSString *message = [NSString stringWithFormat:@"Player state changed: %ld\n", (long)state];
   // NSLog(@"message>>%@",message);
}

- (void)playerView:(YTPlayerView *)playerView didPlayTime:(float)playTime {
  //  float progress = playTime/self.playerView.duration;//..NSLog(@"progress>>%f",progress);
}

- (void)receivedPlaybackStartedNotification:(NSNotification *) notification {
    if([notification.name isEqual:@"Playback started"] && notification.object != self) {
        [self.playerView pauseVideo];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackAct:(id)sender {
    [self.playerView pauseVideo];
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FVArr count];
   // return ([FVArr count]/2);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"FeaturedCell";
    event = (SITSPVCell *)[self.FeatureProdTV dequeueReusableCellWithIdentifier:CellIdentifier];
    if (event == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"SITSPVCell" owner:self options:nil];
        event = [cellArray objectAtIndex:0];
    }
    event.selectionStyle=UITableViewCellSelectionStyleNone;
    event.ProductFirIMG.image=nil;
    event.ProductFirIMG.showActivityIndicator=YES;
    event.ProductFirIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    event.ProductFirIMG.imageURL=[NSURL URLWithString:[[[FVArr objectAtIndex:indexPath.row] valueForKey:@"thumbnail"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    event.ProductFirLBL.text=[[FVArr objectAtIndex:indexPath.row] valueForKey:@"video_name"];
    event.ProductDescLBL.text=[[FVArr objectAtIndex:indexPath.row] valueForKey:@"description"];
    event.ProductDLBTN.hidden=YES;

    if ([GETVALUE(SELECTED_USER_TYPE) isEqual:@1])
    {
        event.ProductDLBTN.hidden=NO;
        event.ProductDLBTN.userInteractionEnabled=YES;
        [event.ProductDLBTN addTarget:self action:@selector(ProdDownloadAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    [event.ProductVPlayBTN addTarget:self action:@selector(ProdPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    event.ProductVPlayBTN.tag=event.ProductDLBTN.tag=indexPath.row;
    return  event;
}



-(void)ProdPlayAction:(id)sender
{
    [self ProdDetail:sender];
}

-(void)ProdDownloadAction:(id)sender
{
   // [self ProdDetail:sender];
    [self.playerView pauseVideo];

    FVURL= [[FVArr objectAtIndex:[sender tag]] valueForKey:@"feature_video"];
    [self DownloadVideo];

}

-(void)ProdDetail:(id)sender
{
    [self PlayYouTubeVideo:[[FVArr objectAtIndex:[sender tag]] valueForKey:@"video_id"]];
    self.FVNameLBL.text=[[FVArr objectAtIndex:[sender tag]] valueForKey:@"video_name"];
    FVURL= [[FVArr objectAtIndex:[sender tag]] valueForKey:@"feature_video"];
    FVShareURL= [[FVArr objectAtIndex:[sender tag]] valueForKey:@"video_link"];
}

-(void)FirstFVDetail
{
    FVURL= [[FVArr objectAtIndex:0] valueForKey:@"video"];
    FVShareURL= [[FVArr objectAtIndex:0] valueForKey:@"feature_video"];
    
   // self.PVNameLBL.text=[[FVArr objectAtIndex:0] valueForKey:@"title"];
    [self initYoutube:[[FVArr objectAtIndex:0] valueForKey:@"video_id"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}


-(void)FVDetail:(id)sender
{
    [self PlayYouTubeVideo:[[FVArr objectAtIndex:[sender tag]] valueForKey:@"video_id"]];
    self.FVNameLBL.text=[[FVArr objectAtIndex:[sender tag]] valueForKey:@"video_name"];
    FVURL= [[FVArr objectAtIndex:[sender tag]] valueForKey:@"feature_video"];
    FVShareURL= [[FVArr objectAtIndex:[sender tag]] valueForKey:@"video_link"];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    
    if([apiName isEqualToString:@"FeaturedVideoList"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
            
        {
            FVArr=[dataDic valueForKey:@"feature"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.FeatureProdTV reloadData];
                [self FirstFVDetail];
                [MyCustomClass SVProgressMessageDismissWithSuccess:@""  timeDalay:0.0];
 
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
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:0.0];
}



- (IBAction)buttonPressed:(id)sender {
//    if (sender == self.playButton) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"Playback started" object:self];
//        [self.playerView playVideo];
//    }
//    else
    
        if (sender == self.ShareBTN)
    {
        [self.playerView pauseVideo];
        [self ShareAction];
    }
    else if (sender == self.DownloadBTN)
    {
        [self.playerView pauseVideo];
        [self DownloadVideo];
    }
}


-(void)ShareAction
{
    NSString *textToShare = FV_SHARE_TEXT;
    NSURL *myWebsite = [NSURL URLWithString:FVShareURL];
    
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
-(void)DownloadVideo
{

    [MyCustomClass SVProgressViewWithShowingMessage:@"Downloading"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Downloading Started");
        NSString *urlToDownload = FVURL;
        NSURL  *url = [NSURL URLWithString:urlToDownload];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            NSString  *filePath =
            [documentsDirectory stringByAppendingFormat:@"/vid1.mp4"];
            //saving is done on main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                [urlData writeToFile:filePath atomically:YES];
                ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                [library writeVideoAtPathToSavedPhotosAlbum:[NSURL fileURLWithPath:filePath] completionBlock:^(NSURL *assetURL, NSError *error) {
                    if (error) {
                        NSLog(@"%@", error.description);
                    }else {
                        NSLog(@"Done :)");
                    }
                }];
                [MyCustomClass SVProgressMessageWithImmediateDismiss];
            });
        }
        
    });
    
}
@end
