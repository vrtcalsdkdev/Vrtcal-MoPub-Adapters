//MoPub Interstitial Adapter, Vrtcal as Secondary

//Header
#import "VRTMPInterstitialCustomEvent.h"

@interface VRTMPInterstitialCustomEvent() <VRTInterstitialDelegate>
@property (weak) UIViewController *viewControllerForModalPresentation;
@property VRTInterstitial *vrtInterstitial;
@property BOOL vrtcalAdLoaded;
@end


//Ignore "Auto property synthesis will not synthesize property" warnings for delegate, hasAdAvailable and localExtras.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-property-synthesis"
@implementation VRTMPInterstitialCustomEvent
#pragma clang diagnostic pop

- (BOOL)isRewardExpected {
    return NO;
}

- (BOOL)hasAdAvailable {
    return self.vrtcalAdLoaded;
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return YES;
}


- (void)requestAdWithAdapterInfo:(NSDictionary *)info {
    [self requestAdWithAdapterInfo:info adMarkup:nil];
}

- (void)requestAdWithAdapterInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    NSString *strZoneId = info[@"zid"];
    int zoneId = [strZoneId intValue];
    if (zoneId <= 0) {
        NSError *error = [VRTError errorWithCode:VRTErrorCodeInvalidParam format:@"Unusable zoneId of %i. Vrtcal ads require a Zone ID (unsigned int) to serve ads", zoneId];
        [self.delegate fullscreenAdAdapter:self didFailToLoadAdWithError:error];
        return;
    }
    
    self.vrtInterstitial = [[VRTInterstitial alloc] init];
    self.vrtInterstitial.adDelegate = self;
    [self.vrtInterstitial loadAd:zoneId];
}

- (void)presentAdFromViewController:(UIViewController *)rootViewController {
    self.viewControllerForModalPresentation = rootViewController;
    [self.vrtInterstitial showAd];
}

- (void)handleDidInvalidateAd {
    //Though Vrtcal has internal caching, it doesn't respond to this event.
}


- (void)handleDidPlayAd {
    //Vrtcal does not currently handle this event.
}




#pragma mark - VRTInterstitialDelegate
- (void)vrtInterstitialAdLoaded:(nonnull VRTInterstitial *)vrtInterstitial {
    self.vrtcalAdLoaded = YES;
    [self.delegate fullscreenAdAdapterDidLoadAd:self];
}

- (void)vrtInterstitialAdFailedToLoad:(nonnull VRTInterstitial *)vrtInterstitial error:(nonnull NSError *)error {
    self.vrtcalAdLoaded = NO;
    [self.delegate fullscreenAdAdapter:self didFailToLoadAdWithError:error];
}

- (void)vrtInterstitialAdWillShow:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate fullscreenAdAdapterAdWillAppear:self];
}

- (void)vrtInterstitialAdDidShow:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate fullscreenAdAdapterAdDidAppear:self];
}

- (void)vrtInterstitialAdFailedToShow:(nonnull VRTInterstitial *)vrtInterstitial error:(nonnull NSError *)error {
    [self.delegate fullscreenAdAdapter:self didFailToShowAdWithError:error];
}

- (void)vrtInterstitialAdClicked:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate fullscreenAdAdapterDidReceiveTap:self];
}

-(void)vrtInterstitialAdWillLeaveApplication:(nonnull VRTInterstitial*)vrtInterstitial {
    [self.delegate fullscreenAdAdapterWillLeaveApplication:self];
}

- (void)vrtInterstitialAdWillDismiss:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate fullscreenAdAdapterAdWillDisappear:self];
    [self.delegate fullscreenAdAdapterAdWillDismiss:self];
}

- (void)vrtInterstitialAdDidDismiss:(nonnull VRTInterstitial *)vrtInterstitial {
    [self.delegate fullscreenAdAdapterAdDidDisappear:self];
    [self.delegate fullscreenAdAdapterAdDidDismiss:self];
}


- (nonnull UIViewController *)vrtViewControllerForModalPresentation {
    return self.viewControllerForModalPresentation;
}

- (void)vrtInterstitialVideoStarted:(nonnull VRTInterstitial *)vrtInterstitial {
    //MoPub does not offer an analog to this event
}

- (void)vrtInterstitialVideoCompleted:(nonnull VRTInterstitial *)vrtInterstitial {
    //MoPub does not offer an analog to this event
}






@end
