//
//  EKSwipeableCollectionViewCell.m
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

#import "EKSwipeableCollectionViewCell.h"
#import "EKSwipeableCollectionViewCell+Internal.h"

@implementation EKSwipeableAction : NSObject

- (instancetype)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor {
    self = [super init];
    if (!self) {
        return nil;
    }
    _title = title;
    _titleColor = titleColor;
    _backgroundColor = backgroundColor;
    _layoutWidth = [title ek_sizeFromFont:UIFont.ek_size15 preferredMaxLayoutWidth:EKScreenSize().width].width + 16;
    return self;
}

@end

#pragma mark -

@interface EKSwipeableCollectionViewCell ()
@property (nonatomic, strong) UIView *ek_privateContentView;
@end

@implementation EKSwipeableCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    [self _ek_commitInit];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self _ek_commitInit];
    return self;
}


- (void)_ek_commitInit {
    self.exclusiveTouch = YES;
    self.contentView.exclusiveTouch = YES;
    
    [self addSubview:self.ek_privateContentView];
    [self addConstraints:@[
                           [NSLayoutConstraint constraintWithItem:self.ek_privateContentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:self.ek_privateContentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:self.ek_privateContentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                           [NSLayoutConstraint constraintWithItem:self.ek_privateContentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]
                           ]];
    [self sendSubviewToBack:self.ek_privateContentView];

    NSLayoutAttribute attribute = NSLayoutAttributeRight;
    UIView *rightView = self;
    NSInteger index = 0;
    for (EKSwipeableAction *action in self.swipeActions) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.backgroundColor = action.backgroundColor;
        [button setTitle:action.title forState:UIControlStateNormal];
        [button setTitleColor:action.titleColor forState:UIControlStateNormal];
        button.titleLabel.font = UIFont.ek_size15;
        button.tag = index;
        [button addTarget:self action:@selector(_ek_handleClickAction:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:button];
        [self sendSubviewToBack:button];
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:action.layoutWidth],
                               [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:attribute multiplier:1 constant:0]
                               ]];
        rightView = button;
        attribute = NSLayoutAttributeLeft;
        ++index;
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.contentView.transform = CGAffineTransformIdentity;
    self.ek_privateContentView.transform = CGAffineTransformIdentity;
    self.ek_editing = NO;
}

- (void)_ek_handleClickAction:(UIButton *)sender {
    [self handleSwipeAction:sender.tag];
    self.ek_editing = NO;
    if (self.ek_didEditedHandler) {
        self.ek_didEditedHandler();
    }
}

- (void)ek_shutWithCompletion:(void (^)())completion {
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.ek_privateContentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.ek_editing = NO;
        completion();
    }];
}

- (void)ek_lateralMoveContentView:(CGFloat)contentViewMove privateView:(CGFloat)privateViewMove {
    self.contentView.transform = CGAffineTransformMakeTranslation(contentViewMove, 0);
    self.ek_privateContentView.transform = CGAffineTransformMakeTranslation(privateViewMove, 0);
}

- (CGFloat)ek_totalWidth {
    CGFloat width = 0;
    for (EKSwipeableAction *action in self.swipeActions) {
        width += action.layoutWidth;
    }
    return width;
}

#pragma mark Properties

- (UIView *)ek_privateContentView {
    if (!_ek_privateContentView) {
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.whiteColor;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        _ek_privateContentView = view;
    }
    return _ek_privateContentView;
}

#pragma mark EKSwipeableActionDelegate

- (BOOL)canEdit {
    return NO;
}

- (NSArray<EKSwipeableAction *> *)swipeActions {
    return @[];
}

- (void)handleSwipeAction:(NSInteger)index {
}

@end
