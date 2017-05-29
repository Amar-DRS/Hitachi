//
//  SITSPOPVC.h
//  Hitachi
//
//  Created by Apple on 08/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SITSPOPCell.h"
#import "SITSPOPDetails.h"
#import "MyWebServiceHelper.h"
#import "MyWebServiceHelper.h"








@interface SITSPOPVC : UIViewController<UITableViewDataSource,UITableViewDelegate,WebServiceResponseProtocal>
@property (weak, nonatomic) IBOutlet UITableView *POPTV;

- (IBAction)BackAct:(id)sender;
@end
