UIImage-Filter
==============

A Category in Objective-C to make filtering UIImages easy. This category includes 8 different Filter Types with preset parameters. 

Instructions:
Drag UIImage+Filters.h and UIImage+Filters.m from the ImageFilter repo folder your project, and import UIImage+Filters.h in the class you need to use / store the filtered UIImage.

The following snippet of code will add an Exposure Filter to the UIImage named kobe.jpg in the app bundle.

```
    UIImage *filteredImage = [[UIImage imageNamed:@"kobe.jpg"] imageWithFilter:UIImageFilterTypeExposure];

``` 
Note the filtering process can be expensive and may take significant CPU Time (especially with larger photos), so its not recommended to do call the imageWithFilter: selector on the main thread (see demo for multithreaded example).


The 8 UIImageFilterType's are:
```
typedef enum {
    UIImageFilterTypeSepia,
    UIImageFilterTypeVignette,
    UIImageFilterTypeTemperature,
    UIImageFilterTypeColorInvert,
    UIImageFilterTypeHue,
    UIImageFilterTypeExposure,
    UIImageFilterTypeHighlightShadow,
    UIImageFilterTypeColorControl

} UIImageFilterType;
```