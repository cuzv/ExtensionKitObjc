//
//  EKTextObserver.m
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

#import "EKTextObserver.h"
#import "EKMacro.h"

@interface EKTextObserver()
@property (nonatomic, assign, readwrite) NSInteger maxLength;
@property (nonnull, nonatomic, copy, readwrite) void (^actionHandler)(NSInteger);
@property (nullable, nonatomic, weak) id <NSObject> textFieldObserver;
@property (nullable, nonatomic, weak) id <NSObject> textViewObserver;
@end

@implementation EKTextObserver

- (void)dealloc {
    if (self.textFieldObserver) {
        [NSNotificationCenter.defaultCenter removeObserver:self.textFieldObserver];
    }
    if (self.textViewObserver) {
        [NSNotificationCenter.defaultCenter removeObserver:self.textViewObserver];
    }
}

- (nullable instancetype)initWithMaxLenght:(NSInteger)maxLength actionHandler:(void(^_Nonnull)(NSInteger))actionHandler {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _maxLength = maxLength;
    _actionHandler = actionHandler;
    
    return self;
}

- (void)observeTextField:(nonnull UITextField *)textField {
    @weakify(self);
    self.textFieldObserver =
    [NSNotificationCenter.defaultCenter addObserverForName:UITextFieldTextDidChangeNotification object:textField queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self);
        if (![note.object isKindOfClass:UITextField.class]) {
            return;
        }
        UITextField *textField = (UITextField *)note.object;
        if (!textField.text) {
            return;
        }
        if (textField.text.length > self.maxLength &&
            !textField.markedTextRange) {
            textField.text = [textField.text substringToIndex:self.maxLength];
        }
        self.actionHandler(self.maxLength - textField.text.length);
    }];
}

- (void)observeTextView:(nonnull UITextView *)textView {
    @weakify(self);
    self.textViewObserver =
    [NSNotificationCenter.defaultCenter addObserverForName:UITextViewTextDidChangeNotification object:textView queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self);
        if (![note.object isKindOfClass:UITextView.class]) {
            return;
        }
        UITextView *textView = (UITextView *)note.object;
        if (!textView.text) {
            return;
        }
        if (textView.text.length > self.maxLength &&
            !textView.markedTextRange) {
            textView.text = [textView.text substringToIndex:self.maxLength];
        }
        self.actionHandler(self.maxLength - textView.text.length);
        
        CGFloat cursorLocation = textView.selectedRange.location;
        NSRange range = NSMakeRange(0, cursorLocation);
        [textView scrollRangeToVisible:range];
    }];
}

@end
