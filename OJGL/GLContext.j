@import <Foundation/CPObject.j>

@implementation GLContext : CPObject {

	DOMElement _gl;
}

- (id)initWithGL:(DOMElement)gl {
	self = [super init];
	
	if (self) {
		_gl = gl;
	}
	
	return self;
}

- (GLProgram)createProgram {
	
	return [[GLProgram alloc] initWithGL:_gl];
}

- (void)useProgram:(GLProgram)program {
	
	_gl.useProgram([program glProgram]);
}

- (void)prepare:(Array)clearColor clearDepth:(float)clearDepth {

	_gl.clearColor(clearColor[0], clearColor[1], clearColor[2], clearColor[3]);

	// Differences between mozilla and webkit: mozilla api needs updating
	if (_gl.clearDepthf) {
		_gl.clearDepthf(1.0);
	} else {
		_gl.clearDepth(1.0);
	}

	_gl.clear(_gl.COLOR_BUFFER_BIT | _gl.DEPTH_BUFFER_BIT);
	_gl.enable(_gl.DEPTH_TEST);

}

- (void)setFrontFaceWinding:(CPString)winding {

	if (winding == @"CW") {
		_gl.frontFace(_gl.CW);
	
	} else if (winding == @"CCW") {
		_gl.frontFace(_gl.CCW);
	
	} else {
		CPLog.error("GLContext: unrecognised winding for front-facing triangles: " + winding);
		return;
	}
	
}

- (void)enableBackfaceCulling {

	_gl.enable(_gl.CULL_FACE);
	_gl.cullFace(_gl.BACK);
}

- (void)enableTexture {
	_gl.enable(_gl.TEXTURING);
	_gl.enable(_gl.TEXTURE_2D);
}

- (void)clearBuffer {
	_gl.clear(_gl.COLOR_BUFFER_BIT | _gl.DEPTH_BUFFER_BIT);
}

- (void)introspect {
	for (var property in _gl) {
		if (typeof(_gl[property]) != "undefined") {
	//		if (typeof(_gl[property]) == "function") {
				CPLog.info(property)
	//		}
		}
	}
}

- (int)createBufferFromArray:(Array)array {
	// set up buffer to store array
	var bufferIndex = _gl.createBuffer();
	_gl.bindBuffer(_gl.ARRAY_BUFFER, bufferIndex);
	
	// Copy data from local memory
	_gl.bufferData(_gl.ARRAY_BUFFER, new WebGLFloatArray(array), _gl.STATIC_DRAW);
	
	return bufferIndex;
}

- (int)createBufferFromElementArray:(Array)array {
	// set up buffer to store array
	var bufferIndex = _gl.createBuffer();
	_gl.bindBuffer(_gl.ELEMENT_ARRAY_BUFFER, bufferIndex);
	
	// Copy data from local memory
	_gl.bufferData(_gl.ELEMENT_ARRAY_BUFFER, new WebGLUnsignedShortArray(array), _gl.STATIC_DRAW);
	
	return bufferIndex;
}

- (int)createTextureFromImage:(Image)image {
	var textureIndex = _gl.createTexture();
	   
	_gl.bindTexture(_gl.TEXTURE_2D, textureIndex);
	_gl.texImage2D(_gl.TEXTURE_2D, 0, image);
	_gl.texParameteri(_gl.TEXTURE_2D, _gl.TEXTURE_MAG_FILTER, _gl.LINEAR);
	_gl.texParameteri(_gl.TEXTURE_2D, _gl.TEXTURE_MIN_FILTER, _gl.LINEAR_MIPMAP_LINEAR);
	_gl.texParameteri(_gl.TEXTURE_2D, _gl.TEXTURE_WRAP_S, _gl.CLAMP_TO_EDGE);
	_gl.texParameteri(_gl.TEXTURE_2D, _gl.TEXTURE_WRAP_T, _gl.CLAMP_TO_EDGE);
	_gl.generateMipmap(_gl.TEXTURE_2D)
	
	return textureIndex;
}


- (void)bindBufferToAttribute:(int)bufferIndex attributeLocation:(int)attributeLocation size:(int)size {
	// Enable attribute array and bind to buffer data 
	_gl.enableVertexAttribArray(attributeLocation);
	_gl.bindBuffer(_gl.ARRAY_BUFFER, bufferIndex);
	_gl.vertexAttribPointer(attributeLocation, size, _gl.FLOAT, false, 0, 0);
}

- (void)bindElementBuffer:(int)bufferIndex {
	_gl.bindBuffer(_gl.ELEMENT_ARRAY_BUFFER, bufferIndex);
}

- (void)bindTexture:(int)textureIndex {
	//_gl.activeTexture(_gl.TEXTURE0);
	_gl.bindTexture(_gl.TEXTURE_2D, textureIndex);
}

- (void)setUniformMatrix3:(int)uniformIndex matrix:(Matrix4D)matrix {
	_gl.uniformMatrix3fv(uniformIndex, false, matrix.getAs3x3ColumnMajorCanvasFloatArray());
}

- (void)setUniformMatrix4:(int)uniformIndex matrix:(Matrix4D)matrix {
	_gl.uniformMatrix4fv(uniformIndex, false, matrix.getAsColumnMajorCanvasFloatArray());
}

- (void)setUniform1i:(int)uniformIndex value:(int)value {
	_gl.uniform1i(uniformIndex, value);
}

- (void)setUniform1f:(int)uniformIndex value:(float)value {
	_gl.uniform1f(uniformIndex, value);
}

- (void)setUniform3f:(int)uniformIndex values:(Array)values {
	_gl.uniform3f(uniformIndex, values[0], values[1], values[2]);
}

- (void)setUniform4f:(int)uniformIndex values:(Array)values {
	_gl.uniform4f(uniformIndex, values[0], values[1], values[2], values[3]);
}

- (void)setUniformSampler:(int)samplerIndex {
	_gl.uniform1i(samplerIndex, 0);
}


- (void)draw {
	_gl.drawArrays(_gl.TRIANGLES, 0, 3);
}

- (void)drawElements:(int)size {
	_gl.drawElements(_gl.TRIANGLES, size, _gl.UNSIGNED_SHORT, 0);
}

- (void)flush {
	_gl.flush();
}

- (void)reshape:(int)width height:(int)height {
	
	_gl.viewport(0, 0, width, height);
}


@end
