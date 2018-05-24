#import "MSAppExtension.h"
#import "MSCSConstants.h"
#import "MSLocExtension.h"
#import "MSOSExtension.h"
#import "MSTestFrameworks.h"
#import "MSUserExtension.h"

@interface MSCSExtensionsTests : XCTestCase
@property(nonatomic) MSUserExtension *userExt;
@property(nonatomic) NSDictionary *userExtDummyValues;
@property(nonatomic) MSLocExtension *locExt;
@property(nonatomic) NSDictionary *locExtDummyValues;
@property(nonatomic) MSOSExtension *osExt;
@property(nonatomic) NSDictionary *osExtDummyValues;
@property(nonatomic) MSAppExtension *appExt;
@property(nonatomic) NSDictionary *appExtDummyValues;
@end

@implementation MSCSExtensionsTests

- (void)setUp {
  [super setUp];
  self.userExtDummyValues = @{ kMSUserLocale : @"en-us" };
  self.userExt = [self userExtensionWithDummyValues:self.userExtDummyValues];
  self.locExtDummyValues = @{ kMSTimezone : @"-03:00" };
  self.locExt = [self locExtensionWithDummyValues:self.locExtDummyValues];
  self.osExtDummyValues = @{ kMSOSName : @"iOS", kMSOSVer : @"9.0" };
  self.osExt = [self osExtensionWithDummyValues:self.osExtDummyValues];
  self.appExtDummyValues = @{ kMSAppId : @"com.some.bundle.id", kMSAppVer : @"3.4.1", kMSAppLocale : @"en-us" };
  self.appExt = [self appExtensionWithDummyValues:self.appExtDummyValues];
}

#pragma mark - MSUserExtension

- (void)testUserExtJSONSerializingToDictionary {

  // When
  NSMutableDictionary *dict = [self.userExt serializeToDictionary];

  // Then
  XCTAssertNotNil(dict);
  XCTAssertEqualObjects(dict[kMSUserLocale], self.userExtDummyValues[kMSUserLocale]);
}

- (void)testUserExtNSCodingSerializationAndDeserialization {

  // When
  NSData *serializedUserExt = [NSKeyedArchiver archivedDataWithRootObject:self.userExt];
  MSUserExtension *actualUserExt = [NSKeyedUnarchiver unarchiveObjectWithData:serializedUserExt];

  // Then
  XCTAssertNotNil(actualUserExt);
  XCTAssertEqualObjects(self.userExt, actualUserExt);
  XCTAssertTrue([actualUserExt isMemberOfClass:[MSUserExtension class]]);
  XCTAssertEqualObjects(actualUserExt.locale, self.userExtDummyValues[kMSUserLocale]);
}

- (void)testUserExtIsValid {

  // If
  MSUserExtension *userExt = [MSUserExtension new];

  // Then
  XCTAssertFalse([userExt isValid]);

  // If
  userExt.locale = self.userExtDummyValues[kMSUserLocale];

  // Then
  XCTAssertTrue([userExt isValid]);
}

- (void)testUserExtIsEqual {

  // If
  MSUserExtension *anotherUserExt = [MSUserExtension new];

  // Then
  XCTAssertNotEqualObjects(anotherUserExt, self.userExt);

  // If
  anotherUserExt = [self userExtensionWithDummyValues:self.userExtDummyValues];

  // Then
  XCTAssertEqualObjects(anotherUserExt, self.userExt);

  // If
  anotherUserExt.locale = @"fr-fr";

  // Then
  XCTAssertNotEqualObjects(anotherUserExt, self.userExt);
}

#pragma mark - MSLocExtension

- (void)testLocExtJSONSerializingToDictionary {

  // When
  NSMutableDictionary *dict = [self.locExt serializeToDictionary];

  // Then
  XCTAssertNotNil(dict);
  XCTAssertEqualObjects(dict[kMSTimezone], self.locExtDummyValues[kMSTimezone]);
}

