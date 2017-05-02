//
//  AppDelegate.m
//  test
//
//  Created by Dong Vo on 2/3/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "IQKeyboardManager.h"
#import "ImgurAnonymousAPIClient.h"


@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Fabric with:@[[Crashlytics class]]];
  
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
    [ImgurAnonymousAPIClient client];
    
   // self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;

    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    LoginViewController *vcLogin = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.window setRootViewController:vcLogin];
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    return YES;
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  //  NSString *str = [NSString stringWithFormat:@"Device Token=%@",deviceToken];
    NSLog(@"This is device token%@", deviceToken);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
  //  NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"Error %@",err.localizedDescription);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Custom View Golbal

-(void)closeProgress{

    if(self.processDataView){
    
        [self.processDataView closeProgress];
    }
}

-(void)showProcessBar:(UIImage *)image{

    if(!self.processDataView){
    
        self.processDataView = [[ProcessDataView alloc] initWithFrame:CGRectMake(0, SH, SW, 50) withImage:image];
       
        self.processDataView.clipsToBounds = YES;
        [self.window addSubview:self.processDataView];
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             [self.processDataView setFrame:CGRectMake(0, SH - 50, SW, 50)];
                         }
                         completion:nil];
        [UIView commitAnimations];

        
    }
    else{
    
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Đang upload hình vui lòng đợi hoàn tất" buttonClick:nil];
    }
}

@end
