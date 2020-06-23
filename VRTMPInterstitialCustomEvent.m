#import "VRTMPInterstitialCustomEvent.h"

//MoPub Interstitial Adapter, Vrtcal as Secondary
@interface VRTMPInterstitialCustomEvent()
@property (weak) UIViewController *viewControllerForModalPresentation;
@end

@implementation VRTMPInterstitialCustomEvent

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
    [self requestInterstitialWithCustomEventInfo:info adMarkup:nil];
}

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
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

-(BOOL)enableAutomaticImpressionAndClickTracking {
    return YES;
}

#pragma mark - VRTInterstitialDelegate
- (void)vrtInterstitialAdLoaded:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEvent:self didLoadAd:vrtInterstitial];
}

- (void)vrtInterstitialAdFailedToLoad:(nonnull VRTInterstitial *)vrtInterstitial error:(nonnull NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)vrtInterstitialAdWillShow:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEventWillAppear:self];
}

- (void)vrtInterstitialAdDidShow:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEventDidAppear:self];
}

- (void)vrtInterstitialAdFailedToShow:(nonnull VRTInterstitial *)vrtInterstitial error:(nonnull NSError *)error {
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)vrtInterstitialAdClicked:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEventDidReceiveTapEvent:self];
}

-(void)vrtInterstitialAdWillLeaveApplication:(nonnull VRTInterstitial*)vrtInterstitial {
    [self.delegate interstitialCustomEventWillLeaveApplication:self];
}

- (void)vrtInterstitialAdWillDismiss:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEventWillDisappear:self];
}

- (void)vrtInterstitialAdDidDismiss:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate interstitialCustomEventDidDisappear:self];
}


- (nonnull UIViewController *)vrtViewControllerForModalPresentation {
    return self.viewControllerForModalPresentation;
}


















@end