- (void)testLocExtNSCodingSerializationAndDeserialization {

  // When
  NSData *serializedlocExt = [NSKeyedArchiver archivedDataWithRootObject:self.locExt];
  MSLocExtension *actualLocExt = [NSKeyedUnarchiver unarchiveObjectWithData:serializedlocExt];

  // Then
  XCTAssertNotNil(actualLocExt);
  XCTAssertEqualObjects(self.locExt, actualLocExt);
  XCTAssertTrue([actualLocExt isMemberOfClass:[MSLocExtension class]]);
  XCTAssertEqualObjects(actualLocExt.timezone, self.locExtDummyValues[kMSTimezone]);
}

- (void)testLocExtIsValid {

  // If
  MSLocExtension *locExt = [MSLocExtension new];

  // Then
  XCTAssertFalse([locExt isValid]);

  // If
  locExt.timezone = self.locExtDummyValues[kMSTimezone];

  // Then
  XCTAssertTrue([locExt isValid]);
}

- (void)testLocExtIsEqual {

  // If
  MSLocExtension *anotherLocExt = [MSLocExtension new];

  // Then
  XCTAssertNotEqualObjects(anotherLocExt, self.locExt);

  // If
  anotherLocExt = [self locExtensionWithDummyValues:self.locExtDummyValues];

  // Then
  XCTAssertEqualObjects(anotherLocExt, self.locExt);

  // If
  anotherLocExt.timezone = @"+02:00";

  // Then
  XCTAssertNotEqualObjects(anotherLocExt, self.locExt);
}

#pragma mark - MSOSExtension

- (void)testOSExtJSONSerializingToDictionary {

  // When
  NSMutableDictionary *dict = [self.osExt serializeToDictionary];

  // Then
  XCTAssertNotNil(dict);
  XCTAssertEqualObjects(dict, self.osExtDummyValues);
}

- (void)testOSExtNSCodingSerializationAndDeserialization {

  // When
  NSData *serializedOSExt = [NSKeyedArchiver archivedDataWithRootObject:self.osExt];
  MSOSExtension *actualOSExt = [NSKeyedUnarchiver unarchiveObjectWithData:serializedOSExt];

  // Then
  XCTAssertNotNil(actualOSExt);
  XCTAssertEqualObjects(self.osExt, actualOSExt);
  XCTAssertTrue([actualOSExt isMemberOfClass:[MSOSExtension class]]);
  XCTAssertEqualObjects(actualOSExt.name, self.osExtDummyValues[kMSOSName]);
  XCTAssertEqualObjects(actualOSExt.ver, self.osExtDummyValues[kMSOSVer]);
}

- (void)testOSExtIsValid {

  // If
  MSOSExtension *osExt = [MSOSExtension new];

  // Then
  XCTAssertFalse([osExt isValid]);

  // If
  osExt.name = self.osExtDummyValues[kMSOSName];

  // Then
  XCTAssertFalse([osExt isValid]);

  // If
  osExt.ver = self.osExtDummyValues[kMSOSVer];

  // Then
  XCTAssertTrue([osExt isValid]);
}

- (void)testOSExtIsEqual {

  // If
  MSOSExtension *anotherOSExt = [MSOSExtension new];

  // Then
  XCTAssertNotEqualObjects(anotherOSExt, self.osExt);

  // If
  anotherOSExt = [self osExtensionWithDummyValues:self.osExtDummyValues];

  // Then
  XCTAssertEqualObjects(anotherOSExt, self.osExt);

  // If
  anotherOSExt.name = @"macOS";

  // Then
  XCTAssertNotEqualObjects(anotherOSExt, self.osExt);

  // If
  anotherOSExt.name = self.osExtDummyValues[kMSOSName];
  anotherOSExt.ver = @"10.13.4";

  // Then
  XCTAssertNotEqualObjects(anotherOSExt, self.osExt);
}

#pragma mark - MSAppExtension

