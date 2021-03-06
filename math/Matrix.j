#include "Matrix.h"

//#define _function(inline) function inline { return _##inline; }

//_function(CGPointMake(x, y))
//_function(CGPointEqualToPoint(lhsPoint, rhsPoint))

//#include "Quaternion.h"
//#include "Vector.h"

/*!
    Returns \c YES if the two rectangles intersect
    @group CGRect
    @param lhsRect the first CGRect
    @param rhsRect the second CGRect
    @return BOOL \c YES if the two rectangles have any common spaces, and \c NO, otherwise.
*/
/*function CGRectIntersectsRect(lhsRect, rhsRect)
{
    var intersection = CGRectIntersection(lhsRect, rhsRect);
    
    return !_CGRectIsEmpty(intersection);
}
*/

function Matrix_loadIdentity(matrix) {
	matrix.m0 = 1.0;
	matrix.m1 = 0.0;
	matrix.m2 = 0.0;
	matrix.m3 = 0.0;
	matrix.m4 = 0.0;
	matrix.m5 = 1.0;
	matrix.m6 = 0.0;
	matrix.m7 = 0.0;
	matrix.m8 = 0.0;
	matrix.m9 = 0.0;
	matrix.m10 = 1.0;
	matrix.m11 = 0.0;
	matrix.m12 = 0.0;
	matrix.m13 = 0.0;
	matrix.m14 = 0.0;
	matrix.m15 = 1.0;
}

function Matrix_identity() {
	var matrix = {};
	
	Matrix_loadIdentity(matrix);
	return matrix;
}

function Matrix_withMatrix(matrix) {
    var result = {};

	result.m0 = matrix.m0;
	result.m1 = matrix.m1;
	result.m2 = matrix.m2;
	result.m3 = matrix.m3;
	result.m4 = matrix.m4;
	result.m5 = matrix.m5;
	result.m6 = matrix.m6;
	result.m7 = matrix.m7;
	result.m8 = matrix.m8;
	result.m9 = matrix.m9;
	result.m10 = matrix.m10;
	result.m11 = matrix.m11;
	result.m12 = matrix.m12;
	result.m13 = matrix.m13;
	result.m14 = matrix.m14;
	result.m15 = matrix.m15;
    return result;
}

function Matrix_withValues( m0,   m4,   m8,   m12,
                            m1,   m5,   m9,   m13,
                            m2,   m6,   m10,  m14,
                            m3,   m7,   m11,  m15) {
	var matrix = {};
	
	matrix.m0  = m0;
	matrix.m1  = m1;
	matrix.m2  = m2;
	matrix.m3  = m3;
	matrix.m4  = m4;
	matrix.m5  = m5;
	matrix.m6  = m6;
	matrix.m7  = m7;
	matrix.m8  = m8;
	matrix.m9  = m9;
	matrix.m10 = m10;
	matrix.m11 = m11;
	matrix.m12 = m12;
	matrix.m13 = m13;
	matrix.m14 = m14;
	matrix.m15 = m15;
	return matrix;
}

function Matrix_fromDirectionVectors( right,  up,  front) {
	var matrix = {};
	
	Matrix_loadIdentity(matrix);
	matrix.m0  = right.x;
	matrix.m1  = right.y;
	matrix.m2  = right.z;
	matrix.m4  = up.x;
	matrix.m5  = up.y;
	matrix.m6  = up.z;
	matrix.m8  = front.x;
	matrix.m9  = front.y;
	matrix.m10 = front.z;
	return matrix;
}

