#import <Foundation/Foundation.h>
#import <VrtcalSDK/VrtcalSDK.h>

#if __has_include(<MoPub/MoPub.h>)
    #import <MoPub/MoPub.h>
#elif __has_include(<MoPubSDKFramework/MoPub.h>)
    #import <MoPubSDKFramework/MoPub.h>
#else
    #import "MPFullscreenAdAdapter.h"
#endif


//MoPub Interstitial Adapter, Vrtcal as Secondary
@interface VRTMPInterstitialCustomEvent : MPFullscreenAdAdapter <MPThirdPartyFullscreenAdAdapter>
@end
