#import "LexicographicallyMinimal.h"

@interface LexicographicallyMinimal()

@property (nonatomic, strong) NSMutableString *resultString;

@end

@implementation LexicographicallyMinimal

-(NSString *)findLexicographicallyMinimalForString1:(NSString *)string1 andString2:(NSString *)string2 {
    NSMutableString *String1 = [NSMutableString stringWithString:string1];
    NSMutableString *String2 = [NSMutableString stringWithString:string2];
    NSMutableString *result = [NSMutableString new];
    
    while(String1.length != 0 || String2.length != 0) {
        if (String1.length == 0) {
            [result appendString:String2];
            break;
        } else if (String2.length == 0) {
            [result appendString:String1];
            break;
        }
        if ([[String1 substringToIndex:1] UTF8String][0] <= [[String2 substringToIndex:1] UTF8String][0]) {
            [result appendString: [String1 substringToIndex:1]];
            String1 = [[String1 substringFromIndex:1] mutableCopy];
        } else {
            [result appendString: [String2 substringToIndex:1]];
            String2 = [[String2 substringFromIndex:1] mutableCopy];
        }
    }
    return [result copy];
}

@end
