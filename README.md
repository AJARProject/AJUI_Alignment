# AJUI_Alignment

This is a 4D Component to help aligning form objects in a 4D application.

It is still in devlopment so feel free to test and participate to it.

You can find, in the `4D_Flex_alignment_PROTO.json` file, the definition structure that will tell how the container and its items will behave.

Not everything is yet implemented :
| Feature | Implemented |
| - | :-: |
| display | ❌ |
| alignContent | ❌ |
| alignItems | ❌ |
| direction | ✅ |
| wrap | ✅ |
| justifyContent | ✅ |
| padding | ✅ |
| margin | ✅ |
| marginRight | ✅ |
| marginTop | ✅ |
| marginLeft | ✅ |
| marginBottom | ✅ |
| height | ✅ |
| width | ✅ |
| minHeight | ✅ |
| minWidth | ✅ |
| maxHeight | ✅ |
| maxWidth | ✅ |
| items (recursive) | ✅ |

The purpose was to provide something similar to what we have with CSS flexbox. But more I tried to implement the same more it became complicated. That is why I started up from scratch and went down to `justifyContent` and stopped (because of lack of time also). Maybe we should not try to have something too much complicated and what we have today is enough.

The code is not too much factorized because it will slow down a lot the execution cycle (tried during the devlopment phase). The purpose is to execute the alignment during the `On Resize` event so it must be really fast not to make the resizing be laggy. Maybe it is even possible to speed up the execution by doing some optimization (`for` instead of `for each`?)

## Tests

You can do some tests with the `flexboxFormTest` by launching the `launch_flexboxFormTest` method.
The description of the items are in the `Resources/test1.json` file.
