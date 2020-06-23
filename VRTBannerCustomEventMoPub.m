//
//  VRTBannerCustomEventMoPub.m
//
//  Created by Scott McCoy on 5/9/19.
//  Copyright © 2019 VRTCAL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRTBannerCustomEventMoPub.h"

#import "MPAdView.h"

@interface VRTBannerCustomEventMoPub() <MPAdViewDelegate>
@property MPAdView *mpAdView;
@end

//MoPub Banner Adapter, Vrtcal as Primary
@implementation VRTBannerCustomEventMoPub

- (void) loadBannerAd {
    NSString *moPubAdUnitId = [self.customEventConfig.thirdPartyCustomEventData objectForKey:@"adUnitId"];
    self.mpAdView = [[MPAdView alloc] initWithAdUnitId:moPubAdUnitId];
    self.mpAdView.delegate = self;
    [self.mpAdView loadAd];
}

- (UIView*) getView {
    return self.mpAdView;
}

#pragma mark - MPAdViewDelegate

/**
 * Asks the delegate for a view controller to use for presenting modal content, such as the in-app
 * browser that can appear when an ad is tapped.
 *
 * @return A view controller that should be used for presenting modal content.
 */
- (UIViewController *)viewControllerForPresentingModalView {
    UIViewController *vc = [self.viewControllerDelegate vrtViewControllerForModalPresentation];
    return vc;
}

/**
 * Sent when an ad view successfully loads an ad.
 *
 * Your implementation of this method should insert the ad view into the view hierarchy, if you
 * have not already done so.
 *
 * @param view The ad view sending the message.
 */
-(void)adViewDidLoadAd:(MPAdView *)view adSize:(CGSize)adSize {
    VRTLogWhereAmI();
    [self.customEventLoadDelegate customEventLoaded];
}


/**
 * Sent when an ad view fails to load an ad.
 *
 * To avoid displaying blank ads, you should hide the ad view in response to this message.
 *
 * @param view The ad view sending the message.
 * @param error The error
 */
- (void)adView:(MPAdView *)view didFailToLoadAdWithError:(NSError *)error {
    VRTLogWhereAmI();
    [self.customEventLoadDelegate customEventFailedToLoadWithError:error];
}

/**
 * Sent when an ad view is about to present modal content.
 *
 * This method is called when the user taps on the ad view. Your implementation of this method
 * should pause any application activity that requires user interaction.
 *
 * @param view The ad view sending the message.
 * @see `didDismissModalViewForAd:`
 */
- (void)willPresentModalViewForAd:(MPAdView *)view {
    [self.customEventShowDelegate customEventClicked];
}

/**
 * Sent when an ad view has dismissed its modal content, returning control to your application.
 *
 * Your implementation of this method should resume any application activity that was paused
 * in response to `willPresentModalViewForAd:`.
 *
 * @param view The ad view sending the message.
 * @see `willPresentModalViewForAd:`
 */
- (void)didDismissModalViewForAd:(MPAdView *)view {
    VRTLogWhereAmI();
}

/**
 * Sent when a user is about to leave your application as a result of tapping
 * on an ad.
 *
 * Your application will be moved to the background shortly after this method is called.
 *
 * @param view The ad view sending the message.
 */
- (void)willLeaveApplicationFromAd:(MPAdView *)view {
    VRTLogWhereAmI();
}


@end
