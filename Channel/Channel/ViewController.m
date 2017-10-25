//
//  ViewController.m
//  Channel
//
//  Created by fandong on 2017/10/25.
//  Copyright © 2017年 fandong. All rights reserved.
//

#import "ViewController.h"
#import "FDChannelScrollView.h"
#import "FDChannelModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = self.view.bounds;
    
    NSArray * data = @[@"1.jpg",
                       @"2.jpg",
                       @"3.jpg",
                       @"1.jpg",
                       @"2.jpg",
                       @"3.jpg"];
    
    NSMutableArray * models = [NSMutableArray new];
    for (NSString * imageName in data) {
        FDChannelModel * model = [FDChannelModel new];
        model.imageName = imageName;
        model.title = @"发布会";
        model.content = @"2018春夏";
        [models addObject:model];
    }
    
    UIView * view = [UIView new];
    view.frame = self.view.bounds;
    view.backgroundColor = [UIColor blackColor];
    
    FDChannelScrollView * drawerView = [FDChannelScrollView newWithFrame:frame pageHeight:frame.size.width*5/4 closeHeight:frame.size.width/4 data:models contentView:view];
    
    [self.view addSubview:drawerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