- (void)testAppExtJSONSerializingToDictionary {

  // When
  NSMutableDictionary *dict = [self.appExt serializeToDictionary];

  // Then
  XCTAssertNotNil(dict);
  XCTAssertEqualObjects(dict, self.appExtDummyValues);
}

- (void)testAppExtNSCodingSerializationAndDeserialization {

  // When
  NSData *serializedAppExt = [NSKeyedArchiver archivedDataWithRootObject:self.appExt];
  MSAppExtension *actualAppExt = [NSKeyedUnarchiver unarchiveObjectWithData:serializedAppExt];

  // Then
  XCTAssertNotNil(actualAppExt);
  XCTAssertEqualObjects(self.appExt, actualAppExt);
  XCTAssertTrue([actualAppExt isMemberOfClass:[MSAppExtension class]]);
  XCTAssertEqualObjects(actualAppExt.appId, self.appExtDummyValues[kMSAppId]);
  XCTAssertEqualObjects(actualAppExt.ver, self.appExtDummyValues[kMSAppVer]);
  XCTAssertEqualObjects(actualAppExt.locale, self.appExtDummyValues[kMSAppLocale]);
}

- (void)testAppExtIsValid {

  // If
  MSAppExtension *appExt = [MSAppExtension new];

  // Then
  XCTAssertFalse([appExt isValid]);

  // If
  appExt.appId = self.appExtDummyValues[kMSAppId];

  // Then
  XCTAssertFalse([appExt isValid]);

  // If
  appExt.ver = self.appExtDummyValues[kMSAppVer];

  // Then
  XCTAssertFalse([appExt isValid]);

  // If
  appExt.locale = self.appExtDummyValues[kMSAppLocale];

  // Then
  XCTAssertTrue([appExt isValid]);
}

- (void)testAppExtIsEqual {

  // If
  MSAppExtension *anotherAppExt = [MSAppExtension new];

  // Then
  XCTAssertNotEqualObjects(anotherAppExt, self.appExt);

  // If
  anotherAppExt = [self appExtensionWithDummyValues:self.appExtDummyValues];

  // Then
  XCTAssertEqualObjects(anotherAppExt, self.appExt);

  // If
  anotherAppExt.appId = @"com.another.bundle.id";

  // Then
  XCTAssertNotEqualObjects(anotherAppExt, self.appExt);

  // If
  anotherAppExt.appId = self.appExtDummyValues[kMSAppId];
  anotherAppExt.ver = @"10.13.4";

  // Then
  XCTAssertNotEqualObjects(anotherAppExt, self.appExt);

  // If
  anotherAppExt.ver = self.appExtDummyValues[kMSAppVer];
  anotherAppExt.locale = @"fr-ca";

  // Then
  XCTAssertNotEqualObjects(anotherAppExt, self.appExt);
}

#pragma mark - Helper

- (MSUserExtension *)userExtensionWithDummyValues:(NSDictionary *)dummyValues {
  MSUserExtension *userExt = [MSUserExtension new];
  userExt.locale = dummyValues[kMSUserLocale];
  return userExt;
}

- (MSLocExtension *)locExtensionWithDummyValues:(NSDictionary *)dummyValues {
  MSLocExtension *locExt = [MSLocExtension new];
  locExt.timezone = dummyValues[kMSTimezone];
  return locExt;
}

- (MSOSExtension *)osExtensionWithDummyValues:(NSDictionary *)dummyValues {
  MSOSExtension *osExt = [MSOSExtension new];
  osExt.name = dummyValues[kMSOSName];
  osExt.ver = dummyValues[kMSOSVer];
  return osExt;
}

- (MSAppExtension *)appExtensionWithDummyValues:(NSDictionary *)dummyValues {
  MSAppExtension *appExt = [MSAppExtension new];
  appExt.appId = dummyValues[kMSAppId];
  appExt.ver = dummyValues[kMSAppVer];
  appExt.locale = dummyValues[kMSAppLocale];
  return appExt;
}
@end