function Matrix_multiply( matrix1, m2) {
	var m1 = Matrix_withMatrix(matrix1);
	
	matrix1.m0  = m1.m0 * m2.m0  + m1.m4 * m2.m1  + m1.m8  * m2.m2  + m1.m12 * m2.m3;
	matrix1.m1  = m1.m1 * m2.m0  + m1.m5 * m2.m1  + m1.m9  * m2.m2  + m1.m13 * m2.m3;
	matrix1.m2  = m1.m2 * m2.m0  + m1.m6 * m2.m1  + m1.m10 * m2.m2  + m1.m14 * m2.m3;
	matrix1.m3  = m1.m3 * m2.m0  + m1.m7 * m2.m1  + m1.m11 * m2.m2  + m1.m15 * m2.m3;
	matrix1.m4  = m1.m0 * m2.m4  + m1.m4 * m2.m5  + m1.m8  * m2.m6  + m1.m12 * m2.m7;
	matrix1.m5  = m1.m1 * m2.m4  + m1.m5 * m2.m5  + m1.m9  * m2.m6  + m1.m13 * m2.m7;
	matrix1.m6  = m1.m2 * m2.m4  + m1.m6 * m2.m5  + m1.m10 * m2.m6  + m1.m14 * m2.m7;
	matrix1.m7  = m1.m3 * m2.m4  + m1.m7 * m2.m5  + m1.m11 * m2.m6  + m1.m15 * m2.m7;
	matrix1.m8  = m1.m0 * m2.m8  + m1.m4 * m2.m9  + m1.m8  * m2.m10 + m1.m12 * m2.m11;
	matrix1.m9  = m1.m1 * m2.m8  + m1.m5 * m2.m9  + m1.m9  * m2.m10 + m1.m13 * m2.m11;
	matrix1.m10 = m1.m2 * m2.m8  + m1.m6 * m2.m9  + m1.m10 * m2.m10 + m1.m14 * m2.m11;
	matrix1.m11 = m1.m3 * m2.m8  + m1.m7 * m2.m9  + m1.m11 * m2.m10 + m1.m15 * m2.m11;
	matrix1.m12 = m1.m0 * m2.m12 + m1.m4 * m2.m13 + m1.m8  * m2.m14 + m1.m12 * m2.m15;
	matrix1.m13 = m1.m1 * m2.m12 + m1.m5 * m2.m13 + m1.m9  * m2.m14 + m1.m13 * m2.m15;
	matrix1.m14 = m1.m2 * m2.m12 + m1.m6 * m2.m13 + m1.m10 * m2.m14 + m1.m14 * m2.m15;
	matrix1.m15 = m1.m3 * m2.m12 + m1.m7 * m2.m13 + m1.m11 * m2.m14 + m1.m15 * m2.m15;
}

function Matrix_multiplied( matrix1, matrix2) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_multiply(m1, matrix2);
	return m1;
}

function Matrix_translate( matrix, x, y, z) {
	var translationMatrix = {};
	
	Matrix_loadIdentity(translationMatrix);
	translationMatrix.m12 = x;
	translationMatrix.m13 = y;
	translationMatrix.m14 = z;
	Matrix_multiply(matrix, translationMatrix);
}

function Matrix_translated(matrix,  x,  y,  z) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_translate(m1, x, y, z);
	return m1;
}

function Matrix_scale( matrix,  x,  y,  z) {
	var scalingMatrix = {};

	Matrix_loadIdentity(scalingMatrix);
	scalingMatrix.m0 = x;
	scalingMatrix.m5 = y;
	scalingMatrix.m10 = z;
	Matrix_multiply(matrix, scalingMatrix);
}

function Matrix_scaled( matrix,  x,  y,  z) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_scale(m1, x, y, z);
	return m1;
}

function Matrix_rotate( matrix,  axis,  angle) {
	var rotationMatrix = {};
	var quaternion = {};
	
//	quaternion = Quaternion_fromAxisAngle(axis, angle);
//	rotationMatrix = Quaternion_toMatrix(quaternion);
//	Matrix_multiply(matrix, rotationMatrix);
}

function Matrix_rotated( matrix,  axis,  angle) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_rotate(m1, axis, angle);
	return m1;
}

function Matrix_shearX( matrix,  y,  z) {
	var shearingMatrix = {};
	
	Matrix_loadIdentity(shearingMatrix);
	shearingMatrix.m1 = y;
	shearingMatrix.m2 = z;
	Matrix_multiply(matrix, shearingMatrix);
}

function Matrix_shearedX( matrix,  y,  z) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_shearX(m1, y, z);
	return m1;
}

function Matrix_shearY( matrix,  x,  z) {
	var shearingMatrix = {};
	
	Matrix_loadIdentity(shearingMatrix);
	shearingMatrix.m4 = x;
	shearingMatrix.m6 = z;
	Matrix_multiply(matrix, shearingMatrix);
}

function Matrix_shearedY( matrix,  x,  z) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_shearY(m1, x, z);
	return m1;
}

function Matrix_shearZ( matrix,  x,  y) {
	var shearingMatrix = {};
	
	Matrix_loadIdentity(shearingMatrix);
	shearingMatrix.m8 = x;
	shearingMatrix.m9 = y;
	Matrix_multiply(matrix, shearingMatrix);
}

function Matrix_shearedZ( matrix,  x,  y) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_shearZ(m1, x, y);
	return m1;
}

