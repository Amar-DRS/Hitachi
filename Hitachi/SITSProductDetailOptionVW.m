//
//  SITSProductDetailOptionVW.m
//  Hitachi
//
//  Created by Apple on 26/12/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "SITSProductDetailOptionVW.h"

@implementation SITSProductDetailOptionVW

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"SITSProductDetailOptionVW" owner:self options:nil] objectAtIndex:0];
        CGRect frame= headerView.frame;
        frame.size.width=self.frame.size.width;
        frame.size.height=self.frame.size.height;
        headerView.frame=frame;
        [self addSubview:headerView];
        
    }
    return self;
}@end
