#import "VRTAdapterConfiguration.h"
#import <VrtcalSDK/VrtcalSDK.h>

#if __has_include("MoPub.h")
    #import "MPLogging.h"
#endif

//https://developers.mopub.com/networks/integrate/build-adapters-ios/

// Initialization configuration keys
static NSString * const keyAppId = @"appid";


@interface VRTAdapterConfiguration() <VrtcalSdkDelegate>
@end

@implementation VRTAdapterConfiguration

#pragma mark - Caching

+ (void)updateInitializationParameters:(NSDictionary *)parameters {
    NSLog(@"parameters = %@", parameters);
}

#pragma mark - MPAdapterConfiguration

- (NSString *)adapterVersion {
    return @"1.0.6";
}

- (NSString *)biddingToken {
    return nil;
}

- (NSString *)moPubNetworkName {
    return @"vrtcal";
}

- (NSString *)networkSdkVersion {
    return [VrtcalSDK sdkVersion];
}

- (void)initializeNetworkWithConfiguration:(NSDictionary<NSString *, id> *)configuration
                                  complete:(void(^)(NSError *))complete {
    NSString *strAppId = configuration[keyAppId];
    int appId = [strAppId intValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        [VrtcalSDK initializeSdkWithAppId:appId sdkDelegate:self];
    });
}

- (void)sdkInitializationFailedWithError:(nonnull NSError *)error {
    VRTLogWarn(@"Error: %@", error);
}

- (void)sdkInitialized {
    VRTLogInfo(@"SDK Initialized");
}

@end

