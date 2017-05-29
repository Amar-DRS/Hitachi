//
//  ProductsVC.h
//  Hitachi
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "MyWebServiceHelper.h"
#import "EventCellTableViewCell.h"
#import "SITSProductDetailVC.h"






@interface ProductsVC : UIViewController<WebServiceResponseProtocal,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
- (IBAction)BackBtnAction:(id)sender;

- (IBAction)SearchProductAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *SearchTXT1;
@property (weak, nonatomic) IBOutlet UITextField *SearchTXT3;
@property (weak, nonatomic) IBOutlet UITextField *SearchTXT4;
@property (weak, nonatomic) IBOutlet UILabel *SearchResLBL;
@property (weak, nonatomic) IBOutlet UITableView *ProductsTV;
@property (weak, nonatomic) IBOutlet UIScrollView *ProductScroll;
@end
