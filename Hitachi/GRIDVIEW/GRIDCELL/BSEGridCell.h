//
//  BSEGridCell.h
//  SourceTheCourse
//
//  Created by Supra Dev Team on 3/18/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@interface BSEGridCell : UICollectionViewCell
{
    IBOutlet AsyncImageView *imgView;
    IBOutlet UILabel *course_Price;
    IBOutlet UILabel *courseTitle;
}
@end
