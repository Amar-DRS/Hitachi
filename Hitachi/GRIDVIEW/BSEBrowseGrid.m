//
//  BSEBrowseGrid.m
//  SourceTheCourse
//
//  Created by Supra Dev Team on 3/18/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import "BSEBrowseGrid.h"
//#import "BSEGridCell.h"


@interface BSEBrowseGrid () {
}

@end

@implementation BSEBrowseGrid

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"testing value %@",self.courseList);
    [CcollectionView registerNib:[UINib nibWithNibName:@"BSEGridCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
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

#pragma mark -- collection view delegate --


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier1 = @"CollectionCell";
    UICollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:MyIdentifier1 forIndexPath:indexPath];
    return cell;
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.courseList count];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth / 2.1; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGFloat screenHeight = screenRect.size.height;
    float cellHeight = screenHeight/3.0;
    
    
    CGSize size = CGSizeMake(cellWidth, cellHeight);
    
    
    return size;
}
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [CcollectionView/*(that's my collection view name)*/ reloadData];
}
@end
