//
//  NextViewController.m
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

#import "NextViewController.h"
#import "ExtensionKitObjc.h"

@interface NextViewController ()
@property (nonatomic, strong) UITextView *textView;

@end

@implementation NextViewController

- (void)dealloc {
    NSLog(@"~~~~~~~~~~~%s~~~~~~~~~~~", __FUNCTION__);    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.textView];
    self.textView.frame = CGRectMake(50, 120, 200, 100);
    
    [self.textView ek_observerTextLenghtWithMax:20 changing:^(NSInteger left) {
        NSLog(@"left: %@", @(left));
    }];
    
    @weakify(self)
    [self ek_setRightBarButtonItemWithTitle:@"Back" actionHandler:^(UIBarButtonItem * _Nonnull sender) {
        @strongify(self);
        NSLog(@"sender: %@", sender);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self ek_setLeftBarButtonItemWithTitle:@"Preview" actionHandler:^(UIBarButtonItem * _Nonnull sender) {
        @strongify(self);
        NSLog(@"sender: %@", sender);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self ek_presentImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary completionHandler:^(UIImage * _Nullable image) {
        NSLog(@"%@", image);
    }];
}


#pragma mark -

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.ek_placeholder = @"A good approach to add padding to UITextField is to subclass UITextField and add an edgeInsets property";
//        _textView.text = @"啊撒旦个山大";
        _textView.backgroundColor = [UIColor ek_random];
    }
    return _textView;
}


@end
