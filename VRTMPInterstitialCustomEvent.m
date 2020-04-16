#import "VRTMPInterstitialCustomEvent.h"

@interface VRTMPInterstitialCustomEvent()
@property (weak) UIViewController *viewControllerForModalPresentation;
@end

@implementation VRTMPInterstitialCustomEvent

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    NSString *strZoneId = info[@"zid"];
    int zoneId = [strZoneId intValue];
    
    if (zoneId <= 0) {
        NSError *error = [VRTError errorWithCode:VRTErrorCodeInvalidParam format:@"Unusable zoneId of %i. Vrtcal ads require an Zone ID (unsigned int) to serve ads", zoneId];
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
        return;
    }
    
    self.vrtInterstitial = [[VRTInterstitial alloc] init];
    self.vrtInterstitial.adDelegate = self;
    [self.vrtInterstitial loadAd:zoneId];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    self.viewControllerForModalPresentation = rootViewController;
    
    [self.vrtInterstitial showAd];
}

#pragma mark - VRTInterstitialDelegate
- (void)vrtInterstitialAdClicked:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

- (void)vrtInterstitialAdDismissed:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEventDidDisappear:self];
}

- (void)vrtInterstitialAdFailedToLoad:(nonnull VRTInterstitial *)vrtInterstitial error:(nonnull NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)vrtInterstitialAdFailedToShow:(nonnull VRTInterstitial *)vrtInterstitial error:(nonnull NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)vrtInterstitialAdLoaded:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEvent:self didLoadAd:vrtInterstitial];
}

- (void)vrtInterstitialAdShown:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (nonnull UIViewController *)vrtViewControllerForModalPresentation {
    return self.viewControllerForModalPresentation;
}

@end
