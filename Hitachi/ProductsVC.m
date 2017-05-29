//
//  ProductsVC.m
//  Hitachi
//
//  Created by Apple on 30/11/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "ProductsVC.h"

@interface ProductsVC ()
{
    MyWebServiceHelper *helper;
    EventCellTableViewCell*event;
    NSMutableArray *ProductsArr;
    NSMutableDictionary *ProductsDict;
    NSMutableArray *DDArr1;
    NSMutableArray *DDArr2;
    NSMutableArray *DDArr3;
    NSMutableArray *DDArr4;
    NSMutableArray *TonnageArr;
    NSMutableArray *RatingArr;
    NSMutableString *DDSearchStr1;
    NSMutableString *DDSearchStr2;
    NSMutableString *DDSearchStr3;
    NSMutableString *DDSearchStr4;

// picker view
    UIPickerView *pickerView;
    NSString *SelectedPicker;
    UIView *PickerBG;

    CGSize ScrollSize;
}
@end

@implementation ProductsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // textfield delegate
    self.SearchTXT1.delegate=self;
    self.SearchTXT3.delegate=self;
    self.SearchTXT4.delegate=self;
    self.SearchTXT1.inputView=pickerView;
    // webservice initialization
    helper = [[MyWebServiceHelper alloc] init];
    helper.webApiDelegate = self;
    ScrollSize=self.ProductScroll.contentSize;
    // table view delegate
    self.ProductsTV.delegate=self;
    self.ProductsTV.dataSource=self;
    
    // custom table view cell
    event=[[EventCellTableViewCell alloc]init];
    
    ProductsArr=[[NSMutableArray alloc] init];
    ProductsDict=[[NSMutableDictionary alloc] init];

    self.ProductsTV.hidden=YES;
    self.SearchResLBL.hidden=YES;
    // drop down value array
    DDArr1=[[NSMutableArray alloc] init];
    DDArr2=[[NSMutableArray alloc] init];
    DDArr3=[[NSMutableArray alloc] init];
    DDArr4=[[NSMutableArray alloc] init];

    
    TonnageArr=[[NSMutableArray alloc] init];
    RatingArr=[[NSMutableArray alloc] init];

    // drop down selected value index string value
    DDSearchStr1=[[NSMutableString alloc] initWithString:@""];
    DDSearchStr2=[[NSMutableString alloc] initWithString:@""];
    DDSearchStr3=[[NSMutableString alloc] initWithString:@""];
    DDSearchStr4=[[NSMutableString alloc] initWithString:@""];

    [self CreatePicker];
    [self HideView];
    
    NSDictionary *DDInputDict;
    DDInputDict=  @{@"action":@"category_list",};
    [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
    [helper ProductSearchDD:DDInputDict];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)BackBtnAction:(id)sender {
    [self HideView];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SearchProductAction:(id)sender {
    [self HideView];

    if([self.SearchTXT1.text length]<=0  && [self.SearchTXT3.text length]<=0 && [self.SearchTXT4.text length]<=0)
    {
        [SVProgressHUD show];
        [self.SearchTXT1 resignFirstResponder];
        [self.SearchTXT3 resignFirstResponder];
        [self.SearchTXT4 resignFirstResponder];
        [MyCustomClass SVProgressMessageDismissWithError:@"Please provide atleast one input " timeDalay:1.0f];
    }
    else
        {
        NSDictionary *SearchDict;
        SearchDict=  @{@"action":@"product_search",@"cat_type":DDSearchStr1,@"product_category":DDSearchStr2,@"tonnage":DDSearchStr3,@"rating":DDSearchStr4,};
        
        [MyCustomClass SVProgressViewWithShowingMessage:@"Loading..."];
        
        [helper ProductSearch:SearchDict];
        }
    

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rowcount=(int)[ProductsArr count]/2;
    if ([ProductsArr count]%2==1)
    {
        rowcount=rowcount+1;
    }
    return rowcount;
      //  return ([ProductsArr count]/2);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"EventCellTableViewCell";
    event = (EventCellTableViewCell *)[self.ProductsTV dequeueReusableCellWithIdentifier:CellIdentifier];
    if (event == nil)
    {
        NSArray *cellArray = [[NSBundle mainBundle] loadNibNamed:@"EventCellTableViewCell" owner:self options:nil];
        event = [cellArray objectAtIndex:0];
    }
    event.selectionStyle=UITableViewCellSelectionStyleNone;
    event.ProductFirLBL.text=[[ProductsArr objectAtIndex:2*indexPath.row] valueForKey:@"product_name"];
    event.ProductFirIMG.image=nil;
    event.ProductFirIMG.showActivityIndicator=YES;
    event.ProductFirIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    NSLog(@"URL1>>%@",[NSURL URLWithString:[[[ProductsArr objectAtIndex:2*indexPath.row] valueForKey:@"thumbnail_product_pic_thumb"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
    event.ProductFirIMG.imageURL=[NSURL URLWithString:[[[ProductsArr objectAtIndex:2*indexPath.row] valueForKey:@"thumbnail_product_pic_thumb"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [event.ProductFirBTN addTarget:self action:@selector(ProductFirAction:) forControlEvents:UIControlEventTouchUpInside];
    event.ProductFirBTN.tag=2*indexPath.row;
    // second cell data filling
    if (indexPath.row+1<=[ProductsArr count]/2)
    {
        event.ProductSecBTN.hidden=NO;
        event.ProductSecLBL.text=[[ProductsArr objectAtIndex:2*indexPath.row+1] valueForKey:@"product_name"];
        event.ProductSecIMG.image=nil;
        event.ProductSecIMG.showActivityIndicator=YES;
        event.ProductSecIMG.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
        NSLog(@"URL2>>%@",[NSURL URLWithString:[[[ProductsArr objectAtIndex:2*indexPath.row+1] valueForKey:@"thumbnail_product_pic_thumb"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]);
        event.ProductSecIMG.imageURL=[NSURL URLWithString:[[[ProductsArr objectAtIndex:2*indexPath.row+1] valueForKey:@"thumbnail_product_pic_thumb"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [event.ProductSecBTN addTarget:self action:@selector(ProductSecAction:) forControlEvents:UIControlEventTouchUpInside];
        event.ProductSecBTN.tag=2*indexPath.row+1;
    }
    return  event;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 176;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}
-(void)ProductFirAction:(id)sender
{
    NSLog(@"%ld",(long)[sender tag]);
    [self ProductDetail:sender];
}

-(void)ProductSecAction:(id)sender
{
    NSLog(@"%ld",(long)[sender tag]);
    [self ProductDetail:sender];
}

-(void)ProductDetail:(id)sender
{
    [[ProductsArr objectAtIndex:(long)[sender tag]] valueForKey:@"product_id"];
    SITSProductDetailVC *ProductDetail=[[SITSProductDetailVC alloc] init];
    ProductDetail.ProductId=[[ProductsArr objectAtIndex:(long)[sender tag]] valueForKey:@"product_id"];
    ProductDetail.ProductsArr=ProductsArr;
    ProductDetail.CurrentProduct=[sender tag];

    [self.navigationController pushViewController:ProductDetail animated:YES];
}

-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName
{
    NSDictionary*dataDic=[MyCustomClass dictionaryFromJSON:responseDictionary];
    NSLog(@"dataDic>>>>%@",dataDic);
    if([apiName isEqualToString:@"ProductSearch"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            [ProductsArr removeAllObjects];
            [ProductsArr addObjectsFromArray:[dataDic valueForKey:@"products"]];
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [self setFrameForscroll];
                [self.ProductsTV reloadData];
                self.ProductsTV.hidden=NO;
                self.SearchResLBL.hidden=NO;
                [MyCustomClass SVProgressMessageDismissWithSuccess:[dataDic valueForKey:@"msg"]  timeDalay:1.0];
    
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setFrameForscroll];
                [self.ProductsTV reloadData];
                self.ProductsTV.hidden=YES;
                self.SearchResLBL.hidden=YES;
                [MyCustomClass SVProgressMessageDismissWithSuccess:[dataDic valueForKey:@"msg"]  timeDalay:1.0];
                
            });

           
        }
    }
   else if([apiName isEqualToString:@"ProductSearchDD"])
    {
        if ([[dataDic valueForKey:@"status"]  isEqual:@1])
        {
            [DDArr1 removeAllObjects];
            [DDArr1 addObjectsFromArray:[dataDic valueForKey:SELECTED_DD1]];
            [DDArr2 removeAllObjects];
            [DDArr2 addObjectsFromArray:[dataDic valueForKey:SELECTED_DD2]];
            [DDArr3 removeAllObjects];
            [DDArr3 addObjectsFromArray:[dataDic valueForKey:SELECTED_DD3]];
            [DDArr4 removeAllObjects];
            [DDArr4 addObjectsFromArray:[dataDic valueForKey:SELECTED_DD4]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MyCustomClass SVProgressMessageDismissWithSuccess:@""  timeDalay:0.0];
            });
        }
        else
            {
                [MyCustomClass SVProgressMessageDismissWithError:@"" timeDalay:0.0];
            }
    }
}


-(void)setFrameForscroll
{
 [self.ProductScroll setContentSize:CGSizeMake(ScrollSize.width,ScrollSize.height+([ProductsArr count]/2)*176+300)];
    CGRect OldFrame=self.ProductsTV.frame;
    OldFrame.size.height=([ProductsArr count]/2)*176+300;
    self.ProductsTV.frame=OldFrame;
}
-(void)webApiResponseError:(NSError *)errorDictionary
{
    [MyCustomClass SVProgressMessageDismissWithError:@"Some Unknown Error" timeDalay:2.0];
}
-(void)CreatePicker
{
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, Window_Width, 100)];
    // picker view delegate
    pickerView.delegate=self;
    pickerView.dataSource=self;
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, Window_Width, 64)];
    pickerToolbar.tintColor = [UIColor whiteColor];
    [pickerToolbar sizeToFit];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(PickerCancelAct:)];
    
    [cancelBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                       NSForegroundColorAttributeName,
                                       nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *titleButton;
    //float pickerMarginHeight = 168;
    titleButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target: nil action: nil];
    
    [titleButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                         NSForegroundColorAttributeName,
                                         nil] forState:UIControlStateNormal];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(PickerDoneAct:)];
    
    [doneBtn setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIColor colorWithRed:253.0/255.0 green:68.0/255.0 blue:142.0/255.0 alpha:1.0],
                                     NSForegroundColorAttributeName,
                                     nil] forState:UIControlStateNormal];
    
    NSArray *itemArray = [[NSArray alloc] initWithObjects:cancelBtn, flexSpace, titleButton, flexSpace, doneBtn, nil];
    PickerBG = [[UIView alloc] initWithFrame:CGRectMake(0,Window_Height-160, Window_Width, 170)];
   // [PickerBG setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    [PickerBG setBackgroundColor:[UIColor whiteColor]];

    [PickerBG addSubview:pickerToolbar];
    [PickerBG addSubview:pickerView];
    [[AppDelegate SharedDelegate].window addSubview:PickerBG];
    [pickerToolbar setItems:itemArray animated:YES];
    [pickerView selectRow:0 inComponent:0 animated:YES];

    
    
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([SelectedPicker isEqualToString:SELECTED_DD1])
        return [DDArr1 count];
        else if ([SelectedPicker isEqualToString:SELECTED_DD2])
            return [DDArr2 count];
            else if ([SelectedPicker isEqualToString:SELECTED_DD3])
                return [DDArr3 count];
                else if ([SelectedPicker isEqualToString:SELECTED_DD4])
                    return [DDArr4 count];
                    else return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if ([SelectedPicker isEqualToString:SELECTED_DD1])
        return [[DDArr1 objectAtIndex:row] valueForKey:@"Category_type"];
        else if ([SelectedPicker isEqualToString:SELECTED_DD2])
            return [[DDArr2 objectAtIndex:row] valueForKey:@"product_category"];
            else if ([SelectedPicker isEqualToString:SELECTED_DD3])
                return [[DDArr3 objectAtIndex:row] valueForKey:@"tonnage"];
                else if ([SelectedPicker isEqualToString:SELECTED_DD4])
                    return [[DDArr4 objectAtIndex:row] valueForKey:@"rating_value"];
                    else return 0;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    pickerRow=row;
