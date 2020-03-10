#import <Foundation/Foundation.h>
@import MoPub;

#import <VrtcalSDK/VrtcalSDK.h>

@interface VRTMPInterstitialCustomEvent : MPInterstitialCustomEvent <VRTInterstitialDelegate>
@property (strong, nonatomic) VRTInterstitial *vrtInterstitial;
@end
