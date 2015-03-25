//
//  ADVSInterstitialViewController.m
//  DemoApp
//
//  Created by M.T.Burn on 2014/10/17.
//  Copyright (c) 2014年 MTBurn. All rights reserved.
//

#import "ADVSInterstitialViewController.h"
#import <AppDavis/ADVSInterstitialAdLoader.h>

@interface ADVSInterstitialViewController () <ADVSInterstitialAdLoaderDelegate>
@end

@implementation ADVSInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ADVSInterstitialAdLoader sharedInstance].delegate = self;
    [[ADVSInterstitialAdLoader sharedInstance] loadRequest];
}

#pragma mark - ADVSInterstitialAdLoaderDelegate

- (void)interstitialAdLoaderDidStartLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidStartLoadingAd");
}

- (void)interstitialAdLoaderDidFinishLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidFinishLoadingAd");
}

- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidFinishLoadingAdView");
    
    [[ADVSInterstitialAdLoader sharedInstance] displayAd];
}

- (void)interstitialAdLoaderDidSkipLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidSkipLoadingAd");
}

- (void)interstitialAdLoaderDidClickIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    NSLog(@"interstitialAdLoaderDidClickIntersititialAdView:");
}

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdWithError:(NSError *)error
{
    NSLog(@"interstitialAdLoader:didFailToLoadAdWithError:%@", error);
}

- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdViewWithError:(NSError *)error
{
    NSLog(@"interstitialAdLoader:didFailToLoadAdViewWithError:%@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
