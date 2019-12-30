//
//  FDChannelScrollView.m
//  Channel
//
//  Created by fandong on 2017/10/25.
//  Copyright © 2017年 fandong. All rights reserved.
//

#import "FDChannelScrollView.h"
#import "FDChannelImageView.h"
#import "FDChannelModel.h"

@interface FDChannelScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray * scrollViews;

@property (nonatomic, assign) CGFloat pageHeight;
@property (nonatomic, assign) CGFloat closeHeight;
@property (nonatomic, strong) NSArray * data;
@property (nonatomic, strong) UIView * contentView;

@end

@implementation FDChannelScrollView

- (NSMutableArray *)scrollViews{
    if (!_scrollViews) {
        _scrollViews = [NSMutableArray new];
    }
    return _scrollViews;
}

- (UIScrollView *)scrollView{
    
    UIScrollView * scrollView = [UIScrollView new];
    
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    scrollView.frame = CGRectMake(0, self.scrollViews.count?([self.scrollViews.lastObject frame].origin.y+_pageHeight):0, self.frame.size.width, _pageHeight);
    [self addSubview:scrollView];
    
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    
    if (self.scrollViews.count == 0) {
        
        scrollView.clipsToBounds = NO;
        
        
        CGRect frame = CGRectMake(0, 0, self.frame.size.width, _pageHeight);
        for (FDChannelModel * imageModel in _data) {
            
            FDChannelImageView * imageView = [FDChannelImageView new];
            
            imageView.pageHeight = _pageHeight;
            imageView.closeHeight = _closeHeight;
            imageView.model = imageModel;
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.frame = frame;
            
            imageView.tag = 100+scrollView.subviews.count;
            [scrollView addSubview:imageView];
            
            if (frame.origin.y == 0) {
                frame.size.height = _pageHeight - 2*_closeHeight;
                frame.origin.y = _pageHeight - _closeHeight;
            }
            frame.origin.y += _closeHeight;
        }
        
        if (_contentView != nil) {
            CGRect viewFrame = _contentView.frame;
            viewFrame.origin.y = frame.origin.y;
            _contentView.frame = viewFrame;
            [scrollView addSubview:_contentView];
            
            scrollView.contentSize = CGSizeMake(frame.size.width, (_data.count+1)*_pageHeight);
        } else {
            scrollView.contentSize = CGSizeMake(frame.size.width, _data.count*_pageHeight);
        }
        
    }else {
        scrollView.contentSize = [self.scrollViews.firstObject contentSize];
    }
    
    [self.scrollViews addObject:scrollView];
    
    return scrollView;
}

+ (instancetype)newWithFrame:(CGRect)frame
                  pageHeight:(CGFloat)pageHeight
                 closeHeight:(CGFloat)closeHeight
                        data:(NSArray *)data
                 contentView:(UIView *)contentView{
    FDChannelScrollView * view = [FDChannelScrollView new];
    view.frame = frame;
    view.pageHeight = pageHeight;
    view.closeHeight = closeHeight;
    view.data = data;
    view.contentView = contentView;
    [view upView];
    return view;
}

- (void)upView{
    
    do {
        [self addSubview:[self scrollView]];
    } while (self.frame.size.height > _pageHeight * self.scrollViews.count);
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tap];
}

- (void)onTap:(UITapGestureRecognizer *)sender{
    CGPoint tapPoint = [sender locationInView:self];
    
    for (FDChannelImageView * imageView in [self.scrollViews.firstObject subviews].reverseObjectEnumerator) {
        
        CGRect rect = [imageView convertRect:imageView.bounds toView:self];
        if (CGRectContainsPoint(rect, tapPoint)) {
            
            if ([imageView isKindOfClass:[FDChannelImageView class]]) {
                
                if (imageView.frame.size.height < _pageHeight) {
                    UIScrollView * scorllView = self.scrollViews.firstObject;
                    
                    [scorllView setContentOffset:CGPointMake(0, (imageView.tag-100)*_pageHeight) animated:YES];
                    
                }
            }
            
            break;
        }
        
    }
}

#pragma mark --- scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    for (UIScrollView * scroll in self.scrollViews) {
        if (scroll != scrollView) {
            scroll.contentOffset = scrollView.contentOffset;
        }
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0) {
        
        NSInteger count = ceil(offsetY/_pageHeight);
        CGFloat set = offsetY - (count-1)*_pageHeight;
        CGFloat y = 0;
        
        for (NSInteger i = 0; i < _data.count; i++) {
            FDChannelImageView * imageView = [self.scrollViews.firstObject viewWithTag:i+100];
            CGRect frame = imageView.frame;
            
            if (i < count) {
                frame.origin.y = i*_pageHeight;
                frame.size.height = _pageHeight;
                imageView.frame = frame;
            } else if (i == count) {
                frame.origin.y = i*_pageHeight;
                frame.size.height = _pageHeight -(_pageHeight - set)/_pageHeight * 2*_closeHeight;
                imageView.frame = frame;
                
                y = frame.origin.y + _closeHeight + set*(_pageHeight - _closeHeight)/_pageHeight;
            }else{
                frame.origin.y = y;
                frame.size.height = _pageHeight-2*_closeHeight;
                imageView.frame = frame;
                y += _closeHeight;
            }
            if (_contentView == nil && i == _data.count-1) {
                CGPoint point = [self convertPoint:frame.origin fromView:self.scrollViews.firstObject];
                frame.size.height = MAX(self.frame.size.height - point.y, frame.size.height);
                imageView.frame = frame;
            }
            
        }
        if (_contentView != nil) {
            CGRect viewFrame = _contentView.frame;
            viewFrame.origin.y = y > 0?y: _data.count*_pageHeight;
            _contentView.frame = viewFrame;
        }
    }
}

@end
