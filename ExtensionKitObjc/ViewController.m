//
//  ViewController.m
//  Copyright (c) 2014-2016 Moch Xiao (http://mochxiao.com).
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

#import "ViewController.h"
#import "ExtensionKitObjc.h"
#import "NextViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *field;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    
    self.colorView.frame = CGRectMake(30, 66, 200, 200);
    [self.view addSubview:self.colorView];
    
//    self.colorView.ek_minY = 80;
//    [self.colorView ek_addBorderline];
//    [self.colorView ek_addBorderlineRectEdge:UIRectEdgeBottom constant:-12];
    [self.colorView ek_addBorderlineRectEdge:UIRectEdgeAll width:0 color:nil multiplier:1 constant:-12];

    
    self.imageView.frame = CGRectMake(80, 120, 200, 200);
    [self.view addSubview:self.imageView];
    self.imageView.backgroundColor = [UIColor yellowColor];
//    UIImage *image = [UIImage ek_imageWithColor:[UIColor redColor] size:self.imageView.bounds.size roundingCorners:UIRectCornerAllCorners radius:5 strokeColor:nil strokeLineWidth:0];
//    self.imageView.image = image;
    
    UIImage *image = [UIImage imageNamed:@"C0g0F9BUcAERgYi"];
//    CGFloat sideLength = MIN(image.size.width, image.size.height);
//    image = [image ek_imageWithRoundingCorners:UIRectCornerAllCorners
//                                        radius:20
//                                   strokeColor:[UIColor orangeColor]
//                               strokeLineWidth:20
//                                strokeLineJoin:kCGLineJoinMiter];
//    image = [image imageByRoundCornerRadius:20 corners:UIRectCornerAllCorners borderWidth:20 borderColor:[UIColor orangeColor] borderLineJoin:kCGLineJoinMiter];
    image = [image ek_cricle];
    self.imageView.image = image;
    
    
    [self.colorView ek_addRoundingCornersRadius:8];
    NSLog(@"%@", self.colorView.ek_isRoundingCornersExists ? @"YES" : @"NO");
    
    [self.colorView ek_addSubview:[UIView ek_blur]];
    
    {
        [self.colorView ek_longPressAction:^(UIView * _Nonnull sender) {
            NSLog(@"ek_longPressAction: %@", sender);
        }];
        [self.colorView ek_doubleTapAction:^(UIView * _Nonnull sender) {
            NSLog(@"doubleTapAction: %@", sender);
        }];
        [self.colorView ek_tapAction:^(UIView * _Nonnull sender) {
            NSLog(@"tapAction: %@", sender);
        }];
    }
    
    {
        self.colorView.ek_touchExtendInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
        
        self.actionButton.frame = CGRectMake(self.imageView.ek_minX, self.imageView.ek_maxY + 20, 220, 44);
        self.actionButton.ek_backgroundImage = EKImageMake(UIColor.ek_random, self.actionButton.frame.size, UIRectCornerAllCorners, 5, nil, 0);
    //    self.actionButton.backgroundColor = UIColor.ek_random;
        self.actionButton.ek_cornerRadius = 5;
        [self.view addSubview:self.actionButton];
        [self.actionButton addTarget:self action:@selector(handleTapAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.actionButton.ek_image = EKImageMake(UIColor.ek_random, CGSizeMake(16, 16), UIRectCornerAllCorners, 8, nil, 0);
        [self.actionButton ek_setImageAlignToLeftWithMargin:16];
                
//        [self.imageView ek_addRoundingCornersRadius:20];
    }
    
//    self.label.frame = CGRectMake(self.actionButton.ek_minX, self.actionButton.ek_maxY + 20, 80, 24);
    
    {
        [self.view addSubview:self.label];
        self.label.text = @"不明真相的吃瓜群众";
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
        [self.view addConstraint:left];
        [self.view addConstraint:bottom];
    }
    
    
    {
        [self.view addSubview:self.field];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.field attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.field attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-80];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.field attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0 constant:220];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.field attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0 constant:30];
        
        [self.view addConstraint:left];
        [self.view addConstraint:bottom];
        [self.view addConstraint:width];
        [self.view addConstraint:height];
    }
    
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(handleNext:)];
    }
    
    {
        [self.field ek_observerTextLenghtWithMax:20 changing:^(NSInteger left) {
            NSLog(@"left: %@", @(left));
        }];
    }
    
    {
        NSObject *obj = [NSObject new];
        EKRelease(obj);
    }
}

- (void)handleNext:(UIBarButtonItem *)sender {
    [self.navigationController pushViewController:[NextViewController new] animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.colorView.ek_isRoundingCornersExists) {
        NSLog(@"RoundingCornersExists");
        [self.colorView ek_removeRoundingCorners];
    }
    NSLog(@"%@", self.colorView.ek_isRoundingCornersExists ? @"YES" : @"NO");
    
    if (self.view.ek_isActivityIndicatorAnimating) {
        [self.view ek_stopActivityIndicatorAnimation];
    } else {
        [self.view ek_satrtActivityIndicatorAnimation];
    }
    
    
}

- (void)handleTapAction:(UIButton *)sender {
    if (self.actionButton.ek_isActivityIndicatorAnimating) {
        [self.actionButton ek_stopActivityIndicatorAnimation];
    } else {
        [self.actionButton ek_satrtActivityIndicatorAnimation];
    }
}


#pragma mark - Properties

- (UIView *)colorView {
    if (!_colorView) {
        _colorView = [UIView new];
        _colorView.backgroundColor = [UIColor orangeColor];
    }
    return _colorView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _actionButton.ek_title = @"Tap me if you dare";
    }
    return _actionButton;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        _label.backgroundColor = [UIColor ek_random];
        _label.ek_contentInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    }
    return _label;
}

- (UITextField *)field {
    if (!_field) {
        _field = [UITextField new];
        _field.translatesAutoresizingMaskIntoConstraints = NO;
        _field.backgroundColor = [UIColor ek_random];
        _field.ek_contentInsets = UIEdgeInsetsMake(4, 8, 4, 0);
    }
    return _field;
}


@end
