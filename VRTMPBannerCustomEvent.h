#import <Foundation/Foundation.h>
#import "MPBannerCustomEvent.h"

#import <VrtcalSDK/VrtcalSDK.h>

@interface VRTMPBannerCustomEvent : MPBannerCustomEvent <VRTBannerDelegate>
@property (strong, nonatomic) VRTBanner *vrtBanner;
@end
