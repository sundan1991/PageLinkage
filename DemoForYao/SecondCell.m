//
//  SecondCell.m
//  DemoForYao
//
//  Created by sundan on 16/8/11.
//  Copyright © 2016年 zyt. All rights reserved.
//

#import "SecondCell.h"

#define KcellHeight 100

#define KCellWitdth 80

@interface SecondCell ()

@property (nonatomic ,strong)   UIImageView *iv;

@property (nonatomic ,strong)   UILabel *title;

@end

@implementation SecondCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KCellWitdth, KcellHeight-20)];
        self.iv = imageV;
        [self.contentView addSubview:self.iv];
        
        //
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, KcellHeight-20, KCellWitdth, 20)];
        label.text = @"这里是小标题";
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        self.title = label;
        [self.contentView addSubview:self.title];
        
        
        
    }
    return self;
}

- (void)resetCellSubViewWithImageUrl:(NSString *)imageUrl title:(NSString *)subTitle{
    
    self.title.text = subTitle;
    
}




@end
