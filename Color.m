//
//  Color.m
//  ver
//
//  Created by Kévin Gomez on 23/02/14.
//
//

#import "Color.h"

@implementation Color

int hexColor;

- (id) init
{
    if (self = [super init]) {
        [self setHexValue:0];
    }

    return self;
}

- (id) initWithValue: (int) hexValue
{
    if (self = [self init]) {
        [self setHexValue:hexValue];
    }

    return self;
}

+ (Color *) initFromHexString: (NSString *) string
{
    unsigned int value;
    NSScanner* scanner = [NSScanner scannerWithString:string];
    [scanner scanHexInt:&value];

    //NSLog(@"        HEX %@", string);

    return [[Color alloc] initWithValue:value];
}

+ (Color *) initFromRGB: (int) r g:(int) g b:(int) b
{
    NSString* hexString = [NSString stringWithFormat:@"%02x%02x%02x", r, g, b];

   // NSLog(@"R = %d, G = %d, B = %d", r, g, b);

    return [Color initFromHexString:hexString];
}


- (int) asHexValue
{
    return hexColor;
}


- (void) setHexValue: (int) hexValue
{
    hexColor = hexValue;
}

- (float) r
{
    return (hexColor & 0xFF) / 255.0;
}

- (float) g
{
    return ((hexColor >> 8) & 0xFF) / 255.0;
}

- (float) b
{
    return ((hexColor >> 16) & 0xFF) / 255.0;
}

@end
