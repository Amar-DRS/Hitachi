//
//  SITSPOPDetails.h
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"


@interface SITSPOPDetails : UIViewController<UIScrollViewDelegate>
- (IBAction)BackAct:(id)sender;
@property (weak, nonatomic) IBOutlet AsyncImageView *POPDetailsIV;
@property (strong, nonatomic)  NSString *POPIMGURL;
@property (strong, nonatomic)  NSString *POPName;

@property (weak, nonatomic) IBOutlet UILabel *POPLBL;

- (IBAction)DownloadAct:(id)sender;
- (IBAction)ShareAct:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *POPSV;

@end