function Matrix_applyPerspective( matrix,  fovY,  aspect,  zNear,  zFar) {
	var perspectiveMatrix = {};
	var sine, cotangent, deltaZ;
	
	fovY = (degreesToRadians(fovY) / 2.0);
	deltaZ = (zFar - zNear);
	sine = sin(fovY);
	if (deltaZ == 0.0 || sine == 0.0 || aspect == 0.0) {
		return;
	}
	cotangent = (cos(fovY) / sine);
	
	Matrix_loadIdentity(perspectiveMatrix);
	perspectiveMatrix.m0 = (cotangent / aspect);
	perspectiveMatrix.m5 = cotangent;
	perspectiveMatrix.m10 = (-(zFar + zNear) / deltaZ);
	perspectiveMatrix.m11 = -1.0;
	perspectiveMatrix.m14 = ((-2.0 * zNear * zFar) / deltaZ);
	perspectiveMatrix.m15 = 0.0;
	Matrix_multiply(matrix, perspectiveMatrix);
}

function Matrix_perspective( matrix,  fovY,  aspect,  zNear,  zFar) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_applyPerspective(m1, fovY, aspect, zNear, zFar);
	return m1;
}

function Matrix_transpose( matrix) {
	matrix = Matrix_withValues(matrix.m0,  matrix.m1,  matrix.m2,  matrix.m3,
                               matrix.m4,  matrix.m5,  matrix.m6,  matrix.m7,
                               matrix.m8,  matrix.m9,  matrix.m10, matrix.m11,
                               matrix.m12, matrix.m13, matrix.m14, matrix.m15);
}

function Matrix_transposed( matrix) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_transpose(m1);
	return m1;
}

// declared as static, intended to be private?
// TODO: I don't think this has been converted properly
function Matrix_subdeterminant( matrix, excludeIndex) {
	var index4x4, index3x3;
	var matrix3x3;

	index3x3 = 0;
	for (index4x4 = 0; index4x4 < 16; index4x4++) {
		if (index4x4 / 4 == excludeIndex / 4 ||
		    index4x4 % 4 == excludeIndex % 4) {
			continue;
		}
		matrix3x3[index3x3++] = matrix.mindex4x4;
	}
	
	return matrix3x3[0] * (matrix3x3[4] * matrix3x3[8] - matrix3x3[5] * matrix3x3[7]) -
	       matrix3x3[3] * (matrix3x3[1] * matrix3x3[8] - matrix3x3[2] * matrix3x3[7]) +
	       matrix3x3[6] * (matrix3x3[1] * matrix3x3[5] - matrix3x3[2] * matrix3x3[4]);
}

function Matrix_determinant( matrix) {
	var subdeterminant0, subdeterminant1, subdeterminant2, subdeterminant3;
	
	subdeterminant0 = Matrix_subdeterminant(matrix, 0);
	subdeterminant1 = Matrix_subdeterminant(matrix, 4);
	subdeterminant2 = Matrix_subdeterminant(matrix, 8);
	subdeterminant3 = Matrix_subdeterminant(matrix, 12);
	
	return matrix.m0  *  subdeterminant0 +
	       matrix.m4  * -subdeterminant1 +
	       matrix.m8  *  subdeterminant2 +
	       matrix.m12 * -subdeterminant3;
}

function Matrix_invert( matrix) {
	var determinant;
	var result = {};
	var index, indexTransposed;
	var sign;
	
	determinant = Matrix_determinant(matrix);
	for (index = 0; index < 16; index++) {
		sign = 1 - (((index % 4) + (index / 4)) % 2) * 2;
		indexTransposed = (index % 4) * 4 + index / 4;
		result.mindexTransposed = Matrix_subdeterminant(matrix, index) * sign / determinant;
	}
	
	matrix = result;
}

function Matrix_inverted( matrix) {
	var m1 = Matrix_withMatrix(matrix1);
	Matrix_invert(m1);
	return m1;
}

function Matrix_multiplyVector( matrix,  vector) {
	var result = {};
	
	result.x = ((matrix.m0 * vector.x) + (matrix.m4 * vector.y) + (matrix.m8  * vector.z) + matrix.m12);
	result.y = ((matrix.m1 * vector.x) + (matrix.m5 * vector.y) + (matrix.m9  * vector.z) + matrix.m13);
	result.z = ((matrix.m2 * vector.x) + (matrix.m6 * vector.y) + (matrix.m10 * vector.z) + matrix.m14);
	return result;
}
