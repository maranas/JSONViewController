//
//  JSONFileActionPayload.m
//  JSONViewExample
//
//  Created by Moises Anthony Aranas on 7/29/18.
//

#import "JSONFileActionPayload.h"
@interface JSONFileActionPayload ()
    @property (nonatomic) NSString *filename;
@end

@implementation JSONFileActionPayload
- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    if ((self = [super init])) {
        _filename = dictionary[@"filename"];
    }
    return self;
}
    
- (NSDictionary*) jsonDictionary {
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:self.filename ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:pathToFile];
    
    NSError *error = nil;
    NSDictionary *parsedJSON =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:0
                                      error:&error];
    return parsedJSON;
}
@end
