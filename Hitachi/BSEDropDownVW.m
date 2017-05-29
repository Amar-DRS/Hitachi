//
//  BSEDropDownVW.m
//  SourceTheCourse
//
//  Created by Supra Dev Team on 3/23/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "BSEDropDownVW.h"

@implementation BSEDropDownVW
@synthesize dropTableView;
-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *listView = [[[NSBundle mainBundle] loadNibNamed:@"BSEDropDownVW" owner:self options:nil] objectAtIndex:0];
        
        CGRect frame= listView.frame;
        frame.size.width=self.frame.size.width;
        frame.size.height=self.frame.size.height;
        listView.frame=frame;
        [self addSubview:listView];
        [self initFields];
    }
    return self;
}

-(void) initFields {
    [dropTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCellReuseIdentifier"];
    dropTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark -- table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dropDownData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellReuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [self.dropDownData objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:[self.dropDownIMGData objectAtIndex:indexPath.row]];

    cell.textLabel.font=[UIFont systemFontOfSize:12.0];;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.bseDropDownVWDelegateObj selectedDropDownItem:[self.dropDownData objectAtIndex:indexPath.row]];
        //[self removeFromSuperview];
}


@end
