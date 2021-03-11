//
//  VRTInterstitialCustomEventMoPub.m
//
//  Created by Scott McCoy on 5/9/19.
//  Copyright © 2019 VRTCAL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRTInterstitialCustomEventMoPub.h"

#import "MPInterstitialAdController.h"

//MoPub Interstitial Adapter, Vrtcal as Primary
@interface VRTInterstitialCustomEventMoPub() <MPInterstitialAdControllerDelegate>
@property MPInterstitialAdController *mpIntersatitialAdController;
@end


@implementation VRTInterstitialCustomEventMoPub

- (void) loadInterstitialAd {
    NSString *moPubAdUnitId = [self.customEventConfig.thirdPartyCustomEventData objectForKey:@"adUnitId"];
    self.mpIntersatitialAdController = [MPInterstitialAdController interstitialAdControllerForAdUnitId:moPubAdUnitId];
    self.mpIntersatitialAdController.delegate = self;
    [self.mpIntersatitialAdController loadAd];
}

- (void) showInterstitialAd {
    UIViewController *vc = [self.viewControllerDelegate vrtViewControllerForModalPresentation];
    [self.mpIntersatitialAdController showFromViewController:vc];
}

#pragma mark - MPAdViewDelegate
- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    VRTLogWhereAmI();
    [self.customEventLoadDelegate customEventLoaded];
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial withError:(NSError *)error {
    VRTLogWhereAmI();
    [self.customEventLoadDelegate customEventFailedToLoadWithError:error];
}

- (void)interstitialWillAppear:(MPInterstitialAdController *)interstitial {
    VRTLogWhereAmI();
    [self.customEventShowDelegate customEventWillPresentModal:VRTModalTypeInterstitial];
}

- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial {
    VRTLogWhereAmI();
    [self.customEventShowDelegate customEventShown];
}

- (void)interstitialWillDisappear:(MPInterstitialAdController *)interstitial {
    VRTLogWhereAmI();
    [self.customEventShowDelegate customEventWillDismissModal:VRTModalTypeInterstitial];
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    VRTLogWhereAmI();
    [self.customEventShowDelegate customEventDidDismissModal:VRTModalTypeInterstitial];
}

- (void)interstitialDidExpire:(MPInterstitialAdController *)interstitial {
    VRTLogWhereAmI();
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial {
    VRTLogWhereAmI();
    [self.customEventShowDelegate customEventClicked];
}


@end
