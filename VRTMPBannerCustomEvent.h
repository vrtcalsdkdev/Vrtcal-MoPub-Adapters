#import <Foundation/Foundation.h>
@import MoPub;
#import <VrtcalSDK/VrtcalSDK.h>

@interface VRTMPBannerCustomEvent : MPBannerCustomEvent <VRTBannerDelegate>
@property (strong, nonatomic) VRTBanner *vrtBanner;
@end