//    NSLog(@"pickerRow....>%ld",(long)pickerRow);
}



-(void)PickerDoneAct:(id)sender
{
    NSLog(@"%ld",(long)[pickerView selectedRowInComponent:0]);
    NSInteger selctedIndex= (long)[pickerView selectedRowInComponent:0];
    if ([SelectedPicker isEqualToString:SELECTED_DD1])
    {
        self.SearchTXT1.text=[[DDArr1 objectAtIndex:selctedIndex] valueForKey:@"Category_type"];
        DDSearchStr1= [[DDArr1 objectAtIndex:selctedIndex] valueForKey:@"id"];
        [DDArr3 removeAllObjects];
        DDArr3=[[[DDArr1 objectAtIndex:selctedIndex] valueForKey:@"tonnage"] mutableCopy];
        [DDArr4 removeAllObjects];
        DDArr4=[[[DDArr1 objectAtIndex:selctedIndex] valueForKey:@"product_rating"] mutableCopy];
        self.SearchTXT3.text=@"";
        self.SearchTXT4.text=@"";

        DDSearchStr3=@"";
        DDSearchStr4=@"";
    }
//    else if ([SelectedPicker isEqualToString:SELECTED_DD2])
//        {
//        self.SearchTXT2.text=[[DDArr2 objectAtIndex:selctedIndex] valueForKey:@"product_category"];
//        DDSearchStr2=  [[DDArr2 objectAtIndex:selctedIndex] valueForKey:@"id"];
//        }
        else if ([SelectedPicker isEqualToString:SELECTED_DD3])
            {
                self.SearchTXT3.text=[[DDArr3 objectAtIndex:selctedIndex] valueForKey:@"tonnage"];
                DDSearchStr3= [[DDArr3 objectAtIndex:selctedIndex] valueForKey:@"id"];
            }
            else if ([SelectedPicker isEqualToString:SELECTED_DD4])
                {
                    self.SearchTXT4.text=[[DDArr4 objectAtIndex:selctedIndex] valueForKey:@"rating_value"];
                    DDSearchStr4= [[DDArr4 objectAtIndex:selctedIndex] valueForKey:@"rating_id"];
                }
    [self HideView];
}

-(void)PickerCancelAct:(id)sender
{
    [self HideView];
}

-(void)HideView
{
    [self.SearchTXT1 resignFirstResponder];
    [self.SearchTXT3 resignFirstResponder];
    [self.SearchTXT4 resignFirstResponder];
    
    pickerView.hidden=YES;
    PickerBG.hidden=YES;
    
}
-(void)ShowPickerView
{
    pickerView.hidden=NO;
    PickerBG.hidden=NO;
    [pickerView reloadAllComponents];
}

#pragma mark -
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.SearchTXT1 resignFirstResponder];
    [self.SearchTXT3 resignFirstResponder];
    [self.SearchTXT4 resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 100:
            SelectedPicker=SELECTED_DD1;
            break;
        case 200:
            SelectedPicker=SELECTED_DD2;
            break;
        case 300:
            SelectedPicker=SELECTED_DD3;
            break;
        case 400:
            SelectedPicker=SELECTED_DD4;
            break;
        default:
            break;
    }
    [self ShowPickerView];
    return NO;
}


@end
