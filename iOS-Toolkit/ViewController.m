//
//  ViewController.m
//  iOS-Toolkit
//
//  Created by Archie on 2022/1/18.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, readwrite, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (UICollectionViewLayout*)createLayouat {
    UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc] initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger section, id<NSCollectionLayoutEnvironment> _Nonnull environment) {
        NSLog(@"effectiveContentSize: %@", NSStringFromCGSize(environment.container.effectiveContentSize));
        NSLog(@"contentSize: %@", NSStringFromCGSize(environment.container.contentSize));
        CGSize containerSize = environment.container.effectiveContentSize;
        CGFloat headerHeight = 40.0f;
        if (section == 0) {
            CGFloat itemWidth = 50.0f;
            CGFloat itemHeight = 50.0f;
            
            NSCollectionLayoutSize* itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:itemWidth] heightDimension:[NSCollectionLayoutDimension absoluteDimension:itemHeight]];
            NSCollectionLayoutItem* item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
            [item setContentInsets:NSDirectionalEdgeInsetsMake(0, 0, 0, 0)];
            
            NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:itemWidth] heightDimension:[NSCollectionLayoutDimension absoluteDimension:itemHeight]];
            NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
            
            NSCollectionLayoutSection* layoutSection = [NSCollectionLayoutSection sectionWithGroup:group];
            
            NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0f] heightDimension:[NSCollectionLayoutDimension  absoluteDimension:headerHeight]];
            NSCollectionLayoutBoundarySupplementaryItem *sectionHeader = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:headerSize elementKind:UICollectionElementKindSectionHeader alignment:NSRectAlignmentTop];
            layoutSection.boundarySupplementaryItems = @[sectionHeader];
            layoutSection.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous;
            
            return layoutSection;
        } else {
            CGFloat itemWidth = 120.0f;
            CGFloat itemHeight = 120.0f;
            CGFloat minimumInteritemSpacing = 2.0f;
            CGFloat minimumLineSpacing = 2.0f;
            int countPerRow = (int)containerSize.width / (int)(itemWidth + minimumInteritemSpacing * 2);
            CGFloat interitemSpacing = (containerSize.width - itemWidth * countPerRow) / countPerRow / 2;
            
            NSCollectionLayoutSize* itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:itemWidth] heightDimension:[NSCollectionLayoutDimension  absoluteDimension:itemHeight]];
            NSCollectionLayoutItem* item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
            [item setContentInsets:NSDirectionalEdgeInsetsMake(minimumLineSpacing, interitemSpacing, minimumLineSpacing, interitemSpacing)];
            
            NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0f] heightDimension:[NSCollectionLayoutDimension  absoluteDimension:itemHeight]];
            NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitem:item count:countPerRow];
            
            NSCollectionLayoutSection* layoutSection = [NSCollectionLayoutSection sectionWithGroup:group];
            
            NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0f] heightDimension:[NSCollectionLayoutDimension  absoluteDimension:headerHeight]];
            NSCollectionLayoutBoundarySupplementaryItem *sectionHeader = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:headerSize elementKind:UICollectionElementKindSectionHeader alignment:NSRectAlignmentTop];
            layoutSection.boundarySupplementaryItems = @[sectionHeader];
            
            return layoutSection;
        }
    }];
    return layout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewLayout *layout = [self createLayouat];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:UICollectionViewCell.class  forCellWithReuseIdentifier:@"123"];
    [self.collectionView registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"456"];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.collectionView];
    [[self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor]  setActive:YES];
    [[self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]  setActive:YES];
    [[self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor]  setActive:YES];
    [[self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]  setActive:YES];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"123" forIndexPath:indexPath];
    for (UIView* view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    if (collectionView == self.collectionView) {
        if (indexPath.section == 0) {
            cell.backgroundColor = [[UIColor alloc] initWithRed:(random()%256)/256.0f green:(random()%256)/256.0f blue:(random()%256)/256.0f alpha:1.0f];
        } else {
            cell.backgroundColor = [[UIColor alloc] initWithRed:(random()%256)/256.0f green:(random()%256)/256.0f blue:(random()%256)/256.0f alpha:1.0f];
        }
    } else {
        cell.backgroundColor = [[UIColor alloc] initWithRed:(random()%256)/256.0f green:(random()%256)/256.0f blue:(random()%256)/256.0f alpha:1.0f];
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    } else  {
        return 100;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"456" forIndexPath:indexPath];
    view.backgroundColor = [[UIColor alloc] initWithRed:(random()%256)/256.0f green:(random()%256)/256.0f blue:(random()%256)/256.0f alpha:1.0f];
    
    return view;
}

@end
