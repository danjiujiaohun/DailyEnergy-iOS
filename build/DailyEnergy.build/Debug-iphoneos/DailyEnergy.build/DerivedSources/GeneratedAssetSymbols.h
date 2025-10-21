#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"com.danjiu.DailyEnergy";

/// The "color_000000" asset catalog color resource.
static NSString * const ACColorNameColor000000 AC_SWIFT_PRIVATE = @"color_000000";

/// The "color_24292B" asset catalog color resource.
static NSString * const ACColorNameColor24292B AC_SWIFT_PRIVATE = @"color_24292B";

/// The "color_9DA2A5" asset catalog color resource.
static NSString * const ACColorNameColor9DA2A5 AC_SWIFT_PRIVATE = @"color_9DA2A5";

/// The "color_FF453A" asset catalog color resource.
static NSString * const ACColorNameColorFF453A AC_SWIFT_PRIVATE = @"color_FF453A";

/// The "color_FFFFFF" asset catalog color resource.
static NSString * const ACColorNameColorFFFFFF AC_SWIFT_PRIVATE = @"color_FFFFFF";

/// The "image_avatar_default" asset catalog image resource.
static NSString * const ACImageNameImageAvatarDefault AC_SWIFT_PRIVATE = @"image_avatar_default";

/// The "image_back_icon" asset catalog image resource.
static NSString * const ACImageNameImageBackIcon AC_SWIFT_PRIVATE = @"image_back_icon";

/// The "image_close_btn" asset catalog image resource.
static NSString * const ACImageNameImageCloseBtn AC_SWIFT_PRIVATE = @"image_close_btn";

#undef AC_SWIFT_PRIVATE
