#import "VRTMPBannerCustomEvent.h"

@implementation VRTMPBannerCustomEvent

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info adMarkup:(NSString *)adMarkup {
    [self requestAdWithSize:size customEventInfo:info];
}

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
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

#pragma mark - VRTBannerDelegate
- (void)vrtBannerAdClicked:(nonnull VRTBanner *)vrtBanner {
    [self.delegate bannerCustomEventWillBeginAction:self];
}

- (void)vrtBannerAdFailedToLoad:(nonnull VRTBanner *)vrtBanner error:(nonnull NSError *)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (void)vrtBannerAdLoaded:(nonnull VRTBanner *)vrtBanner {
    [self.delegate bannerCustomEvent:self didLoadAd:self.vrtBanner];
}

- (nonnull UIViewController *)vrtViewControllerForModalPresentation {
    return self.delegate.viewControllerForPresentingModalView;
}

@end
