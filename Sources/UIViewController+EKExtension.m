//
//  UIViewController+EKExtension.m
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

#import "UIViewController+EKExtension.h"
#import "UIBarButtonItem+EKExtension.h"
#import "EKCoreLibsExtension.h"
#import "UIImage+EKExtension.h"

@interface UIImagePickerController(_EKExtension)
@property (nonatomic, copy) void(^_Nonnull ek_handler)(UIImage *_Nullable image);
@end

@implementation UIImagePickerController(_EKExtension)

- (void (^)(UIImage * _Nullable))ek_handler {
    return EKGetAssociatedObject(self, _cmd);
}

- (void)setEk_handler:(void (^)(UIImage * _Nullable))ek_handler {
    EKSetAssociatedObject(self, @selector(ek_handler), ek_handler, OBJC_ASSOCIATION_COPY);
}

@end

#pragma mark -

@interface UIViewController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation UIViewController (EKExtension)

- (void)ek_setRightBarButtonItemWithTitle:(nonnull NSString *)title actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ek_barButtonItemWithTitle:title actionHandler:handler];
}

- (void)ek_setLeftBarButtonItemWithTitle:(nonnull NSString *)title actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ek_barButtonItemWithTitle:title actionHandler:handler];
}

- (void)ek_setRightBarButtonItemWithImage:(nullable UIImage *)image actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ek_barButtonItemWithImage:image actionHandler:handler];
}

- (void)ek_setLeftBarButtonItemWithImage:(nullable UIImage *)image actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ek_barButtonItemWithImage:image actionHandler:handler];
}

- (void)ek_setRightBarButtonItemWithSystemItem:(UIBarButtonSystemItem)item actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ek_barButtonItemWithSystemItem:item actionHandler:handler];
}

- (void)ek_setLeftBarButtonItemWithSystemItem:(UIBarButtonSystemItem)item actionHandler:(void(^_Nonnull)(UIBarButtonItem *_Nonnull sender))handler {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem ek_barButtonItemWithSystemItem:item actionHandler:handler];
}

#pragma mark - 

- (void)ek_showViewController:(nonnull UIViewController *)viewController {
    [self.navigationController showViewController:viewController sender:self];
}

- (void)ek_backToPreviousViewControllerAnimated:(BOOL)animated {
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:animated completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:animated];
    }
}

- (void)ek_backToRootViewControllerAnimated:(BOOL)animated {
    if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:animated completion:nil];
    } else {
        [self.navigationController popToRootViewControllerAnimated:animated];
    }
}

- (void)ek_dismissViewControllerAnimated:(BOOL)animated completion:(void (^_Nullable)(void))completion {
    [self.presentingViewController dismissViewControllerAnimated:animated completion:completion];
}

- (void)ek_dismissToTopViewControllerAnimated:(BOOL)animated completion:(void (^_Nullable)(void))completion {
    UIViewController *presentedViewController = self;
    while (presentedViewController.presentingViewController) {
        presentedViewController = presentedViewController.presentingViewController;
    }
    [presentedViewController dismissViewControllerAnimated:animated completion:completion];
}

