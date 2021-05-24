#import "PlayersSeparator.h"

@implementation PlayersSeparator

- (NSInteger)dividePlayersIntoTeams:(NSArray<NSNumber *>*)ratingArray {
    if (!ratingArray || ratingArray.count < 3) {
        return 0;
    }
    
    NSInteger counter = 0;
    for (int i = 0; i < [ratingArray count] - 2; i++) {
        for (int j = i; j < [ratingArray count] - 1; j++) {
            for (int k = j; k < [ratingArray count]; k++) {
                if ((ratingArray[i].doubleValue < ratingArray[j].doubleValue &&
                     ratingArray[j].doubleValue < ratingArray[k].doubleValue) ||
                    (ratingArray[i].doubleValue > ratingArray[j].doubleValue &&
                     ratingArray[j].doubleValue > ratingArray[k].doubleValue)) {
                    counter++;
                }
            }
        }
    }
    return counter;
}

@end
