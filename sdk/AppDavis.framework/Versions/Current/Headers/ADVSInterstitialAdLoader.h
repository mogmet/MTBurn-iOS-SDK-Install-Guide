//
//  ADVSInterstitialAdLoader.h
//  AppDavis-iOS-SDK
//
//  Created by Yohei Yoshimuta on 2014/03/19.
//  Copyright (c) 2014年 M.T.Burn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADVSInterstitialAdLoaderDelegate.h"

@interface ADVSInterstitialAdLoader : NSObject

@property (nonatomic, weak) id<ADVSInterstitialAdLoaderDelegate> delegate;

/**
 Loads a institial type advertisement request asynchronously.
 
 @see ADVSInterstitialAdLoaderDelegate.h
 */

- (void)loadRequest;

/**
 Display a institial type advertisement instantly.
 
 @see ADVSInterstitialAdLoaderDelegate.h
 */

- (void)displayAd;

@end
