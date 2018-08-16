﻿/*
 *
 * Wijmo Library 5.20182.500
 * http://wijmo.com/
 *
 * Copyright(c) GrapeCity, Inc.  All rights reserved.
 *
 * Licensed under the GrapeCity Commercial License.
 * sales@wijmo.com
 * wijmo.com/products/wijmo-5/license/
 *
 */
var wijmo;
! function(e) {
  ! function(t) {
    ! function(i) {
      "use strict";
      e._addCultureInfo("FlexGridDetailProvider", {
        ariaLabels: {
          toggleDetail: "Toggle Row Detail"
        }
      });
      var n;
      ! function(e) {
        e[e.None = 0] = "None", e[e.ToggleDetail = 1] = "ToggleDetail"
      }(n = i.KeyAction || (i.KeyAction = {}));
      var o;
      ! function(e) {
        e[e.Code = 0] = "Code", e[e.Selection = 1] = "Selection", e[e.ExpandSingle = 2] = "ExpandSingle", e[e.ExpandMulti = 3] = "ExpandMulti"
      }(o = i.DetailVisibilityMode || (i.DetailVisibilityMode = {}));
      var l = function() {
        function l(t, l) {
          var a = this;
          this._mode = o.ExpandSingle, this._animated = !1, this._keyActionEnter = n.None, this._g = t, t.mergeManager = new i.DetailMergeManager(t), t.rowHeaders.hostElement.addEventListener("click", this._hdrClick.bind(this)), t.rowHeaders.hostElement.addEventListener("mousedown", function(e) {
            var i = t.editableCollectionView;
            (t.activeEditor || i && i.currentEditItem) && (a._hdrClick(e), e.preventDefault())
          }), t.formatItem.addHandler(this._formatItem, this), t.selectionChanged.addHandler(this._selectionChanged, this), t.resizedRow.addHandler(this._resizedRow, this), t.loadingRows.addHandler(function() {
            a.hideDetail()
          }), t.draggingRow.addHandler(function(e, t) {
            t.row < e.rows.length - 1 && e.rows[t.row + 1] instanceof i.DetailRow && (t.cancel = !0, a.hideDetail(t.row))
          }), t.hostElement.addEventListener("keydown", function(t) {
            if (t.keyCode == e.Key.Enter && a._keyActionEnter == n.ToggleDetail) {
              var i = a._g.selection.row;
              a._toggleRowDetail(i) && t.preventDefault()
            }
          }, !0), l && e.copy(this, l)
        }
        return Object.defineProperty(l.prototype, "grid", {
          get: function() {
            return this._g
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(l.prototype, "detailVisibilityMode", {
          get: function() {
            return this._mode
          },
          set: function(t) {
            (t = e.asEnum(t, o)) != this._mode && (this._mode = t, this.hideDetail(), this._g.invalidate())
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(l.prototype, "maxHeight", {
          get: function() {
            return this._maxHeight
          },
          set: function(t) {
            this._maxHeight = e.asNumber(t, !0)
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(l.prototype, "isAnimated", {
          get: function() {
            return this._animated
          },
          set: function(t) {
            t != this._animated && (this._animated = e.asBoolean(t))
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(l.prototype, "keyActionEnter", {
          get: function() {
            return this._keyActionEnter
          },
          set: function(t) {
            this._keyActionEnter = e.asEnum(t, n)
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(l.prototype, "createDetailCell", {
          get: function() {
            return this._createDetailCellFn
          },
          set: function(t) {
            this._createDetailCellFn = e.asFunction(t, !0)
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(l.prototype, "disposeDetailCell", {
          get: function() {
            return this._disposeDetailCellFn
          },
          set: function(t) {
            this._disposeDetailCellFn = e.asFunction(t, !0)
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(l.prototype, "rowHasDetail", {
          get: function() {
            return this._rowHasDetailFn
          },
          set: function(t) {
            this._rowHasDetailFn = e.asFunction(t, !0)
          },
          enumerable: !0,
          configurable: !0
        }), l.prototype.getDetailRow = function(e) {
          e = this._toIndex(e);
          var t = this._g.rows;
          return t[e] instanceof i.DetailRow ? t[e] : e < t.length - 1 && t[e + 1] instanceof i.DetailRow ? t[e + 1] : null
        }, l.prototype.isDetailVisible = function(e) {
          return null != this.getDetailRow(e)
        }, l.prototype.isDetailAvailable = function(e) {
          return e = this._toIndex(e), this._hasDetail(e)
        }, l.prototype.hideDetail = function(t) {
          var n = this._g.rows;
          if (null != t) {
            !(n[t = this._toIndex(t)] instanceof i.DetailRow) && t < n.length - 1 && n[t + 1] instanceof i.DetailRow && t++;
            var o = n[t];
            o instanceof i.DetailRow && (this.disposeDetailCell && this.disposeDetailCell(o), e.Control.disposeAll(o.detail), n.removeAt(t))
          } else
            for (var l = 0; l < n.length; l++) n[l] instanceof i.DetailRow && this.hideDetail(l)
        }, l.prototype.showDetail = function(t, n) {
          void 0 === n && (n = !1);
          var o = this._g,
            l = o.rows;
          if ((t = this._toIndex(t)) > 0 && l[t] instanceof i.DetailRow && t--, n) {
            for (var a = o.selection, r = !1, s = 0; s < l.length - 1; s++) s != t && l[s + 1] instanceof i.DetailRow && (this.hideDetail(s), s < t && t--, s < a.row && (a.row--, a.row2--, r = !0));
            r && o.select(a, !1)
          }
          if (!this.isDetailVisible(t) && this._hasDetail(t)) {
            var c = new i.DetailRow(l[t]);
            if (c.detail = this._createDetailCell(l[t]), c.detail)
              if (l.insert(t + 1, c), this._animated) {
                var d = c.detail.style;
                d.transform = "translateY(-100%)", d.opacity = "0", e.animate(function(i) {
                  i < 1 ? (d.transform = "translateY(" + (100 * -(1 - i)).toFixed(0) + "%)", d.opacity = (i * i).toString()) : (d.transform = "", d.opacity = "", e.Control.invalidateAll(c.detail), o.scrollIntoView(t + 1, -1))
                })
              } else o.scrollIntoView(t + 1, -1)
          }
        }, l.prototype._toIndex = function(i) {
          return i instanceof t.Row && (i = i.index), e.asNumber(i, !1, !0)
        }, l.prototype._hdrClick = function(t) {
          if (!t.defaultPrevented && 0 == t.button && e.closestClass(t.target, l._WJC_DETAIL)) switch (this._mode) {
            case o.ExpandMulti:
            case o.ExpandSingle:
              var i = this._g,
                n = i.hitTest(t.target);
              n.panel || (n = i.hitTest(t)), n.panel && this._toggleRowDetail(n.row) && t.preventDefault()
          }
        }, l.prototype._toggleRowDetail = function(e) {
          if (e > -1 && this._hasDetail(e)) {
            if (this.isDetailVisible(e)) this.hideDetail(e);
            else {
              var i = this._g;
              i.select(new t.CellRange(e, 0, e, i.columns.length - 1)), this.showDetail(e, this._mode == o.ExpandSingle)
            }
            return !0
          }
          return !1
        }, l.prototype._selectionChanged = function(e, t) {
          var i = this;
          this._mode == o.Selection && (this._toSel && clearTimeout(this._toSel), this._toSel = setTimeout(function() {
            e.selection.row > -1 ? i.showDetail(e.selection.row, !0) : i.hideDetail()
          }, 300))
        }, l.prototype._formatItem = function(t, n) {
          var a = this._g,
            r = n.panel.rows[n.row];
          if (n.panel == a.cells && r instanceof i.DetailRow && null != r.detail && n.col == a.cells.columns.frozen)
            if (e.addClass(n.cell, "wj-detail"), n.cell.textContent = "", n.cell.style.textAlign = "", n.cell.appendChild(r.detail), null == r.height) {
              e.Control.refreshAll(n.cell);
              var s = getComputedStyle(n.cell),
                c = parseInt(s.paddingTop) + parseInt(s.paddingBottom),
                d = r.detail.scrollHeight + c;
              this._maxHeight > 0 && d > this._maxHeight && (d = this._maxHeight), r.height = d, r.detail.style.height || (r.detail.style.height = "100%");
              var u = r.detail.querySelector(".wj-flexgrid");
              u && !u.style.height && (u.style.height = "100%")
            } else setTimeout(function() {
              e.Control.refreshAll(r.detail)
            });
          if (n.panel == a.rowHeaders && 0 == n.col && this._hasDetail(n.row)) switch (n.cell.style.cursor = "", this._mode) {
            case o.ExpandMulti:
            case o.ExpandSingle:
              var h = n.cell,
                f = a.rows[n.row + 1] instanceof i.DetailRow,
                p = f ? "minus" : "plus",
                g = l._WJC_DETAIL;
              h.innerHTML = '<button class="wj-btn wj-btn-glyph ' + g + '" type="button" tabindex="-1"><span class="wj-glyph-' + p + '"></span></button>';
              var w = h.children[0],
                _ = e.culture.FlexGridDetailProvider.ariaLabels.toggleDetail;
              e.setAriaLabel(w, _), e.setAttribute(w, "aria-expanded", f)
          }
        }, l.prototype._resizedRow = function(t, n) {
          var o = n.panel.rows[n.row];
          o instanceof i.DetailRow && o.detail && e.Control.refreshAll(o.detail)
        }, l.prototype._hasDetail = function(t) {
          var i = this._g.rows[t];
          return e.isFunction(this._rowHasDetailFn) ? this._rowHasDetailFn(i) : this._isRegularRow(i)
        }, l.prototype._isRegularRow = function(e) {
          return !(e instanceof t.GroupRow || e instanceof t._NewRowTemplate)
        }, l.prototype._createDetailCell = function(e, t) {
          return this.createDetailCell ? this.createDetailCell(e, t) : null
        }, l._WJC_DETAIL = "wj-elem-detail", l
      }();
      i.FlexGridDetailProvider = l
    }(t.detail || (t.detail = {}))
  }(e.grid || (e.grid = {}))
}(wijmo || (wijmo = {}));
var __extends = this && this.__extends || function() {
    var e = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(e, t) {
        e.__proto__ = t
      } || function(e, t) {
        for (var i in t) t.hasOwnProperty(i) && (e[i] = t[i])
      };
    return function(t, i) {
      function n() {
        this.constructor = t
      }
      e(t, i), t.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(e) {
  ! function(e) {
    ! function(t) {
      "use strict";
      var i = function(i) {
        function n(e) {
          return i.call(this, e) || this
        }
        return __extends(n, i), n.prototype.getMergedRange = function(n, o, l, a) {
          switch (void 0 === a && (a = !0), n.cellType) {
            case e.CellType.Cell:
              if (n.rows[o] instanceof t.DetailRow) {
                var r = n.columns,
                  s = Math.min(r.length, r.frozen);
                return l < s ? new e.CellRange(o, 0, o, s - 1) : new e.CellRange(o, s, o, r.length - 1)
              }
              break;
            case e.CellType.RowHeader:
              if (n.rows[o] instanceof t.DetailRow) return new e.CellRange(o - 1, l, o, l);
              if (o < n.rows.length - 1 && n.rows[o + 1] instanceof t.DetailRow) return new e.CellRange(o, l, o + 1, l)
          }
          return i.prototype.getMergedRange.call(this, n, o, l, a)
        }, n
      }(e.MergeManager);
      t.DetailMergeManager = i
    }(e.detail || (e.detail = {}))
  }(e.grid || (e.grid = {}))
}(wijmo || (wijmo = {}));
var __extends = this && this.__extends || function() {
    var e = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(e, t) {
        e.__proto__ = t
      } || function(e, t) {
        for (var i in t) t.hasOwnProperty(i) && (e[i] = t[i])
      };
    return function(t, i) {
      function n() {
        this.constructor = t
      }
      e(t, i), t.prototype = null === i ? Object.create(i) : (n.prototype = i.prototype, new n)
    }
  }(),
  wijmo;
! function(e) {
  ! function(e) {
    ! function(t) {
      "use strict";
      var i = function(e) {
        function t(t) {
          var i = e.call(this) || this;
          return i.isReadOnly = !0, i
        }
        return __extends(t, e), Object.defineProperty(t.prototype, "detail", {
          get: function() {
            return this._detail
          },
          set: function(e) {
            this._detail = e
          },
          enumerable: !0,
          configurable: !0
        }), t
      }(e.Row);
      t.DetailRow = i
    }(e.detail || (e.detail = {}))
  }(e.grid || (e.grid = {}))
}(wijmo || (wijmo = {}));
