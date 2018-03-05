# CustomPopOver
This is a simple popver which is custom built and free to use

# Installation
```
git clone https://github.com/kranthisamala/CustomPopOver.git

Import files from popover folder into your project
	- Drag and drop files into your project
	- Add reference
```
# Usage
```
Import CPSelectionObject.h, CustomPopOver.h 

Create a object of CPSelectionObject initiate it with uiview which need to be selected

	- (CPSelectionObject*)initWithView:(UIView*)view message:(NSString*)msg;
	
Create a object of CustomPopOver using 

	- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor*)color andTransparentRects:(NSArray*)rects;
	
Add CustomPopOver object to present UIView
  
