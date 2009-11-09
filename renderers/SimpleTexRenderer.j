@import "../OJGL/GLRenderer.j"

@implementation SimpleTexRenderer : GLRenderer {
	int _texCoordAttributeLocation;
	int _samplerUniformLocation;
}

- (id)initWithContext:(GLContext)context {
	self = [super initWithContext:context vertexShaderFile:@"Resources/shaders/basicTexture.vsh" fragmentShaderFile:@"Resources/shaders/basicTexture.fsh"];
	return self;
}

- (void)onShadersLoaded {
    [super onShadersLoaded];

	// Get attribute locations
	_texCoordAttributeLocation = [_glProgram getAttributeLocation:"a_texCoord"];

	// Set up the texture sampler
	[_glContext setUniformSampler:[_glProgram getUniformLocation:"s_texture"]];

	// Callback
	[super callback]
}

- (void)setTexCoordBufferData:(int)bufferId {
	// Bind the texture coordinates buffer data to the texcoord attribute
	[_glContext bindBufferToAttribute:bufferId attributeLocation:_texCoordAttributeLocation size:2];
}

- (void)setTexture:(int)textureId {
	// Bind the texture
	[_glContext bindTexture:textureId];
}

@end
