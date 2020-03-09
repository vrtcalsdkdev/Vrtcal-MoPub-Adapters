#import <Foundation/Foundation.h>
#import "MPInterstitialCustomEvent.h"

#import <VrtcalSDK/VrtcalSDK.h>

@interface VRTMPInterstitialCustomEvent : MPInterstitialCustomEvent <VRTInterstitialDelegate>
@property (strong, nonatomic) VRTInterstitial *vrtInterstitial;
@end
