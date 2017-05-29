//
//  OffersVC.h
//  Hitachi
//
//  Created by Apple on 05/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SITSOfferCell.h"
#import "SITSOfferDetailVC.h"
#import "MyWebServiceHelper.h"




@interface OffersVC : UIViewController<UITableViewDelegate,UITableViewDataSource,WebServiceResponseProtocal>
@property (weak, nonatomic) IBOutlet UITableView *OfferTV;
- (IBAction)BackAct:(id)sender;

@end
