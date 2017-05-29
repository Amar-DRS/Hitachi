//
//  DashboardVC.m
//  Hitachi
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "DashboardVC.h"

@interface DashboardVC ()
{
    NSMutableArray *collectionArr;
}
@end

@implementation DashboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
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




- (IBAction)BackBtnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ProductAction:(id)sender {
    
    
    
    ProductsVC *ProductDash=[[ProductsVC alloc] init];
    [self.navigationController pushViewController:ProductDash animated:YES];
}

- (IBAction)BrocherAction:(id)sender {
    

    SITSBroucherDetailVC *BroucherDash=[[SITSBroucherDetailVC alloc] init];
    [self.navigationController pushViewController:BroucherDash animated:YES];
}

- (IBAction)FeaturedVideosAction:(id)sender {
    

    SITSFeaturedVC *FeaturedDash=[[SITSFeaturedVC alloc] init];
    [self.navigationController pushViewController:FeaturedDash animated:YES];
}

- (IBAction)ProductVideosAction:(id)sender {

    SITSProductVideosVC *ProductDash=[[SITSProductVideosVC alloc] init];
    [self.navigationController pushViewController:ProductDash animated:YES];
}

- (IBAction)OffersAction:(id)sender {
    
    OffersVC *Offer=[[OffersVC alloc] init];
    [self.navigationController pushViewController:Offer animated:YES];
}
- (IBAction)AvailablePOPAction:(id)sender {
    

    SITSGuidelineVC *Guideline=[[SITSGuidelineVC alloc] init];
    [self.navigationController pushViewController:Guideline animated:YES];
 
}

- (IBAction)ProductSpecsAction:(id)sender {
    SITSPOPVC *POP=[[SITSPOPVC alloc] init];
    [self.navigationController pushViewController:POP animated:YES];
}


@end
