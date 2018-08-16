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
var __extends = this && this.__extends || function() {
    var e = Object.setPrototypeOf || {
        __proto__: []
      }
      instanceof Array && function(e, t) {
        e.__proto__ = t
      } || function(e, t) {
        for (var o in t) t.hasOwnProperty(o) && (e[o] = t[o])
      };
    return function(t, o) {
      function r() {
        this.constructor = t
      }
      e(t, o), t.prototype = null === o ? Object.create(o) : (r.prototype = o.prototype, new r)
    }
  }(),
  wijmo;
! function(e) {
  ! function(t) {
    ! function(o) {
      "use strict";

      function r(t, o, i) {
        if (void 0 === i && (i = !1), o && t)
          for (var n in o) {
            var l = o[n],
              s = t[n];
            if (e.isObject(l)) {
              if (void 0 === s || !e.isObject(s) && i) {
                if (e.isFunction(l.clone)) {
                  t[n] = s = l.clone();
                  continue
                }
                t[n] = s = {}
              }
              e.isObject(s) && r(t[n], l, i)
            } else(void 0 === s || i && void 0 !== l) && (t[n] = l)
          }
        return t
      }
      var i;
      ! function(e) {
        e[e.ActualSize = 0] = "ActualSize", e[e.PageWidth = 1] = "PageWidth", e[e.SinglePage = 2] = "SinglePage"
      }(i = o.ScaleMode || (o.ScaleMode = {}));
      var n;
      ! function(e) {
        e[e.All = 0] = "All", e[e.Selection = 1] = "Selection"
      }(n = o.ExportMode || (o.ExportMode = {}));
      var l = function(t) {
        function o(o, r, i, n, l, s, a, h, d) {
          var c = t.call(this, o, r) || this;
          return c.cancelBorders = !1, c._cell = e.asType(i, HTMLElement, !0), c._canvas = n, c._clientRect = l, c._contentRect = s, c._textTop = a, c._style = h, c._getFormattedCell = d, c
        }
        return __extends(o, t), Object.defineProperty(o.prototype, "canvas", {
          get: function() {
            return this._canvas
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "cell", {
          get: function() {
            return this._cell
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "clientRect", {
          get: function() {
            return this._clientRect
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "contentRect", {
          get: function() {
            return this._contentRect
          },
          enumerable: !0,
          configurable: !0
        }), o.prototype.getFormattedCell = function() {
          return e.asFunction(this._getFormattedCell)()
        }, Object.defineProperty(o.prototype, "style", {
          get: function() {
            return this._style
          },
          enumerable: !0,
          configurable: !0
        }), Object.defineProperty(o.prototype, "textTop", {
          get: function() {
            return this._textTop
          },
          enumerable: !0,
          configurable: !0
        }), o
      }(e.grid.CellRangeEventArgs);
      o.PdfFormatItemEventArgs = l;
      var s, a = function() {
        function o() {}
        return o.draw = function(e, t, o, r, i) {
          this.drawToPosition(e, t, null, o, r, i)
        }, o.drawToPosition = function(t, o, n, l, s, a) {
          e.assert(!!t, "The flex argument cannot be null."), e.assert(!!o, "The doc argument cannot be null.");
          var h = r({}, a);
          r(h, this.DefaultDrawSettings), h.scaleMode = null == l ? i.ActualSize : null == s ? i.PageWidth : i.SinglePage, this._prepareGridAndDraw(t, o, n, l, s, h)
        }, o.export = function(t, o, i) {
          e.assert(!!t, "The flex argument cannot be null."), e.assert(!!o, "The fileName argument cannot be empty."), r(i = r({}, i), this.DefaultExportSettings);
          var n = i.documentOptions.ended;
          i.documentOptions.ended = function(t, r) {
            n && !1 === n.apply(l, [t, r]) || e.pdf.saveBlob(r.blob, o), t.dispose()
          };
          var l = new e.pdf.PdfDocument(i.documentOptions);
          this._prepareGridAndDraw(t, l, null, null, null, i, !0)
        }, o._prepareGridAndDraw = function(t, o, r, i, n, l, s) {
          void 0 === s && (s = !1);
          try {
            l.recalculateStarWidths && t.columns._updateStarSizes(e.pdf.ptToPx(o.width)), this._draw(t, o, r, i, n, l), s && o.end()
          } finally {
            l.recalculateStarWidths && t.invalidate(!0)
          }
        }, o._draw = function(o, r, i, n, l, a) {
          var h = null != i,
            d = new e.Size(r.width, r.height);
          i || (i = new e.Point(0, r.y)), e.isArray(a.embeddedFonts) && a.embeddedFonts.forEach(function(e) {
            r.registerFont(e)
          });
          var c = _.getSelection(o, a.exportMode);
          !a.drawDetailRows && t.detail && o.mergeManager && o.mergeManager instanceof t.detail.DetailMergeManager && (c = this._excludeDetailRows(c, o));
          var u = this._getGridRenderer(o, a, c, this.BorderWidth, !0),
            g = new e.Rect(i.x || 0, i.y || 0, n || d.width, l || d.height),
            p = this._getScaleFactor(u, a.scaleMode, g),
            f = this._getPages(u, c, g, a, h, p);
          (s = document.createElement("div")).setAttribute(t.FlexGrid._WJS_MEASURE, "true"), s.style.visibility = "hidden", o.hostElement.appendChild(s);
          try {
            for (var b = 0; b < f.length; b++) {
              b > 0 && r.addPage();
              var w = f[b],
                m = 0 === w.pageCol ? g.left : 0,
                y = 0 === w.pageRow ? g.top : 0;
              r.saveState(), r.paths.rect(0, 0, d.width, d.height).clip(), r.scale(p, p, new e.Point(m, y)), r.translate(m, y);
              var C = this._getGridRenderer(o, a, w.range, this.BorderWidth, b === f.length - 1);
              C.render(r), r.restoreState(), r.x = m, r.y = y + C.renderSize.height * p
            }
          } finally {
            s && (e.removeChild(s), s = null)
          }
        }, o._excludeDetailRows = function(e, o) {
          var r = [];
          return e.forEach(o.cells, function(e, o, i) {
            e instanceof t.detail.DetailRow || r.push(new t.CellRange(i, o.col, i, o.col2))
          }), new _(o, r)
        }, o._getScaleFactor = function(e, t, o) {
          var r = 1;
          if (t === i.ActualSize) return r;
          var n = e.renderSize;
          if (t === i.SinglePage)(l = Math.min(o.width / n.width, o.height / n.height)) < 1 && (r = l);
          else {
            var l = o.width / n.width;
            l < 1 && (r = l)
          }
          return r
        }, o._getPages = function(t, o, r, n, l, s) {
          var a = this,
            h = [],
            d = [],
            c = e.pdf.pxToPt,
            u = t.flex,
            p = t.showColumnHeader,
            f = t.showColumnFooter,
            b = t.showRowHeader,
            w = p ? c(u.columnHeaders.height) : 0,
            _ = f ? c(u.columnFooters.height) : 0,
            y = b ? c(u.rowHeaders.width) : 0,
            C = n.scaleMode === i.ActualSize || n.scaleMode === i.PageWidth,
            R = n.scaleMode === i.ActualSize,
            v = (r.width - r.left) * (1 / s),
            x = (r.height - r.top) * (1 / s),
            S = r.width * (1 / s),
            T = r.height * (1 / s),
            P = w + _,
            z = y,
            H = l && n.scaleMode == i.ActualSize;
          if (C) {
            var M = 0;
            o.forEach(u.cells, function(e, t, o, r) {
              var i = h.length ? T : x;
              if (g.isRenderableRow(e)) {
                var n = c(e.renderHeight);
                M++, P += n, (p || M > 1) && (P -= a.BorderWidth), P > i && (w + n > i || H ? (h.push(r), P = w) : (h.push(r - 1), P = w + n), p && (P -= a.BorderWidth))
              }
            })
          }
          var W = o.length() - 1;
          if (W < 0 && (W = 0), h.length && h[h.length - 1] === W || h.push(W), R)
            for (var A = 0, L = o.leftCol; L <= o.rightCol; L++) {
              var B = u.columns[L];
              if (B.isVisible) {
                var V = c(B.renderWidth),
                  j = d.length ? S : v;
                A++, z += V, (b || A > 1) && (z -= this.BorderWidth), z > j && (y + V > j || H ? (d.push(L), z = y) : (d.push(L - 1), z = y + V), b && (z -= this.BorderWidth))
              }
            }
          d.length && d[d.length - 1] === o.rightCol || d.push(o.rightCol);
          for (var O = [], F = !1, E = 1, D = l && n.maxPages > 0 ? 1 : n.maxPages, L = 0; L < h.length && !F; L++)
            for (var k = 0; k < d.length && !F; k++, E++)
              if (!(F = E > D)) {
                var G = 0 == L ? 0 : h[L - 1] + 1,
                  I = 0 == k ? o.leftCol : d[k - 1] + 1;
                O.push(new m(o.subrange(G, h[L] - G + 1, I, d[k]), k, L))
              }
          return O
        }, o._getGridRenderer = function(o, r, i, n, l) {
          return new(t.multirow && o instanceof t.multirow.MultiRow && c || t.sheet && o instanceof t.sheet.FlexSheet && d || e.olap && o instanceof e.olap.PivotGrid && u || h)(o, r, i, n, l)
        }, o.BorderWidth = 1, o.DefaultDrawSettings = {
          customCellContent: !1,
          drawDetailRows: !1,
          exportMode: n.All,
          maxPages: Number.MAX_VALUE,
          repeatMergedValuesAcrossPages: !0,
          recalculateStarWidths: !0,
          styles: {
            cellStyle: {
              font: new e.pdf.PdfFont,
              padding: 1.5,
              verticalAlign: "middle"
            },
            headerCellStyle: {
              font: {
                weight: "bold"
              }
            }
          }
        }, o.DefaultExportSettings = r({
          scaleMode: i.PageWidth,
          documentOptions: {
            compress: !1,
            pageSettings: {
              margins: {
                left: 36,
                right: 36,
                top: 18,
                bottom: 18
              }
            }
          }
        }, o.DefaultDrawSettings), o
      }();
      o.FlexGridPdfConverter = a;
      var h = function() {
          function o(e, o, r, i, n) {
            this._flex = e, this._borderWidth = i, this._lastPage = n, this._settings = o || {}, this._topLeft = new p(this, e.topLeftCells, this.showRowHeader && this.showColumnHeader ? new _(e, [new t.CellRange(0, 0, e.topLeftCells.rows.length - 1, e.topLeftCells.columns.length - 1)]) : new _(e, []), i), this._rowHeader = new p(this, e.rowHeaders, this.showRowHeader ? r.clone(0, e.rowHeaders.columns.length - 1) : new _(e, []), i), this._columnHeader = new p(this, e.columnHeaders, this.showColumnHeader ? new _(e, [new t.CellRange(0, r.leftCol, e.columnHeaders.rows.length - 1, r.rightCol)]) : new _(e, []), i), this._cells = new p(this, e.cells, r, i), this._bottomLeft = new p(this, e.bottomLeftCells, this.showRowHeader && this.showColumnFooter ? new _(e, [new t.CellRange(0, 0, e.bottomLeftCells.rows.length - 1, e.bottomLeftCells.columns.length - 1)]) : new _(e, []), i), this._columnFooter = new p(this, e.columnFooters, this.showColumnFooter ? new _(e, [new t.CellRange(0, r.leftCol, e.columnFooters.rows.length - 1, r.rightCol)]) : new _(e, []), i)
          }
          return Object.defineProperty(o.prototype, "settings", {
            get: function() {
              return this._settings
            },
            enumerable: !0,
            configurable: !0
          }), o.prototype.render = function(e) {
            var t = Math.max(0, Math.max(this._topLeft.renderSize.width, this._rowHeader.renderSize.width) - this._borderWidth),
              o = Math.max(0, Math.max(this._topLeft.renderSize.height, this._columnHeader.renderSize.height) - this._borderWidth);
            this._topLeft.render(e, 0, 0), this._rowHeader.render(e, 0, o), this._columnHeader.render(e, t, 0), this._cells.render(e, t, o), o = Math.max(0, o + this._cells.renderSize.height - this._borderWidth), this._bottomLeft.render(e, 0, o), this._columnFooter.render(e, t, o)
          }, Object.defineProperty(o.prototype, "flex", {
            get: function() {
              return this._flex
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "renderSize", {
            get: function() {
              var t = Math.max(this._topLeft.renderSize.height, this._columnHeader.renderSize.height) + Math.max(this._rowHeader.renderSize.height, this._cells.renderSize.height) + Math.max(this._bottomLeft.renderSize.height, this._columnFooter.renderSize.height),
                o = Math.max(this._topLeft.renderSize.width, this._rowHeader.renderSize.width) + Math.max(this._columnHeader.renderSize.width, this._cells.renderSize.width);
              return this._columnHeader.visibleRows > 0 && (t -= this._borderWidth), this._columnFooter.visibleRows > 0 && (t -= this._borderWidth), this._rowHeader.visibleColumns > 0 && (o -= this._borderWidth), new e.Size(o, t)
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "showColumnHeader", {
            get: function() {
              return !!(this._flex.headersVisibility & t.HeadersVisibility.Column)
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "showRowHeader", {
            get: function() {
              return !!(this._flex.headersVisibility & t.HeadersVisibility.Row)
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "showColumnFooter", {
            get: function() {
              return this._lastPage && this._flex.columnFooters.rows.length > 0
            },
            enumerable: !0,
            configurable: !0
          }), o.prototype.alignMergedTextToTheTopRow = function(e) {
            return !1
          }, o.prototype.getCellValue = function(e, t, o) {
            return e.getCellData(o, t, !0)
          }, o.prototype.getColumn = function(e, t, o) {
            return e.columns[t]
          }, o.prototype.isAlternatingRow = function(e) {
            return e.index % 2 != 0
          }, o.prototype.isGroupRow = function(e) {
            return e instanceof t.GroupRow && e.hasChildren
          }, o.prototype.isMergeableCell = function(e, t) {
            return !0
          }, o.prototype.getCellStyle = function(e, o, i) {
            var n = this.settings.styles,
              l = r({}, n.cellStyle),
              s = this._flex;
            switch (e.cellType) {
              case t.CellType.Cell:
                this.isGroupRow(o) ? r(l, n.groupCellStyle, !0) : this.isAlternatingRow(o) && r(l, n.altCellStyle, !0);
                break;
              case t.CellType.ColumnHeader:
              case t.CellType.RowHeader:
              case t.CellType.TopLeft:
              case t.CellType.BottomLeft:
                r(l, n.headerCellStyle, !0);
                break;
              case t.CellType.ColumnFooter:
                r(l, n.headerCellStyle, !0), r(l, n.footerCellStyle, !0)
            }
            return !this.settings.customCellContent && s._getShowErrors() && s._getError(e, o.index, i.index) && r(l, n.errorCellStyle, !0), l
          }, o
        }(),
        d = function(o) {
          function i(e, t, r, i, n) {
            return o.call(this, e, t, r, i, n) || this
          }
          return __extends(i, o), i.prototype.getCellValue = function(e, r, i) {
            return e.cellType === t.CellType.Cell ? e.rows[i] instanceof t.sheet.HeaderRow ? this.flex.columnHeaders.getCellData(i, r, !0) : this.flex.getCellValue(i, r, !0) : o.prototype.getCellValue.call(this, e, r, i)
          }, i.prototype.getCellStyle = function(t, i, n) {
            var l = o.prototype.getCellStyle.call(this, t, i, n),
              s = this.flex.selectedSheet.findTable(i.index, n.index);
            if (s) {
              var a = s.getRange(),
                h = i.index - a.topRow,
                d = n.index - a.leftCol,
                c = s._getTableCellAppliedStyles(h, d);
              c && (c.font = new e.pdf.PdfFont(c.fontFamily, e.pdf._asPt(c.fontSize, !0, void 0), c.fontStyle, c.fontWeight)), r(l, c, !0)
            }
            return l
          }, Object.defineProperty(i.prototype, "showColumnHeader", {
            get: function() {
              return !1
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(i.prototype, "showRowHeader", {
            get: function() {
              return !1
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(i.prototype, "showColumnFooter", {
            get: function() {
              return !1
            },
            enumerable: !0,
            configurable: !0
          }), i
        }(h),
        c = function(e) {
          function o(t, o, r, i, n) {
            return e.call(this, t, o, r, i, n) || this
          }
          return __extends(o, e), o.prototype.getColumn = function(e, t, o) {
            return this.flex.getBindingColumn(e, o, t)
          }, o.prototype.isAlternatingRow = function(o) {
            return o instanceof t.multirow._MultiRow ? o.dataIndex % 2 != 0 : e.prototype.isAlternatingRow.call(this, o)
          }, o.prototype.isMergeableCell = function(e, t) {
            return !0
          }, o
        }(h),
        u = function(e) {
          function o(t, o, r, i, n) {
            return e.call(this, t, o, r, i, n) || this
          }
          return __extends(o, e), o.prototype.alignMergedTextToTheTopRow = function(e) {
            return !this.flex.centerHeadersVertically && (e.cellType === t.CellType.ColumnHeader || e.cellType === t.CellType.RowHeader)
          }, o
        }(h),
        g = function() {
          function o(e, t) {
            this._panel = e, this._range = t.clone()
          }
          return o.isRenderableRow = function(e) {
            return e.isVisible && !(e instanceof t._NewRowTemplate)
          }, Object.defineProperty(o.prototype, "visibleRows", {
            get: function() {
              var e = this;
              return null == this._visibleRows && (this._visibleRows = 0, this._range.forEach(this._panel, function(t) {
                e.isRenderableRow(t) && e._visibleRows++
              })), this._visibleRows
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "visibleColumns", {
            get: function() {
              if (null == this._visibleColumns && (this._visibleColumns = 0, this._range.isValid))
                for (var e = this._range.leftCol; e <= this._range.rightCol; e++) this._panel.columns[e].isVisible && this._visibleColumns++;
              return this._visibleColumns
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "size", {
            get: function() {
              if (null == this._size) {
                var t = this._range.getRenderSize(this._panel);
                this._size = new e.Size(e.pdf.pxToPt(t.width), e.pdf.pxToPt(t.height))
              }
              return this._size
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "range", {
            get: function() {
              return this._range
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "panel", {
            get: function() {
              return this._panel
            },
            enumerable: !0,
            configurable: !0
          }), o.prototype.isRenderableRow = function(e) {
            return o.isRenderableRow(e)
          }, o
        }(),
        p = function(o) {
          function r(e, t, r, i) {
            var n = o.call(this, t, r) || this;
            return n._gr = e, n._borderWidth = i, n
          }
          return __extends(r, o), Object.defineProperty(r.prototype, "gr", {
            get: function() {
              return this._gr
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(r.prototype, "renderSize", {
            get: function() {
              return null == this._renderSize && (this._renderSize = this.size.clone(), this.visibleColumns > 1 && (this._renderSize.width -= this._borderWidth * (this.visibleColumns - 1)), this.visibleRows > 1 && (this._renderSize.height -= this._borderWidth * (this.visibleRows - 1))), this._renderSize
            },
            enumerable: !0,
            configurable: !0
          }), r.prototype.getRangeWidth = function(t, o) {
            for (var r = 0, i = 0, n = this.panel, l = t; l <= o; l++) {
              var s = n.columns[l];
              s.isVisible && (i++, r += s.renderWidth)
            }
            return r = e.pdf.pxToPt(r), i > 1 && (r -= this._borderWidth * (i - 1)), r
          }, r.prototype.getRangeHeight = function(t, o) {
            for (var r = 0, i = 0, n = this.panel, l = t; l <= o; l++) {
              var s = n.rows[l];
              this.isRenderableRow(s) && (i++, r += s.renderHeight)
            }
            return r = e.pdf.pxToPt(r), i > 1 && (r -= this._borderWidth * (i - 1)), r
          }, r.prototype.render = function(t, o, r) {
            var i = this,
              n = this.range,
              l = this.panel,
              s = new b(this._gr.flex),
              a = new w(l, 0, 0, 0, 0),
              h = new f(this, t, this._borderWidth);
            if (n.isValid) {
              for (var d = {}, c = n.leftCol; c <= n.rightCol; c++) d[c] = r;
              n.forEach(l, function(t, r, c) {
                if (i.isRenderableRow(t))
                  for (var u = o, g = n.leftCol; g <= n.rightCol; g++) {
                    var p, f = i.gr.getColumn(l, g, c),
                      b = void 0,
                      w = void 0,
                      _ = !1,
                      m = void 0;
                    if (f.isVisible) {
                      var y = i._getCellValue(g, c),
                        C = null;
                      if (i.gr.isMergeableCell(f, t) && (C = s.getMergedRange(l, c, g)))
                        if (a.copyFrom(C), C.topRow !== C.bottomRow) C.firstVisibleRow === c || c === r.topRow ? (_ = !0, p = i.gr.settings.repeatMergedValuesAcrossPages ? y : C.firstVisibleRow === c ? y : "", b = i.getRangeHeight(c, Math.min(C.bottomRow, r.bottomRow)), w = i.getRangeWidth(g, g)) : w = i.getRangeWidth(g, g);
                        else {
                          _ = !0, p = i.gr.settings.repeatMergedValuesAcrossPages ? y : g === C.leftCol ? y : "", b = i.getRangeHeight(c, c), w = i.getRangeWidth(Math.max(n.leftCol, C.leftCol), Math.min(n.rightCol, C.rightCol)), m = Math.min(n.rightCol, C.rightCol);
                          for (var R = g + 1; R <= m; R++) d[R] += b - i._borderWidth
                        } else a.setRange(c, g, c, g), _ = !0, p = y, b = i.getRangeHeight(c, c), w = i.getRangeWidth(g, g);
                      _ && h.renderCell(p, t, f, a, new e.Rect(u, d[g], w, b)), b && (d[g] += b - i._borderWidth), w && (u += w - i._borderWidth), m && (g = m)
                    }
                  }
              })
            }
          }, r.prototype._getCellValue = function(e, o) {
            var r = this.panel,
              i = this.gr.getCellValue(r, e, o),
              n = r.columns[e].isContentHtml;
            if (!i && r.cellType === t.CellType.Cell) {
              var l = r.rows[o];
              l instanceof t.GroupRow && l.dataItem && l.dataItem.groupDescription && e === r.columns.firstVisibleIndex && (n = !0, i = l.getGroupHeader())
            }
            return n && (this._cvtHtml || (this._cvtHtml = document.createElement("div")), this._cvtHtml.innerHTML = i, i = this._cvtHtml.textContent), i
          }, r
        }(g),
        f = function() {
          function o(e, t, o) {
            this._pr = e, this._area = t, this._borderWidth = o
          }
          return o.prototype.renderCell = function(o, r, i, n, a) {
            var h, d = r.grid,
              c = this._pr.panel,
              u = function() {
                var e = n.topRow,
                  t = n.leftCol,
                  o = c.getCellElement(e, t);
                return o || (s.innerHTML = "", s.className = "", s.style.cssText = "", s.style.visibility = "hidden", d.cellFactory.updateCell(c, e, t, s)), o || s
              },
              g = !!this._pr.gr.settings.customCellContent,
              p = null,
              f = this._pr.gr.getCellStyle(c, r, i);
            if (g && (p = u()), g && !(o = p.textContent.trim()) && this._isBooleanCell(i, r, c) && (o = this._extractCheckboxValue(p) + ""), g) {
              var b = function(e) {
                return e.className = e.className.replace("wj-state-selected", ""), e.className = e.className.replace("wj-state-multi-selected", ""), window.getComputedStyle(e)
              }(p);
              f.color = b.color, f.backgroundColor = b.backgroundColor, f.borderColor = b.borderColor || b.borderRightColor || b.borderBottomColor || b.borderLeftColor || b.borderTopColor, f.font = new e.pdf.PdfFont(b.fontFamily, e.pdf._asPt(b.fontSize, !0, void 0), b.fontStyle, b.fontWeight), f.textAlign = b.textAlign
            }
            if (f.boxSizing = "border-box", f.borderWidth = this._borderWidth, f.borderStyle = "solid", f.textAlign || r instanceof t.GroupRow && !i.aggregate || (f.textAlign = i.getAlignment()), c.cellType === t.CellType.Cell && d.rows.maxGroupLevel >= 0 && n.leftCol === d.columns.firstVisibleIndex) {
              var w = r instanceof t.GroupRow ? Math.max(r.level, 0) : d.rows.maxGroupLevel + 1,
                _ = e.pdf._asPt(f.paddingLeft || f.padding),
                m = e.pdf.pxToPt(w * d.treeIndent);
              f.paddingLeft = _ + m
            }
            var y, C = this._measureCell(o, i, r, c, f, a),
              R = n.rowSpan > 1 && n.visibleRowsCount > 1 && this._pr.gr.alignMergedTextToTheTopRow(c);
            R && (y = new e.Rect(C.contentRect.left, C.contentRect.top, C.contentRect.width, C.contentRect.height / (n.visibleRowsCount || 1)), C.textRect = this._calculateTextRect(o, i, r, c, y, f)), e.isFunction(this._pr.gr.settings.formatItem) && ((h = new l(c, n, p, this._area, C.rect, C.contentRect, C.textRect.top, f, function() {
              return p || u()
            })).data = o, this._pr.gr.settings.formatItem(h), h.data !== o && (o = e.asString(h.data), C.textRect = this._calculateTextRect(o, i, r, c, R ? y : C.contentRect, f))), this._renderCell(o, r, i, n, C, f, !h || !h.cancel, !h || !h.cancelBorders)
          }, o.prototype._renderCell = function(e, t, o, r, i, n, l, s) {
            (l || s) && (this._isBooleanCellAndValue(e, o, t, this._pr.panel) ? this._renderBooleanCell(e, i, n, l, s) : this._renderTextCell(e, i, n, l, s))
          }, o.prototype._isBooleanCellAndValue = function(e, t, o, r) {
            return this._isBooleanCell(t, o, r) && this._isBoolean(e)
          }, o.prototype._isBooleanCell = function(o, r, i) {
            return o.dataType === e.DataType.Boolean && i.cellType === t.CellType.Cell && !this._pr.gr.isGroupRow(r)
          }, o.prototype._isBoolean = function(t) {
            var o = e.isString(t) && t.toLowerCase();
            return "true" === o || "false" === o || !0 === t || !1 === t
          }, o.prototype._measureCell = function(t, o, r, i, n, l) {
            this._decompositeStyle(n);
            var s = l.left,
              a = l.top,
              h = l.height,
              d = l.width,
              c = this._parseBorder(n),
              u = c.left.width,
              g = c.top.width,
              p = c.bottom.width,
              f = c.right.width,
              b = this._parsePadding(n),
              w = 0,
              _ = 0,
              m = 0,
              y = 0;
            if ("content-box" === n.boxSizing || void 0 === n.boxSizing) w = b.top + h + b.bottom, _ = b.left + d + b.right, m = h, y = d;
            else {
              if ("border-box" !== n.boxSizing) throw "Invalid value: " + n.boxSizing;
              e.pdf._IE && n instanceof CSSStyleDeclaration ? (w = b.top + b.bottom + h, _ = b.left + b.right + d) : (w = h - g - p, _ = d - u - f), m = w - b.top - b.bottom, y = _ - b.left - b.right
            }
            var l = new e.Rect(s, a, d, h),
              C = new e.Rect(s + u, a + g, _, w),
              R = new e.Rect(s + u + b.left, a + g + b.top, y, m);
            return {
              rect: l,
              clientRect: C,
              contentRect: R,
              textRect: this._calculateTextRect(t, o, r, i, R, n)
            }
          }, o.prototype._decompositeStyle = function(e) {
            if (e) {
              var t;
              (t = e.borderColor) && (e.borderLeftColor || (e.borderLeftColor = t), e.borderRightColor || (e.borderRightColor = t), e.borderTopColor || (e.borderTopColor = t), e.borderBottomColor || (e.borderBottomColor = t)), (t = e.borderWidth) && (e.borderLeftWidth || (e.borderLeftWidth = t), e.borderRightWidth || (e.borderRightWidth = t), e.borderTopWidth || (e.borderTopWidth = t), e.borderBottomWidth || (e.borderBottomWidth = t)), (t = e.borderStyle) && (e.borderLeftStyle || (e.borderLeftStyle = t), e.borderRightStyle || (e.borderRightStyle = t), e.borderTopStyle || (e.borderTopStyle = t), e.borderBottomStyle || (e.borderBottomStyle = t)), (t = e.padding) && (e.paddingLeft || (e.paddingLeft = t), e.paddingRight || (e.paddingRight = t), e.paddingTop || (e.paddingTop = t), e.paddingBottom || (e.paddingBottom = t))
            }
          }, o.prototype._parseBorder = function(t) {
            var o = {
              left: {
                width: 0
              },
              top: {
                width: 0
              },
              bottom: {
                width: 0
              },
              right: {
                width: 0
              }
            };
            return "none" !== t.borderLeftStyle && (o.left = {
              width: e.pdf._asPt(t.borderLeftWidth),
              style: t.borderLeftStyle,
              color: t.borderLeftColor
            }), "none" !== t.borderTopStyle && (o.top = {
              width: e.pdf._asPt(t.borderTopWidth),
              style: t.borderTopStyle,
              color: t.borderTopColor
            }), "none" !== t.borderBottomStyle && (o.bottom = {
              width: e.pdf._asPt(t.borderBottomWidth),
              style: t.borderBottomStyle,
              color: t.borderBottomColor
            }), "none" !== t.borderRightStyle && (o.right = {
              width: e.pdf._asPt(t.borderRightWidth),
              style: t.borderRightStyle,
              color: t.borderRightColor
            }), o
          }, o.prototype._parsePadding = function(t) {
            return {
              left: e.pdf._asPt(t.paddingLeft),
              top: e.pdf._asPt(t.paddingTop),
              bottom: e.pdf._asPt(t.paddingBottom),
              right: e.pdf._asPt(t.paddingRight)
            }
          }, o.prototype._renderEmptyCell = function(t, o, r, i) {
            var n = t.rect.left,
              l = t.rect.top,
              s = t.clientRect.width,
              a = t.clientRect.height,
              h = t.clientRect.left - t.rect.left,
              d = t.clientRect.top - t.rect.top,
              c = t.rect.top + t.rect.height - (t.clientRect.top + t.clientRect.height),
              u = t.rect.left + t.rect.width - (t.clientRect.left + t.clientRect.width);
            if (i && (h || u || c || d)) {
              var g = o.borderLeftColor || o.borderColor,
                p = o.borderRightColor || o.borderColor,
                f = o.borderTopColor || o.borderColor,
                b = o.borderBottomColor || o.borderColor;
              if (h && d && c && u && h === u && h === c && h === d && g === p && g === b && g === f) {
                var w = h,
                  _ = w / 2;
                this._area.paths.rect(n + _, l + _, s + w, a + w).stroke(new e.pdf.PdfPen(g, w))
              } else h && this._area.paths.polygon([
                [n, l],
                [n + h, l + d],
                [n + h, l + d + a],
                [n, l + d + a + c]
              ]).fill(g), d && this._area.paths.polygon([
                [n, l],
                [n + h, l + d],
                [n + h + s, l + d],
                [n + h + s + u, l]
              ]).fill(f), u && this._area.paths.polygon([
                [n + h + s + u, l],
                [n + h + s, l + d],
                [n + h + s, l + d + a],
                [n + h + s + u, l + d + a + c]
              ]).fill(p), c && this._area.paths.polygon([
                [n, l + d + a + c],
                [n + h, l + d + a],
                [n + h + s, l + d + a],
                [n + h + s + u, l + d + a + c]
              ]).fill(b)
            }
            r && o.backgroundColor && s > 0 && a > 0 && this._area.paths.rect(n + h, l + d, s, a).fill(o.backgroundColor)
          }, o.prototype._renderBooleanCell = function(t, o, r, i, n) {
            if (this._renderEmptyCell(o, r, i, n), i) {
              var l = o.textRect.left,
                s = o.textRect.top,
                a = o.textRect.height;
              if (this._area.paths.rect(l, s, a, a).fillAndStroke(e.Color.fromRgba(255, 255, 255), new e.pdf.PdfPen(void 0, .5)), !0 === e.changeType(t, e.DataType.Boolean, "")) {
                var h = a / 20,
                  d = a - .5 - 2 * h,
                  c = a / 8;
                this._area.document.saveState(), this._area.translate(l + .25 + h, s + .25 + h).paths.moveTo(c / 2, .6 * d).lineTo(d - .6 * d, d - c).lineTo(d - c / 2, c / 2).stroke(new e.pdf.PdfPen(void 0, c)), this._area.document.restoreState()
              }
            }
          }, o.prototype._renderTextCell = function(t, o, r, i, n) {
            this._renderEmptyCell(o, r, i, n), i && t && this._area.drawText(t, o.textRect.left, o.textRect.top, {
              brush: r.color,
              font: r.font,
              height: o.textRect.height,
              width: o.textRect.width,
              align: "center" === r.textAlign ? e.pdf.PdfTextHorizontalAlign.Center : "right" === r.textAlign ? e.pdf.PdfTextHorizontalAlign.Right : "justify" === r.textAlign ? e.pdf.PdfTextHorizontalAlign.Justify : e.pdf.PdfTextHorizontalAlign.Left
            })
          }, o.prototype._calculateTextRect = function(e, t, o, r, i, n) {
            var l = i.clone();
            if (this._isBooleanCellAndValue(e, t, o, r)) {
              var s = this._getTextLineHeight(n.font);
              switch (n.verticalAlign) {
                case "middle":
                  l.top = i.top + i.height / 2 - s / 2;
                  break;
                case "bottom":
                  l.top = i.top + i.height - s
              }
              switch (n.textAlign) {
                case "justify":
                case "center":
                  l.left = i.left + i.width / 2 - s / 2;
                  break;
                case "right":
                  l.left = i.left + i.width - s
              }
              l.height = l.width = s
            } else if (l.height > 0 && l.width > 0) {
              switch (n.verticalAlign) {
                case "bottom":
                  (a = this._area.measureText(e, n.font, {
                    height: l.height,
                    width: l.width
                  })).size.height < l.height && (l.top += l.height - a.size.height, l.height = a.size.height);
                  break;
                case "middle":
                  var a = this._area.measureText(e, n.font, {
                    height: l.height,
                    width: l.width
                  });
                  a.size.height < l.height && (l.top += l.height / 2 - a.size.height / 2, l.height = a.size.height)
              }
              t.wordWrap || (l.height = this._getTextLineHeight(n.font))
            }
            return l
          }, o.prototype._extractCheckboxValue = function(e) {
            var t = e.querySelector("input.wj-cell-check[type=checkbox]");
            if (t) {
              var o = window.getComputedStyle(t);
              if ("none" !== o.display && "hidden" !== o.visibility) return t.checked
            }
          }, o.prototype._getTextLineHeight = function(e) {
            return this._area.lineHeight(e)
          }, o
        }(),
        b = function() {
          function e(e) {
            this._columns = {}, this._flex = e
          }
          return e.prototype.getMergedRange = function(e, t, o) {
            var r = this._columns[o];
            if (r && t >= r.topRow && t <= r.bottomRow) return r;
            var i = this._flex.getMergedRange(e, t, o, !1);
            return this._columns[o] = i ? new w(e, i) : null
          }, e
        }(),
        w = function(e) {
          function o(o, r, i, n, l) {
            var s = this;
            (s = r instanceof t.CellRange ? e.call(this, r.row, r.col, r.row2, r.col2) || this : e.call(this, r, i, n, l) || this).firstVisibleRow = -1, s.visibleRowsCount = 0;
            var a = s.topRow,
              h = s.bottomRow,
              d = o.rows.length;
            if (d > 0)
              for (var c = a; c <= h && c < d; c++) o.rows[c].isVisible && (s.firstVisibleRow < 0 && (s.firstVisibleRow = c), s.visibleRowsCount++);
            return s
          }
          return __extends(o, e), o.prototype.copyFrom = function(e) {
            this.setRange(e.row, e.col, e.row2, e.col2), this.firstVisibleRow = e.firstVisibleRow, this.visibleRowsCount = e.visibleRowsCount
          }, o
        }(t.CellRange),
        _ = function() {
          function o(e, t) {
            this._flex = e, this._ranges = t || []
          }
          return o.getSelection = function(e, r) {
            var i = [];
            if (r === n.All) i.push(new t.CellRange(0, 0, e.rows.length - 1, e.columns.length - 1));
            else {
              var l = e.selection;
              switch (e.selectionMode) {
                case t.SelectionMode.None:
                  break;
                case t.SelectionMode.Cell:
                case t.SelectionMode.CellRange:
                  i.push(l);
                  break;
                case t.SelectionMode.Row:
                  i.push(new t.CellRange(l.topRow, 0, l.topRow, e.cells.columns.length - 1));
                  break;
                case t.SelectionMode.RowRange:
                  i.push(new t.CellRange(l.topRow, 0, l.bottomRow, e.cells.columns.length - 1));
                  break;
                case t.SelectionMode.ListBox:
                  for (var s = -1, a = 0; a < e.rows.length; a++) e.rows[a].isSelected ? (s < 0 && (s = a), a === e.rows.length - 1 && i.push(new t.CellRange(s, 0, a, e.cells.columns.length - 1))) : (s >= 0 && i.push(new t.CellRange(s, 0, a - 1, e.cells.columns.length - 1)), s = -1)
              }
            }
            return new o(e, i)
          }, o.prototype.length = function() {
            for (var e = 0, t = 0; t < this._ranges.length; t++) {
              var o = this._ranges[t];
              o.isValid && (e += o.bottomRow - o.topRow + 1)
            }
            return e
          }, Object.defineProperty(o.prototype, "isValid", {
            get: function() {
              return this._ranges.length && this._ranges[0].isValid
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "leftCol", {
            get: function() {
              return this._ranges.length ? this._ranges[0].leftCol : -1
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(o.prototype, "rightCol", {
            get: function() {
              return this._ranges.length ? this._ranges[0].rightCol : -1
            },
            enumerable: !0,
            configurable: !0
          }), o.prototype.clone = function(e, t) {
            for (var r = [], i = 0; i < this._ranges.length; i++) {
              var n = this._ranges[i].clone();
              arguments.length > 0 && (n.col = e), arguments.length > 1 && (n.col2 = t), r.push(n)
            }
            return new o(this._flex, r)
          }, o.prototype.getRenderSize = function(t) {
            for (var o = new e.Size(0, 0), r = 0; r < this._ranges.length; r++) {
              var i = this._ranges[r].getRenderSize(t);
              o.width = Math.max(o.width, i.width), o.height += i.height
            }
            return o
          }, o.prototype.forEach = function(e, t) {
            for (var o = 0, r = 0; r < this._ranges.length; r++) {
              var i = this._ranges[r];
              if (i.isValid)
                for (var n = i.topRow; n <= i.bottomRow; n++) t(e.rows[n], i, n, o++)
            }
          }, o.prototype.subrange = function(e, r, i, n) {
            var l = [];
            if (e >= 0 && r > 0)
              for (var s = 0, a = 0, h = 0; h < this._ranges.length && r > 0; h++, s = a + 1) {
                var d = this._ranges[h];
                if (a = s + (d.bottomRow - d.topRow), !(e > a)) {
                  var c = e > s ? d.topRow + (e - s) : d.topRow,
                    u = Math.min(d.bottomRow, c + r - 1),
                    g = arguments.length > 2 ? i : d.leftCol,
                    p = arguments.length > 2 ? n : d.rightCol;
                  l.push(new t.CellRange(c, g, u, p)), r -= u - c + 1
                }
              }
            return new o(this._flex, l)
          }, o
        }(),
        m = function() {
          function e(e, t, o) {
            this._col = t, this._row = o, this._range = e
          }
          return Object.defineProperty(e.prototype, "range", {
            get: function() {
              return this._range
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(e.prototype, "pageCol", {
            get: function() {
              return this._col
            },
            enumerable: !0,
            configurable: !0
          }), Object.defineProperty(e.prototype, "pageRow", {
            get: function() {
              return this._row
            },
            enumerable: !0,
            configurable: !0
          }), e
        }()
    }(t.pdf || (t.pdf = {}))
  }(e.grid || (e.grid = {}))
}(wijmo || (wijmo = {}));
