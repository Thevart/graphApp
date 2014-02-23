//
//  Color.h
//  ver
//
//  Created by Kévin Gomez on 23/02/14.
//
//

#import <Foundation/Foundation.h>

@interface Color : NSObject


+ (Color *) initFromHexString: (NSString *) string;
+ (Color *) initFromRGB: (int) r g:(int) g b:(int) b;

- (id) initWithValue: (int) hexValue;
- (void) setHexValue: (int) hexValue;

- (int) asHexValue;

- (float) r;
- (float) g;
- (float) b;

@end
