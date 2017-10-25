//
//  FDChannelImageView.h
//  Channel
//
//  Created by fandong on 2017/10/25.
//  Copyright © 2017年 fandong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FDChannelModel;

@interface FDChannelImageView : UIImageView

@property (nonatomic, strong) FDChannelModel * model;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;

@property (nonatomic, assign) CGFloat pageHeight;
@property (nonatomic, assign) CGFloat closeHeight;

@end
