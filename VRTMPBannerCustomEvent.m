//MoPub Banner Adapter, Vrtcal as Secondary

//Header
#import "VRTMPBannerCustomEvent.h"


@interface VRTMPBannerCustomEvent() <VRTBannerDelegate>
@property VRTBanner *vrtBanner;
@end

//Ignore "Auto property synthesis will not synthesize property" warnings for delegate and localExtras.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-property-synthesis"
@implementation VRTMPBannerCustomEvent
#pragma clang diagnostic pop

-(void) requestAdWithSize:(CGSize)size adapterInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    NSString *strZoneId = info[@"zid"];
    int zoneId = [strZoneId intValue];

    if (zoneId <= 0) {
        NSError *error = [VRTError errorWithCode:VRTErrorCodeInvalidParam format:@"Unusable zoneId of %i. Vrtcal ads require a Zone ID (unsigned int) to serve ads", zoneId];
        [self.delegate inlineAdAdapter:self didFailToLoadAdWithError:error];
        return;
    }

    self.vrtBanner = [[VRTBanner alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.vrtBanner.adDelegate = self;
    [self.vrtBanner loadAd:zoneId];
}

- (void)rotateToOrientation:(UIInterfaceOrientation)newOrientation {
    VRTLogInfo(@"newOrientation = %li", (long)newOrientation);
}

- (void)didDisplayAd {
    VRTLogWhereAmI();
}

- (BOOL)enableAutomaticImpressionAndClickTracking {
    return YES;
}


#pragma mark - VRTBannerDelegate
- (void)vrtBannerAdLoaded:(nonnull VRTBanner *)vrtBanner withAdSize:(CGSize)adSize {
    vrtBanner.frame = CGRectMake(0, 0, adSize.width, adSize.height);
    [self.delegate inlineAdAdapter:self didLoadAdWithAdView:self.vrtBanner];
}

- (void)vrtBannerAdFailedToLoad:(nonnull VRTBanner *)vrtBanner error:(nonnull NSError *)error {
    [self.delegate inlineAdAdapter:self didFailToLoadAdWithError:error];
}

- (void)vrtBannerAdClicked:(nonnull VRTBanner *)vrtBanner {
    //MoPub offers trackClick, but we have decided to let them handle click tracking.
}

- (void)vrtBannerWillPresentModal:(nonnull VRTBanner *)vrtBanner ofType:(VRTModalType)modalType {
    if (modalType == VRTModalTypeMraidExpand) {
        [self.delegate inlineAdAdapterWillExpand:self];
    } else {
        [self.delegate inlineAdAdapterWillBeginUserAction:self];
    }
}

- (void)vrtBannerDidPresentModal:(nonnull VRTBanner *)vrtBanner ofType:(VRTModalType)modalType {
    //MoPub does not offer an analog to this event
}

- (void)vrtBannerWillDismissModal:(nonnull VRTBanner *)vrtBanner ofType:(VRTModalType)modalType {
    //MoPub does not offer an analog to this event
}

- (void)vrtBannerDidDismissModal:(VRTBanner *)vrtBanner ofType:(VRTModalType)modalType {
    if (modalType == VRTModalTypeMraidExpand) {
        [self.delegate inlineAdAdapterDidCollapse:self];
    } else {
        [self.delegate inlineAdAdapterDidEndUserAction:self];
    }
}

- (void)vrtBannerAdWillLeaveApplication:(nonnull VRTBanner *)vrtBanner {
    [self.delegate inlineAdAdapterWillLeaveApplication:self];
}

- (nonnull UIViewController *)vrtViewControllerForModalPresentation {
    return [self.delegate inlineAdAdapterViewControllerForPresentingModalView:self];
}

- (void)vrtBannerVideoStarted:(nonnull VRTBanner *)vrtBanner {
    //MoPub does not offer an analog to this event
}

- (void)vrtBannerVideoCompleted:(nonnull VRTBanner *)vrtBanner {
    //MoPub does not offer an analog to this event
}





@end
