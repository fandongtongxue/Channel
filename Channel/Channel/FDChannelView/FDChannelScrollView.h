//
//  FDChannelScrollView.h
//  Channel
//
//  Created by fandong on 2017/10/25.
//  Copyright © 2017年 fandong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDChannelScrollView : UIView

+ (instancetype)newWithFrame:(CGRect)frame
                  pageHeight:(CGFloat)pageHeight
                 closeHeight:(CGFloat)closeHeight
                        data:(NSArray *)data
                 contentView:(UIView *)contentView;

@end
