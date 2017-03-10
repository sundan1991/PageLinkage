//
//  FirstCell.m
//  DemoForYao
//
//  Created by sundan on 16/8/12.
//  Copyright © 2016年 zyt. All rights reserved.
//

#import "FirstCell.h"

#define KcellHeight 100

#define KCellWitdth 80

@interface FirstCell ()

@property (nonatomic ,strong)   UILabel *title;

@end


@implementation FirstCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KCellWitdth, KcellHeight)];
        label.text = @"大标题";
        label.font = [UIFont boldSystemFontOfSize:20];
        self.title = label;
        [self.contentView addSubview:self.title];
        
    }
    return self;
}


- (void)resetCellWithTitle:(NSString *)title{
    
}



@end
