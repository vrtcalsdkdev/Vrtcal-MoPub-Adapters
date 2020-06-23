#import "VRTMPBannerCustomEvent.h"

//MoPub Banner Adapter, Vrtcal as Secondary
@implementation VRTMPBannerCustomEvent


- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    [self requestAdWithSize:size customEventInfo:info adMarkup:nil];
}

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    NSString *strZoneId = info[@"zid"];
    int zoneId = [strZoneId intValue];

    if (zoneId <= 0) {
        NSError *error = [VRTError errorWithCode:VRTErrorCodeInvalidParam format:@"Unusable zoneId of %i. Vrtcal ads require an Zone ID (unsigned int) to serve ads", zoneId];
        [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
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
    [self.delegate bannerCustomEvent:self didLoadAd:self.vrtBanner];
}

- (void)vrtBannerAdFailedToLoad:(nonnull VRTBanner *)vrtBanner error:(nonnull NSError *)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)vrtBannerAdClicked:(nonnull VRTBanner *)vrtBanner {
    //MoPub offers trackClick, but we have decided to let them handle click tracking.
}

- (void)vrtBannerWillPresentModal:(nonnull VRTBanner *)vrtBanner ofType:(VRTModalType)modalType {
    if (modalType == VRTModalTypeMraidExpand) {
        [self.delegate bannerCustomEventWillExpandAd:self];
    } else {
        [self.delegate bannerCustomEventWillBeginAction:self];
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
        [self.delegate bannerCustomEventDidCollapseAd:self];
    } else {
        [self.delegate bannerCustomEventDidFinishAction:self];
    }
}

- (void)vrtBannerAdWillLeaveApplication:(nonnull VRTBanner *)vrtBanner {
    [self.delegate bannerCustomEventWillLeaveApplication:self];
}

- (nonnull UIViewController *)vrtViewControllerForModalPresentation {
    return self.delegate.viewControllerForPresentingModalView;
}

@end
