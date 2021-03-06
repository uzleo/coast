// Matching properties
@interface I1 {
}
- (int)getProp2;
- (void)setProp2:(int)value;
@property (readonly) int Prop1;
@property (getter = getProp2, setter = setProp2:) int Prop2;
@end

// Mismatched property
@interface I2
@property (readonly) int Prop1;
@end

// Properties with implementations
@interface I3 {
  int ivar1;
  int ivar2;
  int ivar3;
  int Prop4;
}
@property int Prop1;
@property int Prop2;
@property int Prop3;
@property int Prop4;
@end

@implementation I3
@synthesize Prop2 = ivar2;
@synthesize Prop1 = ivar1;
@synthesize Prop3 = ivar3;
@synthesize Prop4 = Prop4;
@end
