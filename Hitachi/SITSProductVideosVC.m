//
//  SITSProductVideosVC.m
//  Hitachi
//
//  Created by Apple on 13/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSProductVideosVC.h"

@interface SITSProductVideosVC ()
{
    SITSPVCell*event;
    NSMutableArray *ProductsArr;
    MyWebServiceHelper *helper;
    
    NSMutableString *FVURL;
    NSMutableString *FVShareURL;

}
@end

@implementation SITSProductVideosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ProductsArr =[[NSMutableArray alloc]init];
    self.DownloadBTN.hidden=YES;
    self.DownloadBTN.userInteractionEnabled=NO;
    
    if ([GETVALUE(SELECTED_USER_TYPE) isEqual:@1])
    {
        self.DownloadBTN.hidden=NO;
        self.DownloadBTN.userInteractionEnabled=YES;
    }
    self.playerView.delegate=self;
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    self.ProductTV.delegate=self;
    self.ProductTV.dataSource=self;
    event=[[SITSPVCell alloc]init];
    FVURL=[[NSMutableString alloc] initWithString:@""];
    FVShareURL=[[NSMutableString alloc] initWithString:@""];

    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    NSDictionary *ProductVideoInput;
    ProductVideoInput=  @{@"action":@"product_video_details",};
    
    [helper ProductVideoList:ProductVideoInput];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initYoutube:(NSString*)videoId
{
    //self.playerView.userInteractionEnabled=NO;
    // For a full list of player parameters, see the documentation for the HTML5 player
    // at: https://developers.google.com/youtube/player_parameters?playerVersion=HTML5
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
    //self.playerView.userInteractionEnabled=NO;
    // For a full list of player parameters, see the documentation for the HTML5 player
    // at: https://developers.google.com/youtube/player_parameters?playerVersion=HTML5
    [self.playerView cueVideoById:videoId startSeconds:0.0 suggestedQuality:kYTPlaybackQualityAuto];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedPlaybackStartedNotification:)
                                                 name:@"Playback started"
                                               object:nil];
    [self.playerView playVideo];
}

- (void)playerView:(YTPlayerView *)ytPlayerView didChangeToState:(YTPlayerState)state {
   // NSString *message = [NSString stringWithFormat:@"Player state changed: %ld\n", (long)state];
}

- (void)playerView:(YTPlayerView *)playerView didPlayTime:(float)playTime {
   // float progress = playTime/self.playerView.duration;
    //[self.slider setValue:progress];
}

- (void)receivedPlaybackStartedNotification:(NSNotification *) notification {
    if([notification.name isEqual:@"Playback started"] && notification.object != self) {
        [self.playerView pauseVideo];
    }
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
    return [ProductsArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"EventCellTableViewCell";
    event = (SITSPVCell *)[self.ProductTV dequeueReusableCellWithIdentifier:CellIdentifier];
    if (event == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"SITSPVCell" owner:self options:nil];
        event = [cellArray objectAtIndex:0];
    }
    event.selectionStyle=UITableViewCellSelectionStyleNone;
    event.ProductFirIMG.image=nil;
    event.ProductFirIMG.showActivityIndicator=YES;
    event.ProductFirIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    event.ProductFirIMG.imageURL=[NSURL URLWithString:[[[ProductsArr objectAtIndex:indexPath.row] valueForKey:@"thumbnails"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    event.ProductFirLBL.text=[[ProductsArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    event.ProductDescLBL.text=[[ProductsArr objectAtIndex:indexPath.row] valueForKey:@"description"];
    event.ProductDLBTN.hidden=YES;
    
    if ([GETVALUE(SELECTED_USER_TYPE) isEqual:@1])
    {
        event.ProductDLBTN.hidden=NO;
        event.ProductDLBTN.userInteractionEnabled=YES;
        [event.ProductDLBTN addTarget:self action:@selector(ProdDownloadAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }

    event.ProductVPlayBTN.tag=event.ProductDLBTN.tag=indexPath.row;
    [event.ProductVPlayBTN addTarget:self action:@selector(ProdPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    return  event;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}



-(void)ProdPlayAction:(id)sender
{
    [self ProdDetail:sender];
}

-(void)ProdDownloadAction:(id)sender
{
   // [self ProdDetail:sender];
    [self.playerView pauseVideo];
    FVShareURL= [[ProductsArr objectAtIndex:[sender tag]] valueForKey:@"video_link"];

    [self DownloadVideo];
}

-(void)ProdDetail:(id)sender
{
    NSLog(@"%ld",[sender tag]);
    FVURL= [[ProductsArr objectAtIndex:[sender tag]] valueForKey:@"video"];
    FVShareURL= [[ProductsArr objectAtIndex:[sender tag]] valueForKey:@"video_link"];

    self.PVNameLBL.text=[[ProductsArr objectAtIndex:[sender tag]] valueForKey:@"title"];
    [self PlayYouTubeVideo:[[ProductsArr objectAtIndex:[sender tag]] valueForKey:@"video_id"]];
    
}

-(void)FirstFVDetail
{
    FVURL= [[ProductsArr objectAtIndex:0] valueForKey:@"video"];
    FVShareURL= [[ProductsArr objectAtIndex:0] valueForKey:@"video_link"];

    self.PVNameLBL.text=[[ProductsArr objectAtIndex:0] valueForKey:@"title"];
    
//    NSMutableAttributedString * stringTiming = [[NSMutableAttributedString alloc] initWithString:@"You are looking at attributed string."];
//    [stringTiming addAttribute:NSStrikethroughStyleAttributeName value:@"1" range:NSMakeRange(0,[stringTiming length])];
//    self.PVNameLBL.attributedText= stringTiming;
    [self initYoutube:[[ProductsArr objectAtIndex:0] valueForKey:@"video_id"]];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"ProductVideoList"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            [ProductsArr removeAllObjects];
            ProductsArr=[dataDic valueForKey:@"video"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.ProductTV reloadData];
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
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:2.0];
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
    NSString *textToShare = PV_SHARE_TEXT;
    NSURL *myWebsite = [NSURL URLWithString:FVShareURL];
    NSArray *objectsToShare = @[textToShare, myWebsite];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludeActivities = @[UIActivityTypeAirDrop,
                                   UIActivityTypePrint,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeSaveToCameraRoll,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo];
    activityVC.excludedActivityTypes = excludeActivities;
    [self presentViewController:activityVC animated:YES completion:nil];
}
-(void)DownloadVideo
{
        //download the file in a seperate thread.
//    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]
//                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    activityView.center=self.view.center;
//    [activityView setColor:[UIColor redColor]];
//    [activityView startAnimating];
//    [self.view addSubview:activityView];
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
                //[activityView stopAnimating];
            });
        }
        
    });
    
}

@end
