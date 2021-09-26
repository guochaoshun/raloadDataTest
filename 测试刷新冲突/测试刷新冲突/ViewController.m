//
//  ViewController.m
//  测试刷新冲突
//
//  Created by 郭朝顺 on 2021/9/24.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self collectionView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {



    NSLog(@"局部刷新");
    NSMutableArray *array = [NSMutableArray array];
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    [array addObject:indexPath];
    [self.collectionView reloadItemsAtIndexPaths:array];


    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.26 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"全体刷新");
        [self.collectionView reloadData];
    });

//    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    NSLog(@"刷新cell -- %@",@(indexPath.item));
    return cell;
}



- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(120, 120);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, 300, 300) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}



@end
