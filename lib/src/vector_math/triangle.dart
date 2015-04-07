/*
  Copyright (C) 2013 John McCutchan <john@johnmccutchan.com>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.

*/

part of vector_math;

/// Defines a triangle by three points.
class Triangle {
  final Vector3 _point0;
  final Vector3 _point1;
  final Vector3 _point2;

  /// The first point of the triangle.
  Vector3 get point0 => _point0;
  /// The second point of the triangle.
  Vector3 get point1 => _point1;
  /// The third point of the triangle.
  Vector3 get point2 => _point2;

  /// Create a new, uninitialized triangle.
  Triangle()
      : _point0 = new Vector3.zero(),
        _point1 = new Vector3.zero(),
        _point2 = new Vector3.zero();

  /// Create a triangle as a copy of [other].
  Triangle.copy(Triangle other)
      : _point0 = new Vector3.copy(other._point0),
        _point1 = new Vector3.copy(other._point1),
        _point2 = new Vector3.copy(other._point2);

  /// Create a triangle by three points.
  Triangle.points(Vector3 point0, Vector3 point1, Vector3 point2)
      : _point0 = new Vector3.copy(point0),
        _point1 = new Vector3.copy(point1),
        _point2 = new Vector3.copy(point2);

  /// Copy the triangle from [other] into [this].
  void copyFrom(Triangle other) {
    _point0.setFrom(other._point0);
    _point1.setFrom(other._point1);
    _point2.setFrom(other._point2);
  }

  /// Copy the normal of [this] into [normal].
  void copyNormalInto(Vector3 normal) {
    final v0 = point0.clone()..sub(point1);
    normal
      ..setFrom(point2)
      ..sub(point1)
      ..crossInto(v0, normal)
      ..normalize();
  }

  /// Transform [this] by the transform [t].
  void transform(Matrix4 t) {
    t.transform3(_point0);
    t.transform3(_point1);
    t.transform3(_point2);
  }

  /// Translate [this] by [offset].
  void translate(Vector3 offset) {
    _point0.add(offset);
    _point1.add(offset);
    _point2.add(offset);
  }
}
