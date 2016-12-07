//
//  ADResultAdapter.h
//  ADResultAdapter
//
//  Created by YUYA SAKAI on 2014/02/17.
//  Copyright (c) 2014 GMO AD Partners Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADMAdNetworkAdapterProtocol.h"
#import "GADMAdNetworkConnectorProtocol.h"

#import "GSAAdView.h"

@interface ADResultAdapter : NSObject <GADMAdNetworkAdapter, GSAAdViewDelegate>

@property (nonatomic, weak) id<GADMAdNetworkConnector> connector;
@property (nonatomic) GSAAdView *adView;

@end

#ifdef ADRESULTSDK_DEVELOP
#define DLOG NSLog
#else
#define DLOG(msg, ...) (void)0
#endif

#ifdef ADRESULTSDK_DEBUG
#define TLOG NSLog
#else
#define TLOG(msg, ...) (void)0
#endif