- (void)ek_addChildVewController:(nonnull UIViewController *)viewController {
    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    viewController.view.frame = self.view.frame;
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

#pragma mark - 

+ (__kindof UIViewController *_Nullable)ek_findTopLevelViewController {
    UIViewController *vc = UIApplication.sharedApplication.keyWindow.rootViewController;
    return [self _ek_findTopLevelViewControllerWithSender:vc];
}

+ (__kindof UIViewController *_Nullable)_ek_findTopLevelViewControllerWithSender:(nonnull UIViewController *)vc {
    if (vc.presentedViewController) {
        return [self _ek_findTopLevelViewControllerWithSender:vc.presentedViewController];
    }
    if ([vc isKindOfClass:UISplitViewController.class]) {
        UIViewController *last = ((UISplitViewController *)vc).viewControllers.lastObject;
        if (last) {
            return [self _ek_findTopLevelViewControllerWithSender:vc];
        }
        return vc;
    }
    if ([vc isKindOfClass:UINavigationController.class]) {
        UIViewController *top = ((UINavigationController *)vc).topViewController;
        if (top) {
            return [self _ek_findTopLevelViewControllerWithSender:top];
        }
        return top;
    }
    if ([vc isKindOfClass:UITabBarController.class]) {
        UIViewController *selected = ((UITabBarController *)vc).selectedViewController;
        if (selected) {
            return [self _ek_findTopLevelViewControllerWithSender:selected];
        }
        return selected;
    }
    return vc;
}

#pragma mark - 

- (void)ek_presentImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType completionHandler:(void(^_Nonnull)(UIImage *_Nullable image))handler {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.sourceType = sourceType;
    picker.videoQuality = UIImagePickerControllerQualityTypeLow;
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.ek_handler = handler;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker ek_dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    EKBackgroundThreadAsyncAction(^{
        UIImage *image = info[UIImagePickerControllerEditedImage];
        if (image) {
            UIImage *newImage = [image ek_orientationTo:UIImageOrientationUp];
            newImage = [UIImage imageWithData:[newImage ek_compressToByte:100 * 1024] scale:UIScreen.mainScreen.scale];
            EKUIThreadAsyncAction(^{
                [picker ek_dismissViewControllerAnimated:YES completion:nil];
                if (picker.ek_handler) {
                    picker.ek_handler(newImage);
                }
            });
        }
    });
}


#pragma mark - 

- (void)ek_presentError:(nonnull NSError *)error {
    [self ek_presentAlertWithTitle:nil message:error.localizedDescription];
}

- (void)ek_presentAlertWithTitle:(nullable NSString *)title
                         message:(nonnull NSString *)message {
    [self ek_presentAlertWithTitle:title message:message cancelTitle:nil cancelHandler:nil otherTitles:nil othersHandler:nil];
}

- (void)ek_presentAlertWithTitle:(nullable NSString *)title
                         message:(nonnull NSString *)message
                     cancelTitle:(nullable NSString *)cancelTitle
                   cancelHandler:(void(^_Nullable)(UIAlertAction *_Nonnull))cancelHandler
                     otherTitles:(nullable NSArray<NSString *> *)otherTitles
                   othersHandler:(void(^_Nullable)(UIAlertAction *_Nonnull))othersHandler {
    UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle ?: NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:cancelHandler];
    [alertControler addAction:cancelAction];
    
    for(NSUInteger index = 0; index < otherTitles.count; ++index) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:otherTitles[index] style:UIAlertActionStyleDefault handler:othersHandler];
        action.ek_index = index;
        [alertControler addAction:action];
    }
    [self presentViewController:alertControler animated:YES completion:nil];
}

+ (void)ek_presentError:(nonnull NSError *)error {
    [self ek_presentAlertWithTitle:nil message:error.localizedDescription];

}

+ (void)ek_presentAlertWithTitle:(nullable NSString *)title
                         message:(nonnull NSString *)message {
    [self ek_presentAlertWithTitle:title message:message cancelTitle:nil cancelHandler:nil otherTitles:nil othersHandler:nil];
}

+ (void)ek_presentAlertWithTitle:(nullable NSString *)title
                         message:(nonnull NSString *)message
                     cancelTitle:(nullable NSString *)cancelTitle
                   cancelHandler:(void(^_Nullable)(UIAlertAction *_Nonnull))cancelHandler
                     otherTitles:(nullable NSArray<NSString *> *)otherTitles
                   othersHandler:(void(^_Nullable)(UIAlertAction *_Nonnull))othersHandler {
    [[self ek_findTopLevelViewController] ek_presentAlertWithTitle:title
                                                           message:message
                                                       cancelTitle:cancelTitle
                                                     cancelHandler:cancelHandler
                                                       otherTitles:otherTitles
                                                     othersHandler:othersHandler];
}

@end


@implementation UIAlertAction(EKExtension)

- (NSUInteger)ek_index {
    return [EKGetAssociatedObject(self, _cmd) unsignedIntegerValue];
}

- (void)setEk_index:(NSUInteger)ek_index {
    EKSetAssociatedObject(self, @selector(ek_index), @(ek_index), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
