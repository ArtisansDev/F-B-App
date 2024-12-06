#import "RmsMobileXdkFlutterPlugin.h"
#import <MOLPayXDK/MOLPayLib.h>

@interface RmsMobileXdkFlutterPlugin() <MOLPayLibDelegate> {
    MOLPayLib *mp;
    BOOL isCloseButtonClick;
    BOOL isPaymentInstructionPresent;
}@end


@implementation RmsMobileXdkFlutterPlugin {
    FlutterResult _result;
    NSMutableDictionary *paymentDetailsMutable;
    UIViewController *_viewController;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"fiuu_mobile_xdk_flutter"
            binaryMessenger:[registrar messenger]];
    UIViewController *viewController =
      [UIApplication sharedApplication].delegate.window.rootViewController;
  RmsMobileXdkFlutterPlugin* instance = [[RmsMobileXdkFlutterPlugin alloc] initWithViewController:viewController];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"startXDK"isEqualToString:call.method]){
      _result = result;
      paymentDetailsMutable = call.arguments;
      [self start];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

-(void)start{
    
    // Default setting for Cash channel payment result conditions
    isPaymentInstructionPresent = NO;
    isCloseButtonClick = NO;

    [paymentDetailsMutable setObject:[NSNumber numberWithBool:YES] forKey:@"is_submodule"];
    [paymentDetailsMutable setObject:@"molpay-mobile-xdk-flutter-ios" forKey:@"module_id"];
    [paymentDetailsMutable setObject:@"15f" forKey:@"wrapper_version"];

    mp = [[MOLPayLib alloc] initWithDelegate:self andPaymentDetails:paymentDetailsMutable];

    mp.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(close:)];
    mp.navigationItem.hidesBackButton = YES;
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName : UIColor.whiteColor};
        appearance.backgroundColor = [UIColor whiteColor];
        [UINavigationBar appearance].standardAppearance = appearance;
        [UINavigationBar appearance].scrollEdgeAppearance = appearance;
    }
    
    // Push method (This requires host navigation controller to be available at this point of runtime process,
    // refer AppDelegate.m for sample Navigation Controller implementations)
    //[self.navigationController pushViewController:mp animated:YES];
    
    // Present method (Simple mode)
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:mp];
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
        viewController = viewController.presentedViewController;
    }
    nc.modalPresentationStyle = UIModalPresentationFullScreen;
    [viewController presentViewController:nc animated:NO completion:nil];
}

- (IBAction)close:(id)sender
{
    // Closes MOLPay
    [mp closemolpay];
    
    isCloseButtonClick = YES;
}

// MOLPayLibDelegates
- (void)transactionResult: (NSDictionary *)result
{
    // Payment status results returned here
    NSLog(@"transactionResult result = %@", result);

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    NSString *resultString;
    if (! jsonData) {
        resultString = [NSString stringWithFormat:@"Error while converting result to json format: %@", error];
    } else {
        resultString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    _result(resultString);
    
    // All success cash channel payments will display a payment instruction, we will let the user to close manually
    if ([[result objectForKey:@"pInstruction"] integerValue] == 1 && isPaymentInstructionPresent == NO && isCloseButtonClick == NO)
    {
        isPaymentInstructionPresent = YES;
    }
    else
    {
        // Push method
        // [self.navigationController popViewControllerAnimated:NO];
        
        // Present method
        UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        if ( viewController.presentedViewController && !viewController.presentedViewController.isBeingDismissed ) {
            viewController = viewController.presentedViewController;
        }
        [viewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
