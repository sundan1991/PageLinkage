//
//  ViewController.m
//  DemoForYao
//
//  Created by lzt on 16/4/28.
//  Copyright © 2016年 zyt. All rights reserved.
//

#import "ViewController.h"

#import "SDScrollerView.h"

#import "SDTableView.h"

#import "CollectionView.h"

#import "SecondCell.h"

#import "FirstCell.h"


//
#define KCellWidth 80//价格等订单详情的宽度

#define KcellHeight 100

#define itemNum 20 //横向有多少个itemj

#define titleNum 16


//
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height


//
#define KIdentifier @"collectionViewCell"
#define KSubIdentifier @"subCollectionViewCell"


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong)   SDScrollerView *contentScrollerView;

@property (nonatomic ,strong)   SDTableView *orderNumberTableView;

@property (nonatomic ,strong)   SDTableView *contentTableView;

@property (nonatomic ,strong)   CollectionView *collectView;

@property (nonatomic ,strong)   CollectionView *subCollectionView;

@property (nonatomic ,assign)   BOOL scrollUp;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    label.backgroundColor = [UIColor lightGrayColor];
    
    label.text = @"这里是标题";
    
    label.textAlignment = 1;
    
    label.font = [UIFont boldSystemFontOfSize:30];
    
    [self.view addSubview:label];

    //
    [self loadContentScrollerView];
    
    [self loadOrderNumberTableView];
    
    [self loadContentTableView];
    
    [self loadData];
}



//根据数据重设模块的frame
- (void)loadData{
    
    NSInteger width = itemNum*KCellWidth;

    self.contentScrollerView.contentSize = CGSizeMake(width, 0);
    
    [self.collectView setFrame:CGRectMake(0, 0, width, 100)];
    
    [self.subCollectionView setFrame:CGRectMake(0, 100, width, KScreenHeight-100)];

}

//加载content最下层的滚动视图
- (void)loadContentScrollerView{
    self.contentScrollerView = [[SDScrollerView alloc] initWithFrame:CGRectMake(100, 0, [UIScreen mainScreen].bounds.size.width-100, [UIScreen mainScreen].bounds.size.height)];
    self.contentScrollerView.mark = @"content";
    self.contentScrollerView.delegate = self;
    self.contentScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentScrollerView];
}

//加载左边的标题栏
- (void)loadOrderNumberTableView{
    self.orderNumberTableView = [[SDTableView alloc] initWithFrame:CGRectMake(0, 100, 100, [UIScreen mainScreen].bounds.size.height) style:(UITableViewStylePlain)];
    self.orderNumberTableView.tag = 0;
    self.orderNumberTableView.delegate = self;
    self.orderNumberTableView.dataSource = self;
    self.orderNumberTableView.mark = @"title";
    self.orderNumberTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.orderNumberTableView];
}

// 加载content的两部分的collectionView
- (void)loadContentTableView{
    
    //
    UICollectionViewFlowLayout *sublayout = [[UICollectionViewFlowLayout alloc] init];
    self.subCollectionView = [[CollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width-100,  [UIScreen mainScreen].bounds.size.height-100) collectionViewLayout:sublayout];
    self.subCollectionView.tag = 10;
    self.subCollectionView.delegate = self;
    self.subCollectionView.dataSource = self;
    [self.subCollectionView registerClass:[SecondCell class] forCellWithReuseIdentifier:KSubIdentifier];
    self.subCollectionView.mark = @"content";
    self.subCollectionView.showsHorizontalScrollIndicator = NO;
    self.subCollectionView.showsVerticalScrollIndicator = NO;
    self.subCollectionView.backgroundColor = [UIColor whiteColor];
    [self.contentScrollerView addSubview:self.subCollectionView];
    
    //
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectView = [[CollectionView alloc] initWithFrame:CGRectMake(0, 0, 100,  [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    [self.collectView registerClass:[FirstCell class] forCellWithReuseIdentifier:KIdentifier];
    self.collectView.tag = 11;
    [self.contentScrollerView addSubview:self.collectView];
    
}

#pragma mark - UICollectionView delegate datasource
//collectio的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //itemNum*KCellWitdth
    if (collectionView.tag == 11) {
        //第一部分
        return 2*itemNum;
    }
    else return titleNum*itemNum;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 11) {
        FirstCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor orangeColor];
        return cell;
        
    }
    else{
        SecondCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KSubIdentifier forIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        return cell;
        
    }

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KCellWidth, KcellHeight);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



#pragma mark - UITableView delegate datasource
//tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return titleNum;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return KcellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellName = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellName];
        
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这里是title%ld",(long)indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:22];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //判断滑动方向
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    //判断方向
    static float newx = 0;
    static float oldx = 0;
    newx = contentOffsetY;
    if (newx != oldx ) {
        if (newx > oldx) {
            self.scrollUp = NO;
        }else {
            self.scrollUp = YES;
        }
        oldx = newx;
    }
    
    //联动
    //tableview~
    if ([scrollView isKindOfClass:[SDTableView class]]) {
        SDTableView *sdTable = (SDTableView *)scrollView;
        if ([sdTable.mark isEqualToString:@"title"]) {
            
            self.subCollectionView.contentOffset = scrollView.contentOffset;
            
        }
        
    }
    
    //contentView~
    else if ([scrollView isKindOfClass:[CollectionView class]]){
        CollectionView *collection = (CollectionView *)scrollView;
      
        if (collection.tag == 10) {
            //第二部分
            self.orderNumberTableView.contentOffset = scrollView.contentOffset;
            return;
            
            
        }
        else{
            if ([collection.mark isEqualToString:@"content"]){
                self.orderNumberTableView.contentOffset = scrollView.contentOffset;
            }
        }
        
    }
}

@end
