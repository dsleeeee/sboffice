﻿/*
 *
 * Wijmo Library 5.20183.550
 * http://wijmo.com/
 *
 * Copyright(c) GrapeCity, Inc.  All rights reserved.
 *
 * Licensed under the GrapeCity Commercial License.
 * sales@wijmo.com
 * wijmo.com/products/wijmo-5/license/
 *
 */
var __extends = this && this.__extends || function() {
    var t = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(t, e) {
        t.__proto__ = e
      } || function(t, e) {
        for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i])
      };
    return function(e, i) {
      function n() {
        this.constructor = e
      }
      t(e, i), e.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(t) {
  ! function(e) {
    ! function(i) {
      "use strict";
      var n = function(i) {
        function n(t) {
          var n = i.call(this) || this;
          return n._chartType = e.ChartType.Line, n._sampleCount = 100, n.initialize(t), n
        }
        return __extends(n, i), Object.defineProperty(n.prototype, "sampleCount", {
          get: function() {
            return this._sampleCount
          },
          set: function(e) {
            (e = t.asNumber(e, !1, !0)) != this._sampleCount && (this._sampleCount = e, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), n.prototype.approximate = function(t) {
          return 0
        }, n.prototype.getValues = function(t) {
          var e = this,
            n = e.binding,
            r = e.bindingX;
          return n !== e._bind && (e._bind = n, e.binding = n), r !== e._bindX && (e._bindX = r, e.bindingX = r), null == e._originYValues && (e._originYValues = i.prototype.getValues.call(this, 0)), null == e._originXValues && (e._originXValues = i.prototype.getValues.call(this, 1)), null == e._originXValues || null == e._originYValues ? null : (i.prototype.getValues.call(this, t), null != e._xValues && null != e._yValues || e._calculateValues(), 0 === t ? e._yValues || null : 1 === t ? e._xValues || null : void 0)
        }, n.prototype._calculateValues = function() {}, n.prototype._invalidate = function() {
          i.prototype._invalidate.call(this), this._clearCalculatedValues()
        }, n.prototype._clearValues = function() {
          i.prototype._clearValues.call(this), this._originXValues = null, this._originYValues = null, this._clearCalculatedValues()
        }, n.prototype._clearCalculatedValues = function() {
          this._xValues = null, this._yValues = null
        }, n
      }(e.SeriesBase);
      i.TrendLineBase = n
    }(e.analytics || (e.analytics = {}))
  }(t.chart || (t.chart = {}))
}(wijmo || (wijmo = {}));
var __extends = this && this.__extends || function() {
    var t = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(t, e) {
        t.__proto__ = e
      } || function(t, e) {
        for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i])
      };
    return function(e, i) {
      function n() {
        this.constructor = e
      }
      t(e, i), e.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(t) {
  ! function(e) {
    ! function(e) {
      "use strict";
      var i, n = function() {
        function e() {}
        return e.round = function(t, e) {
          if (!t) return 0;
          var i = Math.pow(10, e || 2);
          return Math.round(t * i) / i
        }, e.avg = function(t) {
          return e.sum(t) / t.length
        }, e.sum = function(e) {
          return (e = t.asArray(e, !1)).reduce(function(t, e) {
            return t + e
          }, 0)
        }, e.sumOfPow = function(e, i) {
          return e = t.asArray(e, !1), i = t.asNumber(i, !1), e.reduce(function(t, e) {
            return t + Math.pow(e, i)
          }, 0)
        }, e.sumProduct = function() {
          for (var i = [], n = 0; n < arguments.length; n++) i[n] = arguments[n];
          i.length;
          var r, a, o = 0,
            s = [];
          for ((i = t.asArray(i, !1)).forEach(function(e, i) {
            e = t.asArray(e, !1), 0 === i ? o = e.length : t.assert(e.length === o, "The length of the arrays must be equal")
          }), r = 0; r < o; r++) a = 1, i.some(function(e, i) {
            var n = e[r];
            if (!n || !t.isNumber(n)) return a = 0, !0;
            a *= n
          }), s.push(a);
          return e.sum(s)
        }, e.variance = function(i) {
          i = t.asArray(i, !1);
          var n, r = e.avg(i);
          return n = i.map(function(t) {
            return t - r
          }), e.sumOfSquares(n) / (i.length - 1)
        }, e.covariance = function(i, n) {
          i = t.asArray(i, !1), n = t.asArray(n, !1), t.assert(i.length === n.length, "Length of arrays must be equal");
          var r, a = e.avg(i),
            o = e.avg(n),
            s = i.length,
            u = 0;
          for (r = 0; r < s; r++) u += (i[r] - a) * (n[r] - o) / s;
          return u
        }, e.min = function(e) {
          return Math.min.apply(Math, t.asArray(e, !1))
        }, e.max = function(e) {
          return Math.max.apply(Math, t.asArray(e, !1))
        }, e.square = function(e) {
          return Math.pow(t.asNumber(e, !1), 2)
        }, e.sumOfSquares = function(t) {
          return e.sumOfPow(t, 2)
        }, e.stdDev = function(t) {
          return Math.sqrt(e.variance(t))
        }, e
      }();
      ! function(t) {
        t[t.Linear = 0] = "Linear", t[t.Exponential = 1] = "Exponential", t[t.Logarithmic = 2] = "Logarithmic", t[t.Power = 3] = "Power", t[t.Fourier = 4] = "Fourier", t[t.Polynomial = 5] = "Polynomial", t[t.MinX = 6] = "MinX", t[t.MinY = 7] = "MinY", t[t.MaxX = 8] = "MaxX", t[t.MaxY = 9] = "MaxY", t[t.AverageX = 10] = "AverageX", t[t.AverageY = 11] = "AverageY"
      }(i = e.TrendLineFitType || (e.TrendLineFitType = {}));
      var r = function(e) {
        function n(t) {
          var n = e.call(this) || this;
          return n._fitType = i.Linear, n._order = 2, n.initialize(t), n
        }
        return __extends(n, e), Object.defineProperty(n.prototype, "fitType", {
          get: function() {
            return this._fitType
          },
          set: function(e) {
            (e = t.asEnum(e, i, !1)) != this._fitType && (this._fitType = e, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "order", {
          get: function() {
            return this._order
          },
          set: function(e) {
            e != this._order && (this._order = t.asNumber(e, !1, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "coefficients", {
          get: function() {
            return this._helper ? this._helper.coefficients : null
          },
          enumerable: !0,
          configurable: !0
        }), n.prototype.approximate = function(t) {
          return this._helper ? this._helper.approximate(t) : NaN
        }, n.prototype.getEquation = function(t) {
          return (this._helper ? this._helper.getEquation(t) : "").replace(/\S(\+|\-)\d/g, function(t) {
            return t[0] + " " + t[1] + " " + t[2]
          })
        }, n.prototype._calculateValues = function() {
          var t = i[this._fitType];
          if (m[t]) {
            var e = !1,
              n = this._originXValues;
            0 == this._chart._xvals.length && this._chart._xlabels.length > 0 && (n = this._originXValues.map(function(t) {
              return t + 1
            }), e = !0);
            var r = new m[t](this._originYValues, n, this.sampleCount, this.order);
            r._isXString = e;
            var a = r.calculateValues();
            this._yValues = a[0], this._xValues = a[1], this._helper = r
          }
        }, n
      }(e.TrendLineBase);
      e.TrendLine = r;
      var a = function() {
          function t(t, e) {
            this._x = t, this._y = e
          }
          return Object.defineProperty(t.prototype, "x", {
            get: function() {
              return this._x
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "y", {
            get: function() {
              return this._y
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "minX", {
            get: function() {
              return null == this._minX && (this._minX = n.min(this._x)), this._minX
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "minY", {
            get: function() {
              return null == this._minY && (this._minY = n.min(this._y)), this._minY
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "maxX", {
            get: function() {
              return null == this._maxX && (this._maxX = n.max(this._x)), this._maxX
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "maxY", {
            get: function() {
              return null == this._maxY && (this._maxY = n.max(this._y)), this._maxY
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "averageX", {
            get: function() {
              return null == this._averageX && (this._averageX = n.avg(this._x)), this._averageX
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "averageY", {
            get: function() {
              return null == this._averageY && (this._averageY = n.avg(this._y)), this._averageY
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "sumX", {
            get: function() {
              return null == this._sumX && (this._sumX = n.sum(this._x)), this._sumX
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "sumY", {
            get: function() {
              return null == this._sumY && (this._sumY = n.sum(this._y)), this._sumY
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "LogX", {
            get: function() {
              return null == this._logX && (this._logX = this._x.map(function(t) {
                return Math.log(t)
              })), this._logX
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "LogY", {
            get: function() {
              return null == this._logY && (this._logY = this._y.map(function(t) {
                return Math.log(t)
              })), this._logY
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "sumLogX", {
            get: function() {
              return null == this._sumLogX && (this._sumLogX = n.sum(this.LogX)), this._sumLogX
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "sumLogY", {
            get: function() {
              return null == this._sumLogY && (this._sumLogY = n.sum(this.LogY)), this._sumLogY
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "sumOfSquareX", {
            get: function() {
              return null == this._sumOfSquareX && (this._sumOfSquareX = n.sumOfSquares(this._x)), this._sumOfSquareX
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "sumOfSquareY", {
            get: function() {
              return null == this._sumOfSquareY && (this._sumOfSquareY = n.sumOfSquares(this._y)), this._sumOfSquareY
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "sumOfSquareLogX", {
            get: function() {
              return null == this._sumOfSquareLogX && (this._sumOfSquareLogX = n.sumOfSquares(this.LogX)), this._sumOfSquareLogX
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(t.prototype, "sumOfSquareLogY", {
            get: function() {
              return null == this._sumOfSquareLogY && (this._sumOfSquareLogY = n.sumOfSquares(this.LogY)), this._sumOfSquareLogY
            },
            enumerable: !0,
            configurable: !0
          }), t.prototype.sumProduct = function(t, e) {
            return null == this._sumProduct && (this._sumProduct = n.sumProduct(t, e)), this._sumProduct
          }, t
        }(),
        o = function() {
          function e(e, i, n) {
            this._coefficients = [], this.y = t.asArray(e), this.x = t.asArray(i), t.assert(e.length === i.length, "Length of X and Y arrays are not equal"), this.count = n || e.length, this._calculator = new a(i, e), this.xMin = this._calculator.minX, this.xMax = this._calculator.maxX
          }
          return Object.defineProperty(e.prototype, "calculator", {
            get: function() {
              return this._calculator
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(e.prototype, "y", {
            get: function() {
              return this._y
            },
            set: function(e) {
              e !== this.y && (this._y = t.asArray(e, !1))
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(e.prototype, "x", {
            get: function() {
              return this._x
            },
            set: function(e) {
              e !== this.x && (this._x = t.asArray(e, !1))
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(e.prototype, "count", {
            get: function() {
              return this._count
            },
            set: function(e) {
              e !== this.count && (this._count = t.asInt(e, !1, !0))
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(e.prototype, "xMin", {
            get: function() {
              return this._xMin
            },
            set: function(e) {
              e !== this.xMin && (this._xMin = t.asNumber(e, !1))
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(e.prototype, "xMax", {
            get: function() {
              return this._xMax
            },
            set: function(e) {
              e !== this.xMax && (this._xMax = t.asNumber(e, !1))
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(e.prototype, "coefficients", {
            get: function() {
              return this._coefficients
            },
            enumerable: !0,
            configurable: !0
          }), e.prototype._calculateCoefficients = function() {
            var t = this.calcB(),
              e = this.calcA(t);
            this._coefficients.push(e, t)
          }, e.prototype.calculateValues = function() {
            for (var t = (this.xMax - this.xMin) / (this.count - 1), e = [
              [],
              []
            ], i = 0; i < this.count; i++) {
              var n = this.xMin + t * i,
                r = this.calcY(n);
              e[0].push(r), this._isXString ? e[1].push(n - 1) : e[1].push(n)
            }
            return e
          }, e.prototype.calcA = function(t) {
            var e = this.y.length,
              i = this.calculator.sumX;
            return (this.calculator.sumY - (t = t || this.calcB()) * i) / e
          }, e.prototype.calcB = function() {
            var t = this.y.length,
              e = this.calculator,
              i = e.sumProduct(e.x, e.y),
              r = e.sumX;
            return (t * i - r * e.sumY) / (t * e.sumOfSquareX - n.square(r))
          }, e.prototype.calcY = function(t) {
            var e = this.coefficients;
            return e[0] + e[1] * t
          }, e.prototype.approximate = function(t) {
            return this.calcY(t)
          }, e.prototype.getEquation = function(t) {
            var t = t || this._defaultEquationFmt;
            return this._getEquation(t)
          }, e.prototype._getEquation = function(t) {
            var e = [];
            return this.coefficients.forEach(function(i) {
              e.push(t(i))
            }), this._concatEquation(e)
          }, e.prototype._concatEquation = function(t) {
            return ""
          }, e.prototype._defaultEquationFmt = function(t) {
            var e, i = Math.abs(t),
              n = String(i),
              r = 0;
            return i >= 1e5 ? (e = String(Math.round(i)).length - 1, Math.round(t / Number("1e" + e)) + "e" + e) : i < 1e-4 ? (e = n.indexOf("e") > -1 ? Math.abs(+n.substring(n.indexOf("e") + 1)) : n.match(/\.0+/)[0].length, Math.round(t * Number("1e" + e)) + "e-" + e) : (r = t > 0 ? 6 : 7, i >= 1e4 && r--, String(+String(t).substring(0, r)))
          }, e
        }(),
        s = function(e) {
          function i(t, i, n, r) {
            var a = e.call(this, t, i, n) || this;
            return a._calculateCoefficients(), a.yOffset = r, a
          }
          return __extends(i, e), Object.defineProperty(i.prototype, "yOffset", {
            get: function() {
              return this._yOffset
            },
            set: function(e) {
              e !== this.yOffset && (this._yOffset = t.asNumber(e, !0))
            },
            enumerable: !0,
            configurable: !0
          }), i.prototype.calcA = function(t) {
            return null != this.yOffset ? this.yOffset : e.prototype.calcA.call(this, t)
          }, i.prototype.calcB = function() {
            return null != this.yOffset ? this._calculateBSimple() : e.prototype.calcB.call(this)
          }, i.prototype._calculateBSimple = function() {
            var t = this.calculator,
              e = t.sumProduct(t.x, t.y),
              i = t.sumX,
              n = t.sumOfSquareX;
            return (e - this.yOffset * i) / n
          }, i.prototype._calculateCoefficients = function() {
            var t = this.calcB(),
              e = this.calcA(t);
            this.coefficients.push(t, e)
          }, i.prototype.calcY = function(t) {
            var e = this.coefficients;
            return e[0] * t + e[1]
          }, i.prototype._concatEquation = function(t) {
            return "y = " + t[0] + "x" + (this.coefficients[1] >= 0 ? "+" : "") + t[1]
          }, i
        }(o),
        u = function(t) {
          function e(e, i, n) {
            var r = t.call(this, e, i, n) || this;
            return r._calculateCoefficients(), r
          }
          return __extends(e, t), e.prototype.calcA = function(t) {
            var e = this.y.length,
              i = this.calculator,
              n = i.sumY,
              r = i.sumLogX;
            return (n - (t = t || this.calcB()) * r) / e
          }, e.prototype.calcB = function() {
            var t = this.y.length,
              e = this.calculator,
              i = e.sumProduct(e.y, e.LogX),
              r = e.sumY,
              a = e.sumLogX;
            return (t * i - r * a) / (t * e.sumOfSquareLogX - n.square(a))
          }, e.prototype._calculateCoefficients = function() {
            var t = this.calcB(),
              e = this.calcA(t);
            this.coefficients.push(t, e)
          }, e.prototype.calcY = function(t) {
            var e = this.coefficients;
            return Math.log(t) * e[0] + e[1]
          }, e.prototype._concatEquation = function(t) {
            return "y = " + t[0] + "ln(x)" + (this.coefficients[1] >= 0 ? "+" : "") + t[1]
          }, e
        }(o),
        l = function(t) {
          function e(e, i, n) {
            var r = t.call(this, e, i, n) || this;
            return r._calculateCoefficients(), r
          }
          return __extends(e, t), e.prototype.calcA = function() {
            var t = this.y.length,
              e = this.calculator,
              i = e.sumLogY,
              r = e.sumOfSquareX,
              a = e.sumX,
              o = e.sumProduct(e.x, e.LogY);
            return Math.exp((i * r - a * o) / (t * r - n.square(a)))
          }, e.prototype.calcB = function() {
            var t = this.y.length,
              e = this.calculator,
              i = e.sumLogY,
              r = e.sumOfSquareX,
              a = e.sumX;
            return (t * e.sumProduct(e.x, e.LogY) - a * i) / (t * r - n.square(a))
          }, e.prototype.calcY = function(t) {
            var e = this.coefficients;
            return e[0] * Math.exp(e[1] * t)
          }, e.prototype._concatEquation = function(t) {
            return "y = " + t[0] + "e<sup>" + t[1] + "x</sup>"
          }, e
        }(o),
        c = function(t) {
          function e(e, i, n) {
            var r = t.call(this, e, i, n) || this;
            return r._calculateCoefficients(), r
          }
          return __extends(e, t), e.prototype.calcA = function(t) {
            var e = this.calculator,
              i = this.y.length,
              n = e.sumLogX,
              r = e.sumLogY,
              t = t || this.calcB();
            return Math.exp((r - t * n) / i)
          }, e.prototype.calcB = function() {
            var t = this.y.length,
              e = this.calculator,
              i = e.sumProduct(e.LogX, e.LogY),
              r = e.sumLogX;
            return (t * i - r * e.sumLogY) / (t * e.sumOfSquareLogX - n.square(r))
          }, e.prototype.calcY = function(t) {
            var e = this.coefficients;
            return e[0] * Math.pow(t, e[1])
          }, e.prototype._concatEquation = function(t) {
            return "y = " + t[0] + "x<sup>" + t[1] + "</sup>"
          }, e
        }(o),
        h = function(e) {
          function i(t, i, n, r) {
            var a = e.call(this, t, i, n) || this;
            return a._order = null == r ? 2 : r, a._basis = [], a._calculateCoefficients(), a
          }
          return __extends(i, e), Object.defineProperty(i.prototype, "basis", {
            get: function() {
              return this._basis
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(i.prototype, "order", {
            get: function() {
              return this._order
            },
            set: function(e) {
              this._order = t.asNumber(e, !0)
            },
            enumerable: !0,
            configurable: !0
          }), i.prototype._calculateCoefficients = function() {
            this._coefficients.length = this.order, this._createBasis(), this._normalizeAndSolveGauss()
          }, i.prototype._createBasis = function() {
            var t = this.x.length,
              e = this.order;
            if (t < 2) throw "Incompatible data: Less than 2 data points.";
            if (e < 1) throw "Incompatible data: Less than 1 coefficient in the fit";
            if (e > t) throw "Incompatible data: Number of data points less than number of terms"
          }, i.prototype._normalizeAndSolveGauss = function() {
            var t = [];
            if (this._computeNormalEquations(t), this._genDefValForArray(t, 0), !this._solveGauss(t)) throw "Incompatible data: No solution."
          }, i.prototype._genDefValForArray = function(t, e) {
            var i = t.length + 1;
            t.forEach(function(t) {
              for (var n = 0; n < i; n++) null == t[n] && (t[n] = e)
            })
          }, i.prototype._computeNormalEquations = function(t) {
            var e, i, n, r, a = this.y,
              o = this.basis,
              s = this.order,
              u = a.length;
            for (e = 0; e < s; e++)
              for (n = 0, null == t[e] && (t[e] = []), a.forEach(function(t, i) {
                n += t * o[i][e]
              }), t[e][s] = n, i = e; i < s; i++) {
                for (n = 0, r = 0; r < u; r++) n += o[r][i] * o[r][e];
                null == t[i] && (t[i] = []), t[i][e] = n, t[e][i] = n
              }
          }, i.prototype._solveGauss = function(t) {
            var e, i, n = t.length,
              r = this._coefficients,
              a = !0;
            if (r.length < n || t[0].length < n + 1) throw "Dimension of matrix is not correct.";
            if (t.some(function(e, r) {
              var o, s, u = r,
                l = Math.abs(e[r]);
              for (i = r + 1; i < n; i++) l < (o = Math.abs(t[i][r])) && (l = o, u = i);
              if (!(l > 0)) return a = !1, !0;
              for (i = r; i <= n; i++) s = t[r][i], t[r][i] = t[u][i], t[u][i] = s;
              for (u = r + 1; u < n; u++)
                for (s = t[u][r] / e[r], t[u][r] = 0, i = r + 1; i <= n; i++) t[u][i] -= s * e[i]
            }), a)
              for (e = n - 1; e >= 0; e--) {
                for (r[e] = t[e][n], i = e + 1; i < n; i++) r[e] -= t[e][i] * r[i];
                r[e] = r[e] / t[e][e]
              }
            return a
          }, i
        }(o),
        f = function(t) {
          function e(e, i, n, r) {
            return t.call(this, e, i, n, r) || this
          }
          return __extends(e, t), Object.defineProperty(e.prototype, "coefficients", {
            get: function() {
              return this._coefficients.slice(0).reverse()
            },
            enumerable: !0,
            configurable: !0
          }), e.prototype.calcY = function(t) {
            var e = 0,
              i = 1;
            return this._coefficients.forEach(function(n, r) {
              r > 0 && (i *= t), e += n * i
            }), e
          }, e.prototype._calculateCoefficients = function() {
            this._coefficients;
            this.order++, t.prototype._calculateCoefficients.call(this), this.order--
          }, e.prototype._createBasis = function() {
            t.prototype._createBasis.call(this);
            var e = this.x,
              i = this.basis,
              n = this.order;
            e.forEach(function(t, e) {
              i[e] = [1];
              for (var r = 1; r <= n; r++) i[e][r] = t * i[e][r - 1]
            })
          }, e.prototype._concatEquation = function(t) {
            var e = "y = ",
              i = t.length,
              n = this.coefficients;
            return t.forEach(function(t, r) {
              var a, o = i - 1 - r;
              0 === o ? e += t : 1 === o ? (a = n[r + 1] >= 0 ? "+" : "", e += t + "x" + a) : (a = n[r + 1] >= 0 ? "+" : "", e += t + "x<sup>" + o + "</sup>" + a)
            }), e
          }, e
        }(h),
        _ = function(t) {
          function e(e, i, n, r) {
            return r = null == r ? i.length : r, t.call(this, e, i, n, r) || this
          }
          return __extends(e, t), e.prototype._createBasis = function() {
            t.prototype._createBasis.call(this);
            var e = this.x,
              i = this.basis,
              n = this.order;
            e.forEach(function(t, e) {
              var r, a;
              for (i[e] = [1], r = 1; r < n; r++) a = Math.floor((r + 1) / 2), r % 2 == 1 ? i[e].push(Math.cos(a * t)) : i[e].push(Math.sin(a * t))
            })
          }, e.prototype.calcY = function(t) {
            var e;
            return this._coefficients.forEach(function(i, n) {
              var r, a = Math.floor((n + 1) / 2);
              0 === n ? e = i : (r = a * t, e += n % 2 == 1 ? i * Math.cos(r) : i * Math.sin(r))
            }), e
          }, e.prototype._concatEquation = function(t) {
            var e = "y = ",
              i = t.length,
              n = this.coefficients;
            return t.forEach(function(t, r) {
              var a = r === i - 1 ? "" : n[r + 1] >= 0 ? "+" : "",
                o = "",
                s = Math.ceil(r / 2);
              if (0 === r) e += t + a;
              else {
                o = r % 2 == 1 ? "cos" : "sin";
                o += "(" + (1 === s ? "" : String(s)) + "x)", e += t + o + a
              }
            }), e
          }, e
        }(h),
        p = function(t) {
          function e(e, i, n) {
            var r = t.call(this, e, i, n) || this;
            return r._calculateCoefficients(), r
          }
          return __extends(e, t), e.prototype._setVal = function(t) {
            this._val = t
          }, e.prototype.calcY = function(t) {
            return this._val
          }, e
        }(o),
        m = {
          TrendHelperBase: o,
          Linear: s,
          Exponential: l,
          Logarithmic: u,
          Power: c,
          Polynomial: f,
          Fourier: _,
          MinX: function(t) {
            function e(e, i, n) {
              return t.call(this, e, i, n) || this
            }
            return __extends(e, t), e.prototype.calculateValues = function() {
              var t, e, i = this.xMin,
                r = n.min(this.y),
                a = n.max(this.y);
              return this._isXString && (i -= 1), t = [i, i], e = [r, a], this._setVal(i), [e, t]
            }, e.prototype.getEquation = function(t) {
              var e = this.xMin;
              return this._isXString && (e -= 1), t && (e = t(e)), "x = " + e
            }, e
          }(p),
          MinY: function(t) {
            function e(e, i, n) {
              return t.call(this, e, i, n) || this
            }
            return __extends(e, t), e.prototype.calculateValues = function() {
              var t, e, i = this.xMin,
                r = this.xMax,
                a = n.min(this.y);
              return this._isXString && (i -= 1, r -= 1), t = [i, r], e = [a, a], this._setVal(a), [e, t]
            }, e.prototype.getEquation = function(t) {
              var e = n.min(this.y);
              return t && (e = t(e)), "y = " + e
            }, e
          }(p),
          MaxX: function(t) {
            function e(e, i, n) {
              return t.call(this, e, i, n) || this
            }
            return __extends(e, t), e.prototype.calculateValues = function() {
              var t, e, i = this.xMax,
                r = n.min(this.y),
                a = n.max(this.y);
              return this._isXString && (i -= 1), t = [i, i], e = [r, a], this._setVal(i), [e, t]
            }, e.prototype.getEquation = function(t) {
              var e = this.xMax;
              return this._isXString && (e -= 1), t && (e = t(e)), "x = " + e
            }, e
          }(p),
          MaxY: function(t) {
            function e(e, i, n) {
              return t.call(this, e, i, n) || this
            }
            return __extends(e, t), e.prototype.calculateValues = function() {
              var t, e, i = this.xMin,
                r = this.xMax,
                a = n.max(this.y);
              return this._isXString && (i -= 1, r -= 1), t = [i, r], e = [a, a], this._setVal(a), [e, t]
            }, e.prototype.getEquation = function(t) {
              var e = n.max(this.y);
              return t && (e = t(e)), "y = " + e
            }, e
          }(p),
          AverageX: function(t) {
            function e(e, i, n) {
              return t.call(this, e, i, n) || this
            }
            return __extends(e, t), e.prototype.calculateValues = function() {
              var t, e, i = n.avg(this.x),
                r = n.min(this.y),
                a = n.max(this.y);
              return this._isXString && (i -= 1), t = [i, i], e = [r, a], this._setVal(i), [e, t]
            }, e.prototype._getEquation = function(t) {
              var e = n.avg(this.x);
              return this._isXString && (e -= 1), t && (e = t(e)), " x =" + e
            }, e.prototype._defaultEquationFmt = function(e) {
              return Math.abs(e) < 1e5 ? t.prototype._defaultEquationFmt.call(this, e) : "" + n.round(e, 2)
            }, e
          }(p),
          AverageY: function(t) {
            function e(e, i, n) {
              return t.call(this, e, i, n) || this
            }
            return __extends(e, t), e.prototype.calculateValues = function() {
              var t, e, i = n.avg(this.y),
                r = this.xMin,
                a = this.xMax;
              return this._isXString && (r -= 1, a -= 1), t = [r, a], e = [i, i], this._setVal(i), [e, t]
            }, e.prototype._getEquation = function(t) {
              return "y = " + t(n.avg(this.y))
            }, e.prototype._defaultEquationFmt = function(e) {
              return Math.abs(e) < 1e5 ? t.prototype._defaultEquationFmt.call(this, e) : "" + n.round(e, 2)
            }, e
          }(p)
        }
    }(e.analytics || (e.analytics = {}))
  }(t.chart || (t.chart = {}))
}(wijmo || (wijmo = {}));
var __extends = this && this.__extends || function() {
    var t = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(t, e) {
        t.__proto__ = e
      } || function(t, e) {
        for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i])
      };
    return function(e, i) {
      function n() {
        this.constructor = e
      }
      t(e, i), e.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(t) {
  ! function(e) {
    ! function(e) {
      "use strict";
      var i = function(e) {
        function i(i) {
          var n = e.call(this) || this;
          return n._min = 0, n._max = 1, n.initialize(i), null == n.itemsSource && (n.itemsSource = [new t.Point(0, 0)]), n
        }
        return __extends(i, e), Object.defineProperty(i.prototype, "min", {
          get: function() {
            return this._min
          },
          set: function(e) {
            this._min !== e && (this._min = t.asNumber(e, !1), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(i.prototype, "max", {
          get: function() {
            return this._max
          },
          set: function(e) {
            this._max !== e && (this._max = t.asNumber(e, !1), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), i.prototype.getValues = function(t) {
          var e = this;
          return null != e._xValues && null != e._yValues || e._calculateValues(), 0 === t ? e._yValues || null : 1 === t ? e._xValues || null : void 0
        }, i.prototype._calculateValues = function() {
          for (var t, e = this, i = e.sampleCount, n = [], r = [], a = (e.max - e.min) / (i - 1), o = 0; o < i; o++) t = o === i - 1 ? this.max : this.min + a * o, n[o] = e._calculateX(t), r[o] = e._calculateY(t);
          e._yValues = r, e._xValues = n
        }, i.prototype._validateValue = function(t) {
          return isFinite(t) ? t : Number.NaN
        }, i.prototype._calculateValue = function(t, e) {
          var i;
          try {
            i = t(e)
          } catch (t) {
            i = Number.NaN
          }
          return this._validateValue(i)
        }, i.prototype._calculateX = function(t) {
          return 0
        }, i.prototype._calculateY = function(t) {
          return 0
        }, i
      }(e.TrendLineBase);
      e.FunctionSeries = i;
      var n = function(e) {
        function i(t) {
          return e.call(this, t) || this
        }
        return __extends(i, e), Object.defineProperty(i.prototype, "func", {
          get: function() {
            return this._func
          },
          set: function(e) {
            e && this._func !== e && (this._func = t.asFunction(e, !1), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), i.prototype._calculateX = function(t) {
          return t
        }, i.prototype._calculateY = function(t) {
          return this._calculateValue(this.func, t)
        }, i.prototype.approximate = function(t) {
          return this._calculateValue(this.func, t)
        }, i
      }(i);
      e.YFunctionSeries = n;
      var r = function(e) {
        function i(t) {
          return e.call(this, t) || this
        }
        return __extends(i, e), Object.defineProperty(i.prototype, "xFunc", {
          get: function() {
            return this._xFunc
          },
          set: function(e) {
            e && this._xFunc !== e && (this._xFunc = t.asFunction(e, !1), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(i.prototype, "yFunc", {
          get: function() {
            return this._yFunc
          },
          set: function(e) {
            e && this._yFunc !== e && (this._yFunc = t.asFunction(e, !1), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), i.prototype._calculateX = function(t) {
          return this._calculateValue(this.xFunc, t)
        }, i.prototype._calculateY = function(t) {
          return this._calculateValue(this.yFunc, t)
        }, i.prototype.approximate = function(e) {
          var i = this._calculateValue(this.xFunc, e),
            n = this._calculateValue(this.yFunc, e);
          return new t.Point(i, n)
        }, i
      }(i);
      e.ParametricFunctionSeries = r
    }(e.analytics || (e.analytics = {}))
  }(t.chart || (t.chart = {}))
}(wijmo || (wijmo = {}));
var __extends = this && this.__extends || function() {
    var t = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(t, e) {
        t.__proto__ = e
      } || function(t, e) {
        for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i])
      };
    return function(e, i) {
      function n() {
        this.constructor = e
      }
      t(e, i), e.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(t) {
  ! function(e) {
    ! function(i) {
      "use strict";
      var n;
      ! function(t) {
        t[t.Simple = 0] = "Simple", t[t.Weighted = 1] = "Weighted", t[t.Exponential = 2] = "Exponential", t[t.Triangular = 3] = "Triangular"
      }(n = i.MovingAverageType || (i.MovingAverageType = {}));
      var r = function(i) {
        function r(t) {
          var r = i.call(this) || this;
          return r._chartType = e.ChartType.Line, r._type = n.Simple, r._period = 2, r.initialize(t), r
        }
        return __extends(r, i), Object.defineProperty(r.prototype, "type", {
          get: function() {
            return this._type
          },
          set: function(e) {
            (e = t.asEnum(e, n, !1)) != this._type && (this._type = e, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "period", {
          get: function() {
            return this._period
          },
          set: function(e) {
            (e = t.asNumber(e, !1, !0)) != this._period && (this._period = t.asNumber(e, !1, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), r.prototype._checkPeriod = function() {
          var e = this.period,
            i = this._originXValues;
          e <= 1 && t.assert(!1, "period must be greater than 1."), i && i.length && e >= i.length && t.assert(!1, "period must be less than itemSource's length.")
        }, r.prototype._calculateValues = function() {
          this._type;
          var t = "_calculate" + n[this._type],
            e = [],
            i = [];
          this._checkPeriod(), this[t] && this[t].call(this, e, i), this._yValues = i, this._xValues = e
        }, r.prototype._calculateSimple = function(t, e, i) {
          void 0 === i && (i = !1);
          for (var n = this._originXValues, r = this._originYValues, a = n.length, o = this._period, s = 0, u = 0; u < a; u++) s += r[u] || 0, u >= o && (s -= r[u - o] || 0), u >= o - 1 ? (t.push(n[u]), e.push(s / o)) : i && (t.push(n[u]), e.push(s / (u + 1)))
        }, r.prototype._calculateWeighted = function(t, e) {
          for (var i = this._originXValues, n = this._originYValues, r = i.length, a = this._period, o = a * (a + 1) / 2, s = 0, u = 0, l = 0; l < r; l++) l > 0 && (s += n[l - 1] || 0), l > a && (s -= n[l - a - 1] || 0), l < a - 1 ? u += (n[l] || 0) * (l + 1) : (u += (n[l] || 0) * a, l > a - 1 && (u -= s), t.push(i[l]), e.push(u / o))
        }, r.prototype._calculateExponential = function(t, e) {
          for (var i = this._originXValues, n = this._originYValues, r = i.length, a = this._period, o = 0, s = 0; s < r; s++) s <= a - 2 ? (o += n[s] || 0, s === a - 2 && (o /= a - 1)) : (o += 2 / (a + 1) * ((n[s] || 0) - o), t.push(i[s]), e.push(o))
        }, r.prototype._calculateTriangular = function(t, e) {
          var i = this._period,
            n = [],
            r = [],
            a = 0;
          this._calculateSimple(n, r, !0);
          for (var o = 0, s = n.length; o < s; o++) a += r[o] || 0, o >= i && (a -= r[o - i] || 0), o >= i - 1 && (t.push(n[o]), e.push(a / i))
        }, r
      }(i.TrendLineBase);
      i.MovingAverage = r
    }(e.analytics || (e.analytics = {}))
  }(t.chart || (t.chart = {}))
}(wijmo || (wijmo = {}));
var __extends = this && this.__extends || function() {
    var t = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(t, e) {
        t.__proto__ = e
      } || function(t, e) {
        for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i])
      };
    return function(e, i) {
      function n() {
        this.constructor = e
      }
      t(e, i), e.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(t) {
  ! function(e) {
    ! function(i) {
      "use strict";
      var n = function(i) {
        function n(t) {
          var n = i.call(this) || this;
          return n._startLabel = "Start", n._relativeData = !0, n._connectorLines = !1, n._showTotal = !1, n._totalLabel = "Total", n._getXValues = !1, n._showIntermediateTotal = !1, n._intermediateTotalPos = [], n._chartType = e.ChartType.Bar, n.rendering.addHandler(n._rendering, n), n.initialize(t), n
        }
        return __extends(n, i), Object.defineProperty(n.prototype, "relativeData", {
          get: function() {
            return this._relativeData
          },
          set: function(e) {
            e != this._relativeData && (this._relativeData = t.asBoolean(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "start", {
          get: function() {
            return this._start
          },
          set: function(e) {
            e != this._start && (this._start = t.asNumber(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "startLabel", {
          get: function() {
            return this._startLabel
          },
          set: function(e) {
            e != this._startLabel && (this._startLabel = t.asString(e, !1), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "showTotal", {
          get: function() {
            return this._showTotal
          },
          set: function(e) {
            e != this._showTotal && (this._showTotal = t.asBoolean(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "totalLabel", {
          get: function() {
            return this._totalLabel
          },
          set: function(e) {
            e != this._totalLabel && (this._totalLabel = t.asString(e, !1), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "showIntermediateTotal", {
          get: function() {
            return this._showIntermediateTotal
          },
          set: function(e) {
            e != this._showIntermediateTotal && (this._showIntermediateTotal = t.asBoolean(e, !1), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "intermediateTotalPositions", {
          get: function() {
            return this._intermediateTotalPositions
          },
          set: function(e) {
            e != this._intermediateTotalPositions && (this._intermediateTotalPositions = t.asArray(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "intermediateTotalLabels", {
          get: function() {
            return this._intermediateTotalLabels
          },
          set: function(e) {
            e != this._intermediateTotalLabels && (t.assert(null == e || t.isArray(e) || t.isString(e), "Array or string expected."), this._intermediateTotalLabels = e, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "connectorLines", {
          get: function() {
            return this._connectorLines
          },
          set: function(e) {
            e != this._connectorLines && (this._connectorLines = t.asBoolean(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(n.prototype, "styles", {
          get: function() {
            return this._styles
          },
          set: function(t) {
            t != this._styles && (this._styles = t, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), n.prototype.getValues = function(e) {
          var n, r, a, o, s = this,
            u = [],
            l = 0;
          if (n = i.prototype.getValues.call(this, e), 0 === e) {
            if (!this._yValues) {
              var u = [],
                c = 0,
                h = 0,
                f = n && n.length || 0;
              if (this.relativeData) {
                for (; h < f; h++) c += isNaN(n[h]) ? 0 : n[h], u.push(c);
                this._yValues = u
              } else {
                for (; h < f; h++) c = isNaN(n[h]) ? 0 : n[h], u.push(c);
                this._yValues = u
              }(r = this._yValues) && r.length > 0 && (this.showIntermediateTotal && this.intermediateTotalPositions && this.intermediateTotalPositions.length > 0 && (this._intermediateTotalPos = r.slice(), this.intermediateTotalPositions.reduceRight(function(t, e) {
                var i = 0 === e ? r[0] : r[e - 1];
                return r.length > e ? (r.splice(e, 0, i), s._intermediateTotalPos.splice(e, 0, !0)) : r.length === e && (r.push(i), s._intermediateTotalPos.push(!0)), 0
              }, 0)), null != this.start && (r.splice(0, 0, this.start), this._intermediateTotalPos.splice(0, 0, !1)), this.showTotal && r && r.push(r[r.length - 1]))
            }
            return this._yValues
          }
          if (!this._xValues && this._getXValues && (this._xValues = n && n.slice(), this._getXValues = !1, this._xValues && this._xValues.length > 1 && (f = this._xValues.length, o = this._xValues[f - 1], l = Math.abs(this._xValues[f - 1] - this._xValues[f - 2])), this.chart && this.chart._xlabels && this.chart._xlabels.length)) {
            if (a = this.chart._xlabels, this.showIntermediateTotal && this.intermediateTotalPositions && this.intermediateTotalPositions.length > 0) {
              var _ = this.intermediateTotalLabels;
              _ && this.intermediateTotalPositions.reduceRight(function(e, i, n) {
                var r = "";
                return r = t.isString(_) ? _ : _[n] || "", a.length > i ? a.splice(i, 0, r) : a.length === i && a.push(r), l && (o += l, s._xValues.push(o)), 0
              }, 0)
            }
            null != this.start && (a.splice(0, 0, this.startLabel), l && (o += l, this._xValues.push(o))), this.showTotal && (a.push(this.totalLabel), l && (o += l, this._xValues.push(o)))
          }
          return this._xValues
        }, n.prototype.legendItemLength = function() {
          return this.showTotal ? 3 : 2
        }, n.prototype.measureLegendItem = function(e, i) {
          var n = this._getName(i);
          return n ? this._measureLegendItem(e, n) : new t.Size(0, 0)
        }, n.prototype.drawLegendItem = function(t, i, n) {
          var r = this._getLegendStyles(n);
          this._getName(n) && this._drawLegendItem(t, i, e.ChartType.Bar, this._getName(n), r, this.symbolStyle)
        }, n.prototype._clearValues = function() {
          i.prototype._clearValues.call(this), this._xValues = null, this._yValues = null, this._wfstyle = null, this._getXValues = !0, this._intermediateTotalPos = [], this.chart && this.chart._performBind()
        }, n.prototype._invalidate = function() {
          i.prototype._invalidate.call(this), this._clearValues()
        }, n.prototype._rendering = function(t, e) {
          var i = this;
          e.cancel = !0, this._wfstyle = null;
          var r, a, o, s, u, l, c = this.chart,
            h = this._getAxisY(),
            f = this._getAxisX(),
            _ = h.origin || 0,
            p = e.engine;
          if (this._barPlotter = c._getPlotter(this), o = this._barPlotter.rotated, this._barPlotter._getSymbolOrigin || (this._barPlotter._getSymbolOrigin = function(t, e, n) {
            return 0 === e ? t : !0 === i._intermediateTotalPos[e] ? t : e === n - 1 && i.showTotal ? t : i._yValues[e - 1]
          }), this._barPlotter._getSymbolStyles || (this._barPlotter._getSymbolStyles = function(t, e) {
            var n = i._getStyles();
            return 0 === t && null != i.start ? n.start : !0 === i._intermediateTotalPos[t] ? n.intermediateTotal : t === e - 1 && i.showTotal ? n.total : i._yValues[t] < i._yValues[t - 1] ? n.falling : n.rising
          }), this._barPlotter.plotSeries(p, f, h, t, c, 0, 1), this.connectorLines) {
            for (p.startGroup(n.CSS_CONNECTOR_LINE_GROUP), s = this._barPlotter.hitTester._map[0], l = this._yValues[0] < _, u = s[0].rect, r = 1, a = s.length; r < a; r++) !0 === this._intermediateTotalPos[r] && r !== a - 1 || (this._drawConnectorLine(p, o, u, s[r].rect, l), u = s[r].rect, l = this._yValues[r] < this._yValues[r - 1]);
            p.endGroup()
          }
        }, n.prototype._getStyles = function() {
          if (this._wfstyle) return this._wfstyle;
          var t = this._chart.series.indexOf(this),
            e = this._getSymbolFill(t),
            i = this._getSymbolStroke(t),
            n = this.styles || {};
          return this._wfstyle = {
            start: this._getStyleByKey(n, "start", e, i),
            intermediateTotal: this._getStyleByKey(n, "intermediateTotal", e, i),
            total: this._getStyleByKey(n, "total", e, i),
            falling: this._getStyleByKey(n, "falling", "red", "red"),
            rising: this._getStyleByKey(n, "rising", "green", "green")
          }, this._wfstyle
        }, n.prototype._getStyleByKey = function(t, e, i, n) {
          return {
            fill: t[e] && t[e].fill ? t[e].fill : i,
            stroke: t[e] && t[e].stroke ? t[e].stroke : n
          }
        }, n.prototype._drawConnectorLine = function(e, i, r, a, o) {
          var s = new t.Point,
            u = new t.Point,
            l = this.chart.axisY.reversed,
            c = this.chart.axisX.reversed;
          l ^= o, i ? (l ? (s.x = r.left, u.x = r.left) : (s.x = r.left + r.width, u.x = r.left + r.width), c ? (s.y = r.top, u.y = a.top + a.height) : (s.y = r.top + r.height, u.y = a.top)) : (l ? (s.y = r.top + r.height, u.y = r.top + r.height) : (s.y = r.top, u.y = r.top), c ? (s.x = r.left + r.width, u.x = a.left) : (s.x = r.left, u.x = a.left + a.width)), e.drawLine(s.x, s.y, u.x, u.y, n.CSS_CONNECTOR_LINE, this.styles && this.styles.connectorLines || {
            stroke: "black"
          })
        }, n.prototype._getLegendStyles = function(t) {
          if (t < 0 || null === this.styles) return null;
          var e = this._getStyles();
          return 0 === t ? e.rising : 1 === t ? e.falling : e.total
        }, n.prototype._getName = function(t) {
          var e = void 0;
          if (this.name)
            if (this.name.indexOf(",")) {
              var i = this.name.split(",");
              i && i.length - 1 >= t && (e = i[t].trim())
            } else e = this.name;
          return e
        }, n.CSS_CONNECTOR_LINE_GROUP = "water-fall-connector-lines", n.CSS_CONNECTOR_LINE = "water-fall-connector-line", n.CSS_ENDLABEL = "water-fall-end-label", n
      }(e.SeriesBase);
      i.Waterfall = n
    }(e.analytics || (e.analytics = {}))
  }(t.chart || (t.chart = {}))
}(wijmo || (wijmo = {}));
var __extends = this && this.__extends || function() {
    var t = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(t, e) {
        t.__proto__ = e
      } || function(t, e) {
        for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i])
      };
    return function(e, i) {
      function n() {
        this.constructor = e
      }
      t(e, i), e.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(t) {
  ! function(e) {
    ! function(i) {
      "use strict";
      var n;
      ! function(t) {
        t[t.InclusiveMedian = 0] = "InclusiveMedian", t[t.ExclusiveMedian = 1] = "ExclusiveMedian"
      }(n = i.QuartileCalculation || (i.QuartileCalculation = {}));
      var r = function(i) {
        function r(t) {
          var r = i.call(this) || this;
          return r._groupWidth = .8, r._gapWidth = .1, r._showInnerPoints = !1, r._showOutliers = !1, r._quartileCalculation = n.InclusiveMedian, r._chartType = e.ChartType.Bar, r.rendering.addHandler(r._rendering, r), r.initialize(t), r
        }
        return __extends(r, i), r.prototype._initProperties = function(e) {
          e && t.copy(this, e)
        }, r.prototype._clearValues = function() {
          i.prototype._clearValues.call(this)
        }, Object.defineProperty(r.prototype, "quartileCalculation", {
          get: function() {
            return this._quartileCalculation
          },
          set: function(e) {
            (e = t.asEnum(e, n, !0)) != this._quartileCalculation && (this._quartileCalculation = e, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "groupWidth", {
          get: function() {
            return this._groupWidth
          },
          set: function(e) {
            e != this._groupWidth && e >= 0 && e <= 1 && (this._groupWidth = t.asNumber(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "gapWidth", {
          get: function() {
            return this._gapWidth
          },
          set: function(e) {
            e != this._gapWidth && e >= 0 && e <= 1 && (this._gapWidth = t.asNumber(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "showMeanLine", {
          get: function() {
            return this._showMeanLine
          },
          set: function(e) {
            e != this._showMeanLine && (this._showMeanLine = t.asBoolean(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "meanLineStyle", {
          get: function() {
            return this._meanLineStyle
          },
          set: function(t) {
            t != this._meanLineStyle && (this._meanLineStyle = t, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "showMeanMarker", {
          get: function() {
            return this._showMeanMarker
          },
          set: function(e) {
            e != this._showMeanMarker && (this._showMeanMarker = t.asBoolean(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "meanMarkerStyle", {
          get: function() {
            return this._meanMarkerStyle
          },
          set: function(t) {
            t != this._meanMarkerStyle && (this._meanMarkerStyle = t, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "showInnerPoints", {
          get: function() {
            return this._showInnerPoints
          },
          set: function(e) {
            e != this._showInnerPoints && (this._showInnerPoints = t.asBoolean(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(r.prototype, "showOutliers", {
          get: function() {
            return this._showOutliers
          },
          set: function(e) {
            e != this._showOutliers && (this._showOutliers = t.asBoolean(e, !0), this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), r.prototype._rendering = function(i, n) {
          var r = this;
          n.cancel = !0;
          var o, s, u = this,
            l = u.chart,
            c = (u.chart, u._getAxisX()),
            h = u._getAxisY(),
            f = n.index,
            _ = n.count,
            p = n.engine,
            m = this._plotter,
            y = l.series.indexOf(u),
            d = t.asType(u, e.SeriesBase),
            g = this.quartileCalculation,
            b = this.showOutliers,
            v = this.groupWidth,
            x = (null == this.gapWidth ? .2 : this.gapWidth) / 2;
          f = f || 0;
          var P = v / (_ = _ || 1),
            w = u.getValues(0),
            O = u.getValues(1);
          if (w) {
            if (O || (O = m.dataInfo.getXVals()), O) {
              var S = m.dataInfo.getDeltaX();
              S > 0 && (v *= S, P *= S)
            }
            var V = d._getSymbolFill(y),
              M = d._getAltSymbolFill(y) || V,
              L = d._getSymbolStroke(y),
              j = d._getAltSymbolStroke(y) || L,
              E = w.length;
            null != O && (E = Math.min(E, O.length));
            var X, B, T = 0,
              q = 0;
            if (m.rotated) {
              (T = c.origin || T) < c.actualMin ? T = c.actualMin : T > c.actualMax && (T = c.actualMax);
              c.convert(T);
              for (var Y = h.actualMin, A = h.actualMax, C = 0; C < E; C++) {
                var N = O ? O[C] : C,
                  I = w[C];
                if (null == I || 0 === I.length) return;
                if (m._getSymbolOrigin && h.convert(m._getSymbolOrigin(T, C)), m._getSymbolStyles) {
                  var k = m._getSymbolStyles(C);
                  V = k && k.fill ? k.fill : V, M = k && k.fill ? k.fill : M, L = k && k.stroke ? k.fill : L, j = k && k.stroke ? k.fill : j
                }
                if (X = I[0] > 0 ? V : M, B = I[0] > 0 ? L : j, p.fill = X, p.stroke = B, e._DataInfo.isValid(N) && t.isArray(I) && I.length > 0 && e._DataInfo.isValid(I[0])) {
                  var F = N - .5 * v + f * P,
                    Q = N - .5 * v + (f + 1) * P,
                    D = (Q - F) * x;
                  if (F += D, Q -= D, F < Y && Q < Y || F > A && Q > A) continue;
                  F = h.convert(F), Q = h.convert(Q);
                  var W = new a(I, g, b),
                    R = {
                      min: c.convert(W.min),
                      max: c.convert(W.max),
                      firstQuartile: c.convert(W.firstQuartile),
                      median: c.convert(W.median),
                      thirdQuartile: c.convert(W.thirdQuartile),
                      mean: c.convert(W.mean),
                      outlierPoints: this._convertPoints(W.outlierPoints, c),
                      innerPoints: this._convertPoints(W.innerPoints, c)
                    },
                    G = new t.Rect(Math.min(R.min, R.max), Math.min(F, Q), Math.abs(R.max - R.min), Math.abs(Q - F)),
                    z = new e._RectArea(G),
                    H = {
                      min: Math.min(F, Q),
                      median: (F + Q) / 2,
                      max: Math.max(Q, F)
                    };
                  if (l.itemFormatter) {
                    p.startGroup();
                    var K = new e.HitTestInfo(l, new t.Point((R.min + R.max) / 2, H.median), e.ChartElement.SeriesSymbol);
                    K._setData(u, C), l.itemFormatter(p, K, function() {
                      r._drawBoxWhisker(p, R, H, o, s, u), o = R, s = H
                    }), p.endGroup()
                  } else this._drawBoxWhisker(p, R, H, o, s, u), o = R, s = H;
                  u._setPointIndex(C, q), q++;
                  var U = new e._DataPoint(y, C, I, N);
                  U.item = W, z.tag = U, m.hitTester.add(z, y), W.outlierPoints && W.outlierPoints.length && W.outlierPoints.forEach(function(i, n) {
                    var r = R.outlierPoints[n],
                      a = new e._CircleArea(new t.Point(r, G.top + G.height / 2), 2);
                    a.tag = U, m.hitTester.add(a, y)
                  })
                }
              }
            } else {
              (T = h.origin || T) < h.actualMin ? T = h.actualMin : T > h.actualMax && (T = h.actualMax);
              h.convert(T);
              for (var J = c.actualMin, Z = c.actualMax, C = 0; C < E; C++) {
                N = O ? O[C] : C;
                if (null == (I = w[C]) || 0 === I.length) return;
                if (m._getSymbolOrigin && h.convert(m._getSymbolOrigin(T, C, E)), m._getSymbolStyles && (V = (k = m._getSymbolStyles(C, E)) && k.fill ? k.fill : V, M = k && k.fill ? k.fill : M, L = k && k.stroke ? k.stroke : L, j = k && k.stroke ? k.stroke : j), X = I[0] > 0 ? V : M, B = I[0] > 0 ? L : j, p.fill = X, p.stroke = B, e._DataInfo.isValid(N) && t.isArray(I) && I.length > 0 && e._DataInfo.isValid(I[0])) {
                  var $ = N - .5 * v + f * P,
                    tt = N - .5 * v + (f + 1) * P;
                  if ($ += D = (tt - $) * x, tt -= D, $ < J && tt < J || $ > Z && tt > Z) continue;
                  if ($ = c.convert($), tt = c.convert(tt), !e._DataInfo.isValid($) || !e._DataInfo.isValid(tt)) continue;
                  var W = new a(I, g, b),
                    R = {
                      min: h.convert(W.min),
                      max: h.convert(W.max),
                      firstQuartile: h.convert(W.firstQuartile),
                      median: h.convert(W.median),
                      thirdQuartile: h.convert(W.thirdQuartile),
                      mean: h.convert(W.mean),
                      outlierPoints: this._convertPoints(W.outlierPoints, h),
                      innerPoints: this._convertPoints(W.innerPoints, h)
                    },
                    G = new t.Rect(Math.min($, tt), Math.min(R.min, R.max), Math.abs(tt - $), Math.abs(R.max - R.min)),
                    z = new e._RectArea(G),
                    et = {
                      min: Math.min($, tt),
                      median: ($ + tt) / 2,
                      max: Math.max($, tt)
                    };
                  l.itemFormatter ? (p.startGroup(), (K = new e.HitTestInfo(l, new t.Point(et.median, (R.min + R.max) / 2), e.ChartElement.SeriesSymbol))._setData(u, C), l.itemFormatter(p, K, function() {
                    r._drawBoxWhisker(p, et, R, o, s, u), o = et, s = R
                  }), p.endGroup()) : (this._drawBoxWhisker(p, et, R, o, s, u), o = et, s = R), u._setPointIndex(C, q), q++, (U = new e._DataPoint(y, C, N, I)).item = W, z.tag = U, m.hitTester.add(z, y), W.outlierPoints && W.outlierPoints.length && W.outlierPoints.forEach(function(i, n) {
                    var r = R.outlierPoints[n],
                      a = new e._CircleArea(new t.Point(G.left + G.width / 2, r), 2);
                    a.tag = U, m.hitTester.add(a, y)
                  })
                }
              }
            }
          }
        }, r.prototype._convertPoints = function(t, e) {
          return t.map(function(t) {
            return e.convert(t)
          })
        }, r.prototype._drawBoxWhisker = function(t, e, i, n, r, a) {
          var o = a.symbolStyle,
            s = this.showInnerPoints,
            u = this.showOutliers,
            l = this.showMeanLine,
            c = this.meanLineStyle,
            h = this.showMeanMarker,
            f = this.meanMarkerStyle,
            _ = this._plotter;
          if (t.startGroup("box-plot"), _.rotated) {
            if (t.drawLine(e.min, (i.min + i.median) / 2, e.min, (i.max + i.median) / 2, null, o), t.drawLine(e.min, i.median, e.firstQuartile, i.median, null, o), t.drawRect(Math.min(e.firstQuartile, e.thirdQuartile), Math.min(i.min, i.max), Math.abs(e.thirdQuartile - e.firstQuartile), Math.abs(i.max - i.min), null, o), t.drawLine(e.median, i.min, e.median, i.max, null, o), t.drawLine(e.max, i.median, e.thirdQuartile, i.median, null, o), t.drawLine(e.max, (i.min + i.median) / 2, e.max, (i.max + i.median) / 2, null, o), l && n && r && t.drawLine(e.mean, i.median, n.mean, r.median, "box-whisker-mean-line", c || o), h) {
              p = Math.abs(i.median - i.min) / 2;
              t.drawLine(e.mean - p, i.median - p, e.mean + p, i.median + p, null, f || o), t.drawLine(e.mean + p, i.median - p, e.mean - p, i.median + p, null, f || o)
            }
            u && e.outlierPoints.forEach(function(e) {
              t.drawPieSegment(e, i.median, 2, 0, 2 * Math.PI, null, o)
            }), s && e.innerPoints.forEach(function(e) {
              t.drawPieSegment(e, i.median, 2, 0, 2 * Math.PI, null, o)
            })
          } else {
            if (t.drawLine((e.min + e.median) / 2, i.min, (e.max + e.median) / 2, i.min, null, o), t.drawLine(e.median, i.min, e.median, i.firstQuartile, null, o), t.drawRect(Math.min(e.min, e.max), Math.min(i.firstQuartile, i.thirdQuartile), Math.abs(e.max - e.min), Math.abs(i.thirdQuartile - i.firstQuartile), null, o), t.drawLine(e.min, i.median, e.max, i.median, null, o), t.drawLine(e.median, i.max, e.median, i.thirdQuartile, null, o), t.drawLine((e.min + e.median) / 2, i.max, (e.max + e.median) / 2, i.max, null, o), l && n && r && t.drawLine(e.median, i.mean, n.median, r.mean, "box-whisker-mean-line", c || o), h) {
              var p = Math.abs(e.median - e.min) / 2;
              t.drawLine(e.median - p, i.mean - p, e.median + p, i.mean + p, null, f || o), t.drawLine(e.median - p, i.mean + p, e.median + p, i.mean - p, null, f || o)
            }
            u && i.outlierPoints.forEach(function(i) {
              t.drawPieSegment(e.median, i, 2, 0, 2 * Math.PI, null, o)
            }), s && i.innerPoints.forEach(function(i) {
              t.drawPieSegment(e.median, i, 2, 0, 2 * Math.PI, null, o)
            })
          }
          t.endGroup()
        }, r.prototype._renderLabels = function(i, n, r, a) {
          var o = this,
            s = this,
            u = this._plotter,
            l = n.length,
            c = r.dataLabel,
            h = c.border,
            f = c.offset,
            _ = c.connectingLine,
            p = "dataY";
          u.rotated && (p = "dataX"), void 0 === f && (f = _ ? 16 : 0), h && (f -= 2);
          for (var m = 0; m < l; m++) {
            var y = n[m],
              d = y.tag,
              g = t.asType(d, e._DataPoint, !0);
            if (g) {
              var b = d.item,
                v = d.y;
              if (d[p] = b.min, d.yfmt = b.min, d.y = b.min, this._plotter._renderLabel(i, y, g, r, c, s, f, a), d[p] = b.firstQuartile, d.yfmt = b.firstQuartile, d.y = b.firstQuartile, this._plotter._renderLabel(i, y, g, r, c, s, f, a), d[p] = b.median, d.yfmt = b.median, d.y = b.median, this._plotter._renderLabel(i, y, g, r, c, s, f, a), d[p] = b.thirdQuartile, d.yfmt = b.thirdQuartile, d.y = b.thirdQuartile, this._plotter._renderLabel(i, y, g, r, c, s, f, a), d[p] = b.max, d.yfmt = b.max, d.y = b.max, this._plotter._renderLabel(i, y, g, r, c, s, f, a), this.showMeanMarker) {
                var x = Number(b.mean.toFixed(2));
                d[p] = x, d.yfmt = x, d.y = x, this._plotter._renderLabel(i, y, g, r, c, s, f, a)
              }
              b.showOutliers && b.outlierPoints && b.outlierPoints.forEach(function(t) {
                d[p] = t, d.yfmt = t, d.y = t, o._plotter._renderLabel(i, y, g, r, c, s, f, a)
              }), d.y = v
            }
          }
        }, r
      }(e.SeriesBase);
      i.BoxWhisker = r;
      var a = function() {
        function t(t, e, i) {
          this._outlierPoints = [], this._innerPoints = [], this._data = t, this._quartileCalculation = e, this._showOutliers = i, this._parse()
        }
        return Object.defineProperty(t.prototype, "showOutliers", {
          get: function() {
            return this._showOutliers
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(t.prototype, "min", {
          get: function() {
            return this._min
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(t.prototype, "max", {
          get: function() {
            return this._max
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(t.prototype, "mean", {
          get: function() {
            return this._mean
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(t.prototype, "firstQuartile", {
          get: function() {
            return this._firstQuartile
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(t.prototype, "thirdQuartile", {
          get: function() {
            return this._thirdQuartile
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(t.prototype, "median", {
          get: function() {
            return this._median
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(t.prototype, "outlierPoints", {
          get: function() {
            return this._outlierPoints
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(t.prototype, "innerPoints", {
          get: function() {
            return this._innerPoints
          },
          enumerable: !0,
          configurable: !0
        }), t.prototype._parse = function() {
          var t = this,
            e = this._data.length,
            i = this._data,
            r = 0;
          this._outlierPoints = [], this._innerPoints = [], i.sort(function(t, e) {
            return t - e
          }), i.some(function(e) {
            return null != e && (t._min = e, !0)
          }), this._max = null == i[e - 1] ? 0 : i[e - 1], this._quartileCalculation === n.InclusiveMedian ? (this._firstQuartile = this._quartileInc(i, .25), this._median = this._quartileInc(i, .5), this._thirdQuartile = this._quartileInc(i, .75)) : (this._firstQuartile = this._quartileExc(i, .25), this._median = this._quartileExc(i, .5), this._thirdQuartile = this._quartileExc(i, .75)), this._iqr = 1.5 * Math.abs(this._thirdQuartile - this._firstQuartile);
          var a = this._firstQuartile - this._iqr,
            o = this._thirdQuartile + this._iqr;
          if (this._showOutliers) {
            var s = this._max;
            this._max = this._min, this._min = s, this._data.forEach(function(e) {
              r += e, e < a || e > o ? t._outlierPoints.push(e) : (e < t._min && (t._min = e), e > t._max && (t._max = e))
            })
          } else r = this._data.reduce(function(t, e) {
            return t + e
          }, 0);
          this._innerPoints = this._data.filter(function(e) {
            if (e > t._min && e < t._max) return !0
          }), this._mean = r / e
        }, t.prototype._quartileInc = function(t, e) {
          var i, n, r, a, o = t.length;
          return 1 === o ? t[0] : (i = (o - 1) * e + 1, n = Math.floor(i), r = t[n - 1], a = i - n, r + (t[n] - r) * a)
        }, t.prototype._quartileExc = function(t, e) {
          var i, n, r, a, o = t.length;
          return 1 === o ? t[0] : 2 === o ? t[Math.round(e)] : (o + 1) % 4 == 0 ? t[(o + 1) * e] : (i = (o + 1) * e, n = Math.floor(i), r = t[n - 1], a = i - n, r + (t[n] - r) * a)
        }, t
      }();
      i._BoxPlot = a
    }(e.analytics || (e.analytics = {}))
  }(t.chart || (t.chart = {}))
}(wijmo || (wijmo = {}));
var __extends = this && this.__extends || function() {
    var t = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(t, e) {
        t.__proto__ = e
      } || function(t, e) {
        for (var i in e) e.hasOwnProperty(i) && (t[i] = e[i])
      };
    return function(e, i) {
      function n() {
        this.constructor = e
      }
      t(e, i), e.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(t) {
  ! function(e) {
    ! function(i) {
      "use strict";
      var n;
      ! function(t) {
        t[t.FixedValue = 0] = "FixedValue", t[t.Percentage = 1] = "Percentage", t[t.StandardDeviation = 2] = "StandardDeviation", t[t.StandardError = 3] = "StandardError", t[t.Custom = 4] = "Custom"
      }(n = i.ErrorAmount || (i.ErrorAmount = {}));
      var r;
      ! function(t) {
        t[t.Cap = 0] = "Cap", t[t.NoCap = 1] = "NoCap"
      }(r = i.ErrorBarEndStyle || (i.ErrorBarEndStyle = {}));
      var a;
      ! function(t) {
        t[t.Both = 0] = "Both", t[t.Minus = 1] = "Minus", t[t.Plus = 2] = "Plus"
      }(a = i.ErrorBarDirection || (i.ErrorBarDirection = {}));
      var o = function(i) {
        function o(t) {
          var e = i.call(this) || this;
          return e._errorAmount = n.FixedValue, e._endStyle = r.Cap, e._direction = a.Both, e.rendering.addHandler(e._rendering, e), e.initialize(t), e
        }
        return __extends(o, i), Object.defineProperty(o.prototype, "value", {
          get: function() {
            return this._value
          },
          set: function(t) {
            t != this._value && (this._value = t, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "errorAmount", {
          get: function() {
            return this._errorAmount
          },
          set: function(e) {
            (e = t.asEnum(e, n, !0)) != this._errorAmount && (this._errorAmount = e, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "errorBarStyle", {
          get: function() {
            return this._errorBarStyle
          },
          set: function(t) {
            t != this._errorBarStyle && (this._errorBarStyle = t, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "endStyle", {
          get: function() {
            return this._endStyle
          },
          set: function(e) {
            (e = t.asEnum(e, r, !0)) != this._endStyle && (this._endStyle = e, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "direction", {
          get: function() {
            return this._direction
          },
          set: function(e) {
            (e = t.asEnum(e, a, !0)) != this._direction && (this._direction = e, this._invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), o.prototype.getDataRect = function(e, i) {
          if (!e) return null;
          this._chart;
          var r, a = this.errorAmount,
            o = 0,
            s = 0;
          this._paddings = [], this._calculateErrorValue();
          var u, l, c, h, f = this.getValues(0);
          if (!f) return e;
          for (c = 0, r = f.length; c < r; c++) {
            var _ = {
                plus: 0,
                val: 0,
                minus: 0
              },
              p = this._value || 0;
            switch (h = f[c], a) {
              case n.Custom:
                (_ = this._getCustomValue(c)).val = h, this._paddings.push(_);
                break;
              case n.FixedValue:
                this._paddings.push({
                  plus: p,
                  minus: p,
                  val: h
                });
                break;
              case n.Percentage:
                this._paddings.push({
                  plus: h * p,
                  minus: h * p,
                  val: h
                });
                break;
              case n.StandardDeviation:
                this._paddings.push({
                  plus: this._errorValue * p,
                  minus: this._errorValue * p,
                  val: h
                });
                break;
              case n.StandardError:
                this._paddings.push({
                  plus: this._errorValue,
                  minus: this._errorValue,
                  val: h
                })
            }(isNaN(u) || u > h - _.minus) && (u = h - _.minus), (isNaN(l) || l < h + _.plus) && (l = h + _.plus)
          }
          switch (a) {
            case n.FixedValue:
              o = p, s = p;
              break;
            case n.Percentage:
              o = u * p, s = l * p;
              break;
            case n.StandardDeviation:
              o = this._errorValue * p, s = this._errorValue * p;
              break;
            case n.StandardError:
              o = this._errorValue, s = this._errorValue
          }
          return this._showPlus && (l += s), this._showMinus && (u -= o), new t.Rect(e.left, u, e.width, l - u)
        }, o.prototype._getCustomValue = function(e) {
          var i, n = this.value,
            r = {
              minus: 0,
              val: 0,
              plus: 0
            };
          return null != this._minusBindingValues || null != this._plusBindingValues ? (r.minus = this._minusBindingValues && this._minusBindingValues[e] || 0, r.plus = this._plusBindingValues && this._plusBindingValues[e] || 0, r) : null == n ? r : (t.isArray(n) ? ((i = n[e]) && i.minus && (r.minus = i.minus), i && i.plus && (r.plus = i.plus)) : t.isNumber(n) ? (r.minus = n, r.plus = n) : (n.minus && (r.minus = n.minus), n.plus && (r.plus = n.plus)), r)
        }, o.prototype._calculateErrorValue = function() {
          var t = 0,
            e = 0,
            i = 0;
          if (this._errorAmount === n.StandardDeviation || this._errorAmount === n.StandardError) {
            var r = this.getValues(0);
            null != r && (r.forEach(function(i) {
              t += i, e++
            }), i = t / e, this._mean = i, t = 0, r.forEach(function(e) {
              t += Math.pow(e - i, 2)
            }), this._errorValue = Math.sqrt(t / (e - 1))), this._errorAmount == n.StandardError && (this._errorValue = this._errorValue / Math.sqrt(e))
          }
        }, o.prototype._clearValues = function() {
          this.__errorValue = null, this._mean = null, this._plusBindingValues = null, this._minusBindingValues = null, i.prototype._clearValues.call(this)
        }, o.prototype.getValues = function(t) {
          if (0 == t && this.errorAmount === n.Custom) {
            var e = this._getBinding(1),
              r = this._getBinding(2);
            if ((null == this._plusBindingValues || null == this._minusBindingValues) && e && r)
              if (null != this._cv) {
                if (e) {
                  a = this._bindValues(this._cv.items, e);
                  this._plusBindingValues = a.values
                }
                if (r) {
                  o = this._bindValues(this._cv.items, r);
                  this._minusBindingValues = o.values
                }
              } else if (null != this.binding && null != this._chart && null != this._chart.collectionView) {
                if (e) {
                  var a = this._bindValues(this._chart.collectionView.items, e);
                  this._plusBindingValues = a.values
                }
                if (r) {
                  var o = this._bindValues(this._chart.collectionView.items, r);
                  this._minusBindingValues = o.values
                }
              }
          }
          return i.prototype.getValues.call(this, t)
        }, Object.defineProperty(o.prototype, "_chart", {
          get: function() {
            return this.__chart
          },
          set: function(t) {
            t !== this.__chart && (this.__chart = t)
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "_errorValue", {
          get: function() {
            return this.__errorValue
          },
          set: function(t) {
            t != this.__errorValue && (this.__errorValue = t)
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "_showPlus", {
          get: function() {
            return this.direction === a.Both || this.direction === a.Plus
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "_showMinus", {
          get: function() {
            return this.direction === a.Both || this.direction === a.Minus
          },
          enumerable: !0,
          configurable: !0
        }), o.prototype._rendering = function(i, a) {
          var o = this;
          this._errorBarEles = [], a.cancel = !0;
          var s = this.chart,
            u = s._plotRect,
            l = this._getAxisY(),
            c = this._getAxisX(),
            h = (l.origin, a.engine),
            f = s.series.indexOf(this),
            _ = this._plotter;
          _.plotSeries(h, c, l, this, s, a.index, a.count, function(i) {
            var a, p, m, y = o._paddings,
              d = o._showPlus,
              g = o._showMinus,
              b = s._isRotated(),
              v = o.errorBarStyle && o.errorBarStyle["stroke-width"] || 2;
            m = (p = b ? c : l).actualMax, a = p.convert(m);
            var x = h.stroke,
              P = h.strokeWidth;
            h.stroke = "black", h.strokeWidth = 1, i && i.length && i.forEach(function(i, s) {
              if (null != i.x && null != i.y) {
                var l = y[s],
                  c = l && l.minus || 0,
                  x = l && l.plus || 0,
                  P = Math.abs(p.convert(m - c) - a),
                  w = Math.abs(p.convert(m + x) - a),
                  O = new t.Point(i.x, i.y),
                  S = new t.Point(i.x, i.y);
                b ? (o.errorAmount === n.StandardDeviation && (i = new t.Point(p.convert(o._mean), i.y), O.x = i.x, S.x = i.x), g && (O.x = O.x - P), d && (S.x = S.x + w)) : (o.errorAmount === n.StandardDeviation && (i = new t.Point(i.x, p.convert(o._mean)), O.y = i.y, S.y = i.y), g && (O.y = O.y + P), d && (S.y = S.y - w));
                var V = void 0;
                V = b ? new t.Rect(O.x, O.y - v, Math.abs(S.x - O.x), 2 * v) : new t.Rect(S.x - v, S.y, 2 * v, Math.abs(S.y - O.y));
                var M = new e._RectArea(V);
                M.ignoreLabel = !0;
                var L = new e._DataPoint(f, s, s, l.val);
                M.tag = L, _.hitTester.add(M, f);
                var j = [h.drawLine(Math.max(O.x, u.left), Math.min(O.y, u.bottom), Math.min(S.x, u.right), Math.max(S.y, u.top), "error-bar", o.errorBarStyle)];
                if (o._errorBarEles[s] = j, o.endStyle === r.Cap) {
                  if (d) {
                    var E = void 0;
                    b ? S.x <= u.right && (E = h.drawLine(S.x, S.y - v, S.x, S.y + v, "error-bar", o.errorBarStyle), j.push(E)) : S.y >= u.top && (E = h.drawLine(S.x - v, S.y, S.x + v, S.y, "error-bar", o.errorBarStyle), j.push(E))
                  }
                  if (g) {
                    var X = void 0;
                    b ? O.x >= u.left && (X = h.drawLine(O.x, O.y - v, O.x, O.y + v, "error-bar", o.errorBarStyle), j.push(X)) : O.y <= u.bottom && (X = h.drawLine(O.x - v, O.y, O.x + v, O.y, "error-bar", o.errorBarStyle), j.push(X))
                  }
                }
              }
            }), h.stroke = x, h.strokeWidth = P
          })
        }, o.prototype.getPlotElement = function(t) {
          if (this.hostElement && t < this._pointIndexes.length) {
            var e = null == this._errorBarEles[t] ? [] : this._errorBarEles[t].slice(),
              i = this._pointIndexes[t];
            return i < this.hostElement.childNodes.length && e.push(this.hostElement.childNodes[i]), e
          }
          return null
        }, o
      }(e.Series);
      i.ErrorBar = o
    }(e.analytics || (e.analytics = {}))
  }(t.chart || (t.chart = {}))
}(wijmo || (wijmo = {}));
