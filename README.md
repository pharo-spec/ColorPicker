# Description

Provides a powerful and intuitive color picker tool designed for Pharo. It seamlessly integrates with the Spec widget library and leverages the capabilities of the 
Roassal graphics library to provide a comprehensive solution for color selection in your Pharo applications. 

<p align="center">
<img src="https://github.com/pharo-spec/ColorPicker/assets/4825959/d9f3ea7c-e184-429e-a8ab-603d7a63dfd3">
</p>

It includes:

- A color map: A two-dimensional rectangle mapping saturation and ligntness to the dimensions.
-	A hue slider: An horizontal strip mapping the hue to one dimension.
- A color presenter: Presents the color as rgb value and hexadecimal. Also represents to color on a small rectangle for a better perception of the choosed color.
- Color palettes: Present color palettes of Roassal.

## Usage

Integrating ColorPicker into your Pharo projects is straightforward. The library comes with class documentation and examples to ensuring a smooth integration.

```smalltalk
CPColorPicker open.
```

# Install

```smalltalk
Metacello new
  baseline: 'ColorPicker';
  repository: 'github://pharo-spec/ColorPicker/src';
  load.
```

## Baseline String 

If you want to add the ColorPicker to your Metacello Baselines or Configurations, copy and paste the following expression:

```smalltalk
        " ... "
        spec
                baseline: 'ColorPicker' 
                with: [ spec repository: 'github://pharo-spec/ColorPicker/src' ];
        " ... "
```

# License

This software is licensed under the MIT License.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation 
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, 
publish, distribute, sublicense, and/or sell copies of the Software, and  to permit persons to whom the Software is furnished to do so, subject 
to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Authors

Soufyane Labsari

# Contributors

Hernán Morales Durand




