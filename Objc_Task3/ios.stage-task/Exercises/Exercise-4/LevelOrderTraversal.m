#import "LevelOrderTraversal.h"

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : NSObject

@property(nonatomic, retain) NSNumber *value;
@property(nonatomic, retain, nullable) TreeNode *leftNode;
@property(nonatomic, retain, nullable) TreeNode *rightNode;

- (instancetype)initWithValue:(NSNumber *)value;
+ (instancetype)treeNodeWithValue:(NSNumber *)value;
+ (instancetype)treeFromPreorder:(NSMutableArray *)preorder;
- (NSArray<NSArray *> *)levelOrderTraversal;
- (void)appendLevelOrderTraversalResultsTo: (NSMutableArray *_Nonnull*_Nonnull)array;

@end

NS_ASSUME_NONNULL_END

@implementation TreeNode

- (instancetype)initWithValue:(NSNumber *)value {
    self = [super init];
    if (self) {
        _value = value;
        _leftNode = nil;
        _rightNode = nil;
    }
    return self;
}

+ (instancetype)treeNodeWithValue:(NSNumber *)value {
    return [[TreeNode alloc] initWithValue:value];
}

// MARK: Deserializing tree from array
+ (instancetype)treeFromPreorder:(NSMutableArray *)preorder {
    if (preorder.count == 0) {
        return nil;
    }
    
    id val = preorder.firstObject;
    [preorder removeObjectAtIndex:0];
    
    if (val == [NSNull null]) {
        return nil;
    }

    TreeNode *node = [[TreeNode alloc] initWithValue:val];
    node.leftNode  = [TreeNode treeFromPreorder:preorder];
    node.rightNode = [TreeNode treeFromPreorder:preorder];
    
    return node;
}

// MARK: Traversing tree to compute level order structure
- (NSArray<NSArray *> *)levelOrderTraversal {
    NSMutableArray<NSMutableArray *> *result = [NSMutableArray new];
    
    [result addObject:[NSMutableArray arrayWithObject:self.value]];
    [self.leftNode  appendLevelOrderTraversalResultsTo:&result];
    [self.rightNode appendLevelOrderTraversalResultsTo:&result];
    
    return result;
}

- (void)appendLevelOrderTraversalResultsTo:(NSMutableArray **)array {
    NSMutableArray *result = *array;
    
    NSArray<NSArray *> *rightNodeResult = [self levelOrderTraversal];
    for (int i = 0; i < rightNodeResult.count; ++i) {
        if (i + 1 < result.count) {
            [result[i + 1] addObjectsFromArray:rightNodeResult[i]];
        } else {
            [result addObject:[NSMutableArray arrayWithArray:rightNodeResult[i]]];
        }
    }
}



@end

NSArray *LevelOrderTraversalForTree(NSArray *tree) {
    if (!tree || tree.count == 0 || ![[tree firstObject] isKindOfClass:NSNumber.class]) {
        return @[];
    }
    TreeNode *builtTree = [TreeNode treeFromPreorder:[tree mutableCopy]];
    return [builtTree levelOrderTraversal];
}
