//
//  Config.m
//  CDVBackgroundGeolocation
//
//  Created by Marian Hello on 11/06/16.
//

#import <Foundation/Foundation.h>
#import "Config.h"

#define isNull(value) value == nil || [value isKindOfClass:[NSNull class]]

@implementation Config

@synthesize stationaryRadius, distanceFilter, desiredAccuracy, isDebugging, activityType, stopOnTerminate, url, syncUrl, syncThreshold, httpHeaders, saveBatteryOnBackground, maxLocations, pauseLocationUpdates, locationProvider;

-(id) init {
    self = [super init];

    if (self == nil) {
        return self;
    }

    stationaryRadius = 50;
    distanceFilter = 500;
    desiredAccuracy = 100;
    isDebugging = NO;
    activityType = @"OTHER";
    stopOnTerminate = NO;
    saveBatteryOnBackground = YES;
    maxLocations = 10000;
    syncThreshold = 100;
    pauseLocationUpdates = YES;
    locationProvider = DISTANCE_FILTER_PROVIDER;

    return self;
}

+(instancetype) fromDictionary:(NSDictionary*)config
{
    Config *instance = [[Config alloc] init];

    if (config[@"stationaryRadius"]) {
        instance.stationaryRadius = [config[@"stationaryRadius"] integerValue];
    }
    if (config[@"distanceFilter"]) {
        instance.distanceFilter = [config[@"distanceFilter"] integerValue];
    }
    if (config[@"desiredAccuracy"]) {
        instance.desiredAccuracy = [config[@"desiredAccuracy"] integerValue];
    }
    if (config[@"debug"]) {
        instance.isDebugging = [config[@"debug"] boolValue];
    }
    if (config[@"activityType"]) {
        instance.activityType = config[@"activityType"];
    }
    if (config[@"stopOnTerminate"]) {
        instance.stopOnTerminate = [config[@"stopOnTerminate"] boolValue];
    }
    if (isNull(config[@"url"]) == NO) {
        instance.url = config[@"url"];
    }
    if (isNull(config[@"syncUrl"]) == NO) {
        instance.syncUrl = config[@"syncUrl"];
    } else if (isNull(config[@"url"]) == NO) {
        instance.syncUrl = config[@"url"];
    }
    if (config[@"syncThreshold"]) {
        instance.syncThreshold = [config[@"syncThreshold"] integerValue];
    }
    if (config[@"httpHeaders"]) {
        instance.httpHeaders = config[@"httpHeaders"];
    }
    if (config[@"saveBatteryOnBackground"]) {
        instance.saveBatteryOnBackground = [config[@"saveBatteryOnBackground"] boolValue];
    }
    if (config[@"maxLocations"]) {
        instance.maxLocations = [config[@"maxLocations"] integerValue];
    }
    if (config[@"pauseLocationUpdates"]) {
        instance.pauseLocationUpdates = [config[@"pauseLocationUpdates"] boolValue];
    }
    if (config[@"locationProvider"]) {
        instance.locationProvider = [config[@"locationProvider"] integerValue];
    }

    return instance;
}

- (BOOL) hasUrl
{
    return (url != nil && url.length > 0);
}

- (BOOL) hasSyncUrl
{
    return (syncUrl != nil && syncUrl.length > 0);
}

- (CLActivityType) decodeActivityType
{
    if ([activityType caseInsensitiveCompare:@"AutomotiveNavigation"]) {
        return CLActivityTypeAutomotiveNavigation;
    }
    if ([activityType caseInsensitiveCompare:@"OtherNavigation"]) {
        return CLActivityTypeOtherNavigation;
    }
    if ([activityType caseInsensitiveCompare:@"Fitness"]) {
        return CLActivityTypeFitness;
    }

    return CLActivityTypeOther;
}

- (NSInteger) decodeDesiredAccuracy
{
    if (desiredAccuracy >= 1000) {
        return kCLLocationAccuracyKilometer;
    }
    if (desiredAccuracy >= 100) {
        return kCLLocationAccuracyHundredMeters;
    }
    if (desiredAccuracy >= 10) {
        return kCLLocationAccuracyNearestTenMeters;
    }
    if (desiredAccuracy >= 0) {
        return kCLLocationAccuracyBest;
    }

    return kCLLocationAccuracyHundredMeters;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"Config: distanceFilter=%ld stationaryRadius=%ld desiredAccuracy=%ld activityType=%@ isDebugging=%d stopOnTerminate=%d url=%@ httpHeaders=%@ pauseLocationUpdates=%d", (long)distanceFilter, (long)stationaryRadius, (long)desiredAccuracy, activityType, isDebugging, stopOnTerminate, url, httpHeaders, pauseLocationUpdates];
}


@end
