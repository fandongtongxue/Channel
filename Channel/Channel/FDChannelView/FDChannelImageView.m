//
//  FDChannelImageView.m
//  Channel
//
//  Created by fandong on 2017/10/25.
//  Copyright © 2017年 fandong. All rights reserved.
//

#import "FDChannelImageView.h"
#import "FDChannelModel.h"

@implementation FDChannelImageView

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    _titleLabel.frame = CGRectMake(0, (1-(_pageHeight - frame.size.height)/(2*_closeHeight))*(_pageHeight - 1.5*_closeHeight), frame.size.width, _closeHeight);
    _contentLabel.frame = CGRectMake(0, (1-(_pageHeight - frame.size.height)/(2*_closeHeight))*(_pageHeight - _closeHeight)-_closeHeight/6, frame.size.width, _closeHeight);
    _contentLabel.alpha = (1-(_pageHeight - frame.size.height)/(2*_closeHeight))*1.5-0.5;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel * label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:25];
        label.numberOfLines = 1;
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        UILabel * label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:30];
        label.numberOfLines = 1;
        [self addSubview:label];
        _contentLabel = label;
        
    }
    return _contentLabel;
}

- (void)setModel:(FDChannelModel *)model{
    _model = model;
    self.image = [UIImage imageNamed:model.imageName];
    if (model.title) {
        self.titleLabel.text = model.title;
    }
    if (model.content) {
        self.contentLabel.text = model.content;
    }
}

@end
