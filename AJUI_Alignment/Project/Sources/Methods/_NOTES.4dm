//%attributes = {}

// ====================================================================================
// W3C Quotes
// ====================================================================================  

// 6. FLEX LINES
// Once content is broken into lines, each line is laid out independently;
// flexible lengths and the justify-content and align-self properties only consider the items on a single line at a time.

// In a multi-line flex container (even one with only a single line), the cross size of each line is the minimum size necessary to 
// contain the flex items on the line(after alignment due to align-Self), and the lines are aligned within the flex container with the
// align-content property.In a single-line flex container, the cross size of the line is the cross size of the flex co-content
// has no effect. The main size of a line is always the same as the main size of the flex container’s content box.


// ====================================================================================
// AJUI_Flexbox Comments
// ====================================================================================
// The growing/shrinking of the elements in a single line (nowrap) flexbox, will be defined by the min/max values defined for an item
// If min/max are not set, the element will not grow/shrink
// If only max is set, it will grow, but not shrink
// If only min is set it will shrink but not grow

// NOT TRUE -->
// When the wrap is set, the wrap is done according to the defined size and not minimum size
// That mean when we wrap element, items will grow up to maximum size but will shrink until the size and not minimum size

// TRUE -->
// The wrap do not care of grow/shrink and max/min witdht/height. It only wrap using the width/height values