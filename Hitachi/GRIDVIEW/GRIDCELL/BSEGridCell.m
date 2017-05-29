//
//  BSEGridCell.m
//  SourceTheCourse
//
//  Created by JITEN on 3/18/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "BSEGridCell.h"


@implementation BSEGridCell

- (void)awakeFromNib {
    // Initialization code
}

-(void) setGridValues:(BSECourseList *)list {
    self.backgroundColor=[UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:1.0f];
    imgView.image=nil;
    imgView.showActivityIndicator=YES;
    imgView.activityIndicatorStyle=UIActivityIndicatorViewStyleWhite;
    imgView.imageURL=[NSURL URLWithString:list.course_image];
    
    if([list.price isEqualToString:@"0.00"]||[list.price isEqualToString:@"0"]) {
        course_Price.text=@"FREE";
    } else {
        course_Price.text=[NSString stringWithFormat:@"%@ %@",KCURRENCY,list.price];
        
    }
    
    courseTitle.text=list.course_name;
    
    CGRect framer=course_Price.frame;
    [course_Price sizeToFit];
    framer.size.width=course_Price.frame.size.width+10;
    framer.origin.x=self.contentView.frame.size.width-(course_Price.frame.size.width+10);
    course_Price.frame=framer;
}


@end
