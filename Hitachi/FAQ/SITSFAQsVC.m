//
//  SITSFAQsVC.m
//  Hitachi
//
//  Created by Apple on 26/05/17.
//  Copyright © 2017 SupraITS. All rights reserved.
//

#import "SITSFAQsVC.h"

@interface SITSFAQsVC ()

@end

@implementation SITSFAQsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.FAQTXW.editable=NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BackAct:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
