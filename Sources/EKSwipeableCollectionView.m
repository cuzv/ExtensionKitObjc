//
//  EKSwipeableCollectionView.m
//  Copyright (c) 2014-2017 Moch Xiao (http://mochxiao.com).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EKSwipeableCollectionView.h"
#import "EKSwipeableCollectionViewCell.h"
#import "EKSwipeableCollectionViewCell+Internal.h"

@interface EKSwipeableCollectionView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *ek_panRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *ek_tapRecognizer;
@property (nonatomic, assign) BOOL ek_editing;
@property (nonatomic, weak) UICollectionViewCell *ek_currentEditingCell;
@end

@implementation EKSwipeableCollectionView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self _ek_commitInit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (!self) {
        return nil;
    }
    [self _ek_commitInit];
    return self;
}


- (void)_ek_commitInit {
    _ek_panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_ek_handlePan:)];
    _ek_panRecognizer.maximumNumberOfTouches = 1;
    _ek_panRecognizer.delegate = self;
    
    _ek_tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_ek_handleTap:)];
    _ek_tapRecognizer.delegate = self;
    [_ek_tapRecognizer requireGestureRecognizerToFail:_ek_panRecognizer];
    
    for (__kindof UIGestureRecognizer *recognizer in self.gestureRecognizers) {
        if ([recognizer isKindOfClass:UIPanGestureRecognizer.class]) {
            [recognizer requireGestureRecognizerToFail:_ek_panRecognizer];
        }
        if ([recognizer isKindOfClass:UITapGestureRecognizer.class]) {
            [recognizer requireGestureRecognizerToFail:_ek_tapRecognizer];
        }
    }
    
    [self addGestureRecognizer:_ek_panRecognizer];
    [self addGestureRecognizer:_ek_tapRecognizer];
}

- (void)_ek_handlePan:(UIPanGestureRecognizer *)sender {
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:[sender locationInView:self]];
    if (!indexPath) {
        return;
    }
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:indexPath];
    if (!cell || ![cell isKindOfClass:EKSwipeableCollectionViewCell.class]) {
        return;
    }
    EKSwipeableCollectionViewCell *swipeableCell = (EKSwipeableCollectionViewCell *)cell;
    if (self.ek_currentEditingCell && self.ek_currentEditingCell != swipeableCell) {
        [self _ek_restoration];
        self.ek_currentEditingCell = nil;
        return;
    }
    
    @weakify(self);
    swipeableCell.ek_didEditedHandler = ^{
        @strongify(self);
        self.ek_editing = NO;
    };
    
    CGFloat translationX = [sender translationInView:self].x;
    translationX = translationX > 15 ? 15 : translationX;
    
    CGFloat totalWidth = swipeableCell.ek_totalWidth;
    CGFloat privateViewMove = translationX;
    CGFloat contentViewMove = translationX;
    if (fabs(translationX) > totalWidth) {
        if (translationX > 0) {
            privateViewMove = totalWidth;
        } else {
            privateViewMove = -totalWidth;
        }
    }
    if (fabs(translationX) > 30 + totalWidth) {
        if (translationX > 0) {
            contentViewMove = totalWidth + 30;
        } else {
            contentViewMove = -totalWidth - 30;
        }
    }
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            // 记录当前操作的 cell
            self.ek_currentEditingCell = swipeableCell;
            if (swipeableCell.ek_editing) {
                [self _ek_shutWithSender:sender forCell:swipeableCell];
            }
            else if (self.ek_editing) {
                [self _ek_restoration];
            } else {
                self.ek_editing = YES;
                swipeableCell.ek_editing = YES;
            }
        } break;
        case UIGestureRecognizerStateChanged: {
            [swipeableCell ek_lateralMoveContentView:contentViewMove privateView:privateViewMove];
        } break;
        case UIGestureRecognizerStateEnded: {
            if (translationX > 0) {
                [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    [swipeableCell ek_lateralMoveContentView:-30 privateView:-30];
                } completion:^(BOOL finished) {
                    [self _ek_shutWithSender:sender forCell:swipeableCell];
                }];
            } else {
                // 如果滑动过半，到位，否则 recover
                if (fabs(translationX) * 2 > totalWidth) {
                    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                        [swipeableCell ek_lateralMoveContentView:-totalWidth privateView:-totalWidth];
                    } completion:nil];
                } else {
                    [self _ek_shutWithSender:sender forCell:swipeableCell];
                }
            }
            self.ek_currentEditingCell = nil;
        } break;
        case UIGestureRecognizerStateCancelled: {
            [self _ek_shutWithSender:sender forCell:swipeableCell];
            self.ek_currentEditingCell = nil;
        } break;
        default: {
            self.ek_currentEditingCell = nil;
        }
    }
}

- (void)_ek_handleTap:(UITapGestureRecognizer *)sender {
    [self _ek_restoration];
}

- (void)_ek_restoration {
    for (__kindof UICollectionViewCell *cell in self.visibleCells) {
        if ([cell isKindOfClass:EKSwipeableCollectionViewCell.class]) {
            [self _ek_shutWithSender:self.ek_panRecognizer forCell:cell];
        }
    }
    self.ek_editing = NO;
}

- (void)_ek_shutWithSender:(UIGestureRecognizer *)sender forCell:(EKSwipeableCollectionViewCell *)cell {
    sender.enabled = NO;
    @weakify(self);
    [cell ek_shutWithCompletion:^{
        @strongify(self);
        sender.enabled = YES;
        self.ek_editing = NO;
    }];
}

- (void)reloadData {
    [super reloadData];
    self.ek_editing = NO;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.ek_panRecognizer) {
        CGPoint translation = [self.ek_panRecognizer translationInView:self.superview];
        return fabs(translation.x) > fabs(translation.y);
    }
    if (gestureRecognizer == self.ek_tapRecognizer) {
        return self.ek_editing;
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [otherGestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

@end
