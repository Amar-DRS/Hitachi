//
//  BSEBrowseGrid.h
//  SourceTheCourse
//
//  Created by Supra Dev Team on 3/18/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BSEBrowseGrid : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>{
    IBOutlet UICollectionView *CcollectionView;
    IBOutlet UICollectionViewFlowLayout *flowLayout;
}
@property (nonatomic,copy) NSArray *courseList;

@end
