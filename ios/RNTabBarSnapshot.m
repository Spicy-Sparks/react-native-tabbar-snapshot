#import <UIKit/UIKit.h>
#import "RNTabBarSnapshot.h"

@implementation RNTabBarSnapshot

RCT_EXPORT_MODULE();

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)makeSnapshot:(NSString*)backgroundColor completion:(void(^)(NSString *data)) completion  {
    dispatch_async(dispatch_get_main_queue(), ^{
        
      UIViewController *viewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        
      UITabBarController *tabController = [viewController isKindOfClass:[UITabBarController class]] ? (UITabBarController *)viewController : [viewController tabBarController];

      UIView *tabBarView = [tabController tabBar];
      UIColor *prevTabsColor = tabBarView.backgroundColor;
      tabBarView.backgroundColor = [self colorFromHexString:backgroundColor];
      
      UIGraphicsBeginImageContextWithOptions([tabBarView bounds].size, true, 0.0);
      [tabBarView drawViewHierarchyInRect:[tabBarView bounds] afterScreenUpdates:true];
      UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
        
      tabBarView.backgroundColor = prevTabsColor;

      NSData *imageData = UIImageJPEGRepresentation(image, 10);
      NSString *encodedString = [imageData base64EncodedStringWithOptions:0];

      completion(encodedString);
    });
    
}

RCT_EXPORT_METHOD(makeTabBarSnapshot:(NSString*)backgroundColor resolve:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject) {
    [self makeSnapshot:backgroundColor completion:^(NSString *encodedString) {
        resolve(encodedString);
    }];
}

@end
