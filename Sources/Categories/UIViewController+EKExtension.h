//
//  UIViewController+EKExtension.h
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

#import <UIKit/UIKit.h>

@interface UIViewController (EKExtension)

- (void)ek_setRightBarButtonItemWithTitle:(nonnull NSString *)title actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler;
- (void)ek_setLeftBarButtonItemWithTitle:(nonnull NSString *)title actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler;

- (void)ek_setRightBarButtonItemWithImage:(nullable UIImage *)image actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler;
- (void)ek_setLeftBarButtonItemWithImage:(nullable UIImage *)image actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler;

- (void)ek_setRightBarButtonItemWithSystemItem:(UIBarButtonSystemItem)item actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler;
- (void)ek_setLeftBarButtonItemWithSystemItem:(UIBarButtonSystemItem)item actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler;

#pragma mark -

- (void)ek_showViewController:(nonnull UIViewController *)viewController;
- (void)ek_backToPreviousViewControllerAnimated:(BOOL)animated;
- (void)ek_backToRootViewControllerAnimated:(BOOL)animated;
- (void)ek_presentViewController:(nonnull UIViewController *)viewController;
- (void)ek_dismissViewControllerAnimated:(BOOL)animated completion:(void (^_Nullable)(void))completion;
- (void)ek_dismissToTopViewControllerAnimated:(BOOL)animated completion:(void (^_Nullable)(void))completion;
- (void)ek_addChildVewController:(nonnull UIViewController *)viewController;

#pragma mark - 

+ (__kindof UIViewController *_Nullable)ek_findTopLevelViewController;

#pragma mark - 

- (void)ek_presentImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType completionHandler:(void(^_Nonnull)(UIImage *_Nullable image))handler;

#pragma mark - 

- (void)ek_presentError:(nonnull NSError *)error;
- (void)ek_presentAlertWithTitle:(nullable NSString *)title
                         message:(nonnull NSString *)message;
- (void)ek_presentAlertWithTitle:(nullable NSString *)title
                         message:(nonnull NSString *)message
                     cancelTitle:(nullable NSString *)cancelTitle
                   cancelHandler:(void(^_Nullable)(UIAlertAction *_Nonnull))cancelHandler
                     otherTitles:(nullable NSArray<NSString *> *)otherTitles
                   othersHandler:(void(^_Nullable)(UIAlertAction *_Nonnull))othersHandler;

+ (void)ek_presentError:(nonnull NSError *)error;
+ (void)ek_presentAlertWithTitle:(nullable NSString *)title
                         message:(nonnull NSString *)message;
+ (void)ek_presentAlertWithTitle:(nullable NSString *)title
                         message:(nonnull NSString *)message
                     cancelTitle:(nullable NSString *)cancelTitle
                   cancelHandler:(void(^_Nullable)(UIAlertAction *_Nonnull))cancelHandler
                     otherTitles:(nullable NSArray<NSString *> *)otherTitles
                   othersHandler:(void(^_Nullable)(UIAlertAction *_Nonnull))othersHandler;


@end


@interface UIAlertAction(EKExtension)
@property (nonatomic, assign) NSUInteger ek_index;
@end
