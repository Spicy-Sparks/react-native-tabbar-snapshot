#import <UIKit/UIKit.h>
#import "RNTabBarSnapshot.h"

@implementation RNTabBarSnapshot

RCT_EXPORT_MODULE();

- (void)makeSnapshot:(void(^)(NSString *data)) completion  {
    dispatch_async(dispatch_get_main_queue(), ^{
        
      UIViewController *viewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
        
      UITabBarController *tabController = [viewController isKindOfClass:[UITabBarController class]] ? (UITabBarController *)viewController : [viewController tabBarController];

      UIView *tabBarView = [tabController tabBar];
      
      UIGraphicsBeginImageContextWithOptions([tabBarView bounds].size, true, 0.0);
      [tabBarView drawViewHierarchyInRect:[tabBarView bounds] afterScreenUpdates:true];
      UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();

      NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
      NSString *encodedString = [imageData base64EncodedStringWithOptions:0];

      completion(encodedString);
    });
    
}

RCT_EXPORT_METHOD(makeTabBarSnapshot:(RCTPromiseResolveBlock)resolve
                  rejecter:(__unused RCTPromiseRejectBlock)reject) {
    [self makeSnapshot:^(NSString *encodedString) {
        resolve(encodedString);
    }];
}

@end
