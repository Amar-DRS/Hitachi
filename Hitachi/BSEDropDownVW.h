//
//  BSEDropDownVW.h
//  SourceTheCourse
//
//  Created by JITEN on 3/23/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSEDropDownVWDelegate <NSObject>

-(void) selectedDropDownItem:(NSString *)str;

@end

@interface BSEDropDownVW : UIView <UITableViewDelegate, UITableViewDataSource> {
    NSString *selectedText;
    
}

@property (nonatomic,strong) NSArray *dropDownData;
@property (nonatomic,strong) NSArray *dropDownIMGData;

@property (nonatomic,strong) IBOutlet UITableView *dropTableView;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) id<BSEDropDownVWDelegate> bseDropDownVWDelegateObj;

@end
