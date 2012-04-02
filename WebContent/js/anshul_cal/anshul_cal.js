function anshul_cal(name, mode, targetelement, multiselect) {
	var self = this;
	function calConfig() {
		self.displayYearInitial = self.curDate.getFullYear();
		self.displayMonthInitial = self.curDate.getMonth();
		self.displayYear = self.displayYearInitial;
		self.displayMonth = self.displayMonthInitial;
		self.minDate = new Date(2010, 0, 1);
		self.maxDate = new Date(2014, 11, 31);
		self.startDay = 0;
		self.showWeeks = true;
		self.selCurMonthOnly = true;
	}
	function setLang() {
		self.daylist = new Array('S', 'M', 'T', 'W', 'T', 'F', 'S', 'S', 'M',
				'T', 'W', 'T', 'F', 'S');
		self.months_sh = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
				'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
		self.monthup_title = 'Next month';
		self.monthdn_title = 'Previous month';
		self.clearbtn_caption = 'Clear';
		self.clearbtn_title = 'Clears selected dates';
		self.maxrange_caption = 'Maximum range';
		self.closebtn_caption = 'Close';
		self.closebtn_title = 'Close the calendar';
	}
	function setDays() {
		self.daynames = new Array();
		var j = 0;
		for ( var i = self.startDay; i < self.startDay + 7; i++) {
			self.daynames[j++] = self.daylist[i];
		}
		self.monthDayCount = new Array(31,
				((self.curDate.getFullYear() - 2000) % 4 ? 28 : 29), 31, 30,
				31, 30, 31, 31, 30, 31, 30, 31);
	}
	function createCalendar() {
		var tbody, tr, td;
		self.calendar = document.createElement('table');
		self.calendar.setAttribute('id', self.name + '_calendar');
		setClass(self.calendar, 'calendar');
		self.calendar.style.display = 'none';
		addEventHandler(self.calendar, 'selectstart', function() {
			return false;
		});
		addEventHandler(self.calendar, 'drag', function() {
			return false;
		});
		tbody = document.createElement('tbody');
		tr = document.createElement('tr');
		td = document.createElement('td');
		td.appendChild(createMainHeading());
		tr.appendChild(td);
		tbody.appendChild(tr);
		tr = document.createElement('tr');
		td = document.createElement('td');
		self.calendar.celltable = document.createElement('table');
		setClass(self.calendar.celltable, 'cells');
		self.calendar.celltable.appendChild(createDayHeading());
		self.calendar.celltable.appendChild(createCalCells());
		td.appendChild(self.calendar.celltable);
		tr.appendChild(td);
		tbody.appendChild(tr);
		tr = document.createElement('tr');
		td = document.createElement('td');
		td.appendChild(createFooter());
		tr.appendChild(td);
		tbody.appendChild(tr);
		self.calendar.appendChild(tbody);
		addEventHandler(self.calendar, 'mouseover', cal_onmouseover);
		addEventHandler(self.calendar, 'mouseout', cal_onmouseout);
	}
	function createMainHeading() {
		var container = document.createElement('div');
		setClass(container, 'mainheading');
		self.monthSelect = document.createElement('select');
		self.yearSelect = document.createElement('select');
		var monthDn = document.createElement('input'), monthUp = document
				.createElement('input');
		var opt, i;
		for (i = 0; i < 12; i++) {
			opt = document.createElement('option');
			opt.setAttribute('value', i);
			if (self.displayMonth == i) {
				opt.setAttribute('selected', 'selected');
			}
			opt.appendChild(document.createTextNode(self.months_sh[i]));
			self.monthSelect.appendChild(opt);
		}
		var yrMax = self.maxDate.getFullYear(), yrMin = self.minDate
				.getFullYear();
		for (i = yrMin; i <= yrMax; i++) {
			opt = document.createElement('option');
			opt.setAttribute('value', i);
			if (self.displayYear == i) {
				opt.setAttribute('selected', 'selected');
			}
			opt.appendChild(document.createTextNode(i));
			self.yearSelect.appendChild(opt);
		}
		monthUp.setAttribute('type', 'button');
		monthUp.setAttribute('value', '>');
		monthUp.setAttribute('title', self.monthup_title);
		monthDn.setAttribute('type', 'button');
		monthDn.setAttribute('value', '<');
		monthDn.setAttribute('title', self.monthdn_title);
		self.monthSelect.owner = self.yearSelect.owner = monthUp.owner = monthDn.owner = self;
		function selectonchange() {
			if (self.goToMonth(self.yearSelect.value, self.monthSelect.value)) {
				self.displayMonth = self.monthSelect.value;
				self.displayYear = self.yearSelect.value;
			} else {
				self.monthSelect.value = self.displayMonth;
				self.yearSelect.value = self.displayYear;
			}
		}
		addEventHandler(monthUp, 'click', function() {
			self.nextMonth();
		});
		addEventHandler(monthDn, 'click', function() {
			self.prevMonth();
		});
		addEventHandler(self.monthSelect, 'change', selectonchange);
		addEventHandler(self.yearSelect, 'change', selectonchange);
		container.appendChild(monthDn);
		container.appendChild(self.monthSelect);
		container.appendChild(self.yearSelect);
		container.appendChild(monthUp);
		return container;
	}
	function createFooter() {
		var container = document.createElement('div');
		var clearSelected = document.createElement('input');
		clearSelected.setAttribute('type', 'button');
		clearSelected.setAttribute('value', self.clearbtn_caption);
		clearSelected.setAttribute('title', self.clearbtn_title);
		clearSelected.owner = self;
		addEventHandler(clearSelected, 'click', function() {
			self.resetSelections(false);
		});
		container.appendChild(clearSelected);
		if (self.mode == 'popup') {
			var closeBtn = document.createElement('input');
			closeBtn.setAttribute('type', 'button');
			closeBtn.setAttribute('value', self.closebtn_caption);
			closeBtn.setAttribute('title', self.closebtn_title);
			addEventHandler(closeBtn, 'click', function() {
				self.hide();
			});
			setClass(closeBtn, 'closeBtn');
			container.appendChild(closeBtn);
		}
		return container;
	}
	function createDayHeading() {
		self.calHeading = document.createElement('thead');
		setClass(self.calHeading, 'caldayheading');
		var tr = document.createElement('tr'), th;
		self.cols = new Array(false, false, false, false, false, false, false);
		if (self.showWeeks) {
			th = document.createElement('th');
			setClass(th, 'wkhead');
			tr.appendChild(th);
		}
		for ( var dow = 0; dow < 7; dow++) {
			th = document.createElement('th');
			th.appendChild(document.createTextNode(self.daynames[dow]));
			if (self.selectMultiple) {
				th.headObj = new CalHeading(self, th,
						(dow + self.startDay < 7 ? dow + self.startDay : dow
								+ self.startDay - 7));
			}
			tr.appendChild(th);
		}
		self.calHeading.appendChild(tr);
		return self.calHeading;
	}
	function createCalCells() {
		self.rows = new Array(false, false, false, false, false, false);
		self.cells = new Array();
		var row = -1, totalCells = (self.showWeeks ? 48 : 42);
		var beginDate = new Date(self.displayYear, self.displayMonth, 1);
		var endDate = new Date(self.displayYear, self.displayMonth,
				self.monthDayCount[self.displayMonth]);
		var sdt = new Date(beginDate);
		sdt.setDate(sdt.getDate() + (self.startDay - beginDate.getDay())
				- (self.startDay - beginDate.getDay() > 0 ? 7 : 0));
		self.calCells = document.createElement('tbody');
		var tr, td;
		var cellIdx = 0, cell, week, dayval;
		for ( var i = 0; i < totalCells; i++) {
			if (self.showWeeks) {
				if (i % 8 == 0) {
					row++;
					week = sdt.getWeek(self.startDay);
					tr = document.createElement('tr');
					td = document.createElement('td');
					if (self.selectMultiple) {
						td.weekObj = new WeekHeading(self, td, week, row)
					} else {
						setClass(td, 'wkhead');
					}
					td.appendChild(document.createTextNode(week));
					tr.appendChild(td);
					i++;
				}
			} else if (i % 7 == 0) {
				row++;
				week = sdt.getWeek(self.startDay);
				tr = document.createElement('tr');
			}
			dayval = sdt.getDate();
			td = document.createElement('td');
			td.appendChild(document.createTextNode(dayval));
			cell = new CalCell(self, td, sdt, row, week);
			self.cells[cellIdx] = cell;
			td.cellObj = cell;
			tr.appendChild(td);
			self.calCells.appendChild(tr);
			self.reDraw(cellIdx++);
			sdt.setDate(dayval + 1);
		}
		return self.calCells;
	}
	function setMode(targetelement) {
		if (self.mode == 'popup') {
			self.calendar.style.position = 'absolute';
		}
		if (targetelement) {
			switch (self.mode) {
			case 'flat':
				self.tgt = targetelement;
				self.tgt.appendChild(self.calendar);
				self.visible = true;
				break;
			case 'popup':
				self.calendar.style.position = 'absolute';
				document.body.appendChild(self.calendar);
				self.setTarget(targetelement, false);
				break;
			}
		} else {
			document.body.appendChild(self.calendar);
			self.visible = false;
		}
	}
	function deleteCells() {
		self.calendar.celltable
				.removeChild(self.calendar.celltable.childNodes[1]);
	}
	function setClass(element, className) {
		element.setAttribute('class', className);
		element.setAttribute('className', className);
	}
	function setCellProperties(cellindex) {
		var cell = self.cells[cellindex];
		var date;
		idx = self.dateInArray(self.dates, cell.date);
		if (idx > -1) {
			date = self.dates[idx];
			cell.date.selected = date.selected || false;
			cell.date.type = date.type;
			cell.date.canSelect = date.canSelect;
			cell.setTitle(date.title);
			cell.setURL(date.href);
			cell.setHTML(date.cellHTML);
		} else {
			cell.date.selected = false;
		}
		if (cell.date.getTime() < self.minDate.getTime()
				|| cell.date.getTime() > self.maxDate.getTime()) {
			cell.date.canSelect = false;
		}
		cell.setClass();
	}
	function cal_onmouseover() {
		self.mousein = true;
	}
	function cal_onmouseout() {
		self.mousein = false;
	}
	function updateSelectedDates() {
		var idx = 0;
		self.selectedDates = new Array();
		for (i = 0; i < self.dates.length; i++) {
			if (self.dates[i].selected) {
				self.selectedDates[idx++] = self.dates[i];
			}
		}
	}
	self.dateInArray = function(arr, searchVal, startIndex) {
		startIndex = (startIndex != null ? startIndex : 0);
		for ( var i = startIndex; i < arr.length; i++) {
			if (searchVal.getUeDay() == arr[i].getUeDay()) {
				return i;
			}
		}
		return -1;
	};
	self.setTarget = function(targetelement, focus) {
		if (self.mode == 'popup') {
			function popupFocus() {
				self.show();
			}
			function popupBlur() {
				if (!self.mousein) {
					self.hide();
				}
			}
			function popupKeyDown() {
				self.hide();
			}
			if (self.tgt) {
				removeEventHandler(self.tgt, 'focus', popupFocus);
				removeEventHandler(self.tgt, 'blur', popupBlur);
				removeEventHandler(self.tgt, 'keydown', popupKeyDown);
			}
			self.tgt = targetelement;
			var dto = self.tgt.dateObj, pdateArr = new Array;
			if (dto) {
				if (self.tgt.value.length) {
					pdateArr[0] = dto;
				}
				self.goToMonth(dto.getFullYear(), dto.getMonth());
			}
			self.selectDates(pdateArr, true, true, true);
			self.topOffset = self.tgt.offsetHeight;
			self.leftOffset = 0;
			self.updatePos(self.tgt);
			addEventHandler(self.tgt, 'focus', popupFocus);
			addEventHandler(self.tgt, 'blur', popupBlur);
			addEventHandler(self.tgt, 'keydown', popupKeyDown);
			if (focus !== false) {
				popupFocus();
			}
		} else {
			if (self.tgt) {
				self.tgt.removeChild(self.calendar);
			}
			self.tgt = targetelement;
			self.tgt.appendChild(self.calendar);
			self.show();
		}
	};
	self.nextMonth = function() {
		var month = self.displayMonth;
		var year = self.displayYear;
		if (self.displayMonth < 11) {
			month++;
		} else if (self.yearSelect.value < self.maxDate.getFullYear()) {
			month = 0;
			year++;
		}
		return self.goToMonth(year, month);
	};
	self.prevMonth = function() {
		var month = self.displayMonth;
		var year = self.displayYear;
		if (self.displayMonth > 0) {
			month--;
		} else {
			month = 11;
			year--;
		}
		return self.goToMonth(year, month);
	};
	self.goToMonth = function(year, month) {
		var testdatemin = new Date(year, month, 31);
		var testdatemax = new Date(year, month, 1);
		if (testdatemin >= self.minDate && testdatemax <= self.maxDate) {
			self.monthSelect.value = self.displayMonth = month;
			self.yearSelect.value = self.displayYear = year;
			createCalCells();
			deleteCells();
			self.calendar.celltable.appendChild(self.calCells);
			return true;
		} else {
			alert(self.maxrange_caption);
			return false;
		}
	};
	self.updatePos = function(target) {
		if (self.mode == 'popup') {
			self.calendar.style.top = getTop(target) + self.topOffset + 'px';
			self.calendar.style.left = getLeft(target) + self.leftOffset + 'px';
		}
	};
	self.show = function() {
		self.updatePos(self.tgt);
		self.calendar.style.display = 'block';
		self.visible = true;
	};
	self.hide = function() {
		self.calendar.style.display = 'none';
		self.visible = false;
	};
	self.toggle = function() {
		self.visible ? self.hide() : self.show();
	};
	self.addDates = function(dates, redraw) {
		var i;
		for (i = 0; i < dates.length; i++) {
			if (self.dateInArray(self.dates, dates[i]) == -1) {
				self.dates[self.dates.length] = dates[i];
			}
		}
		updateSelectedDates();
		if (redraw != false) {
			self.reDraw();
		}
	};
	self.removeDates = function(dates, redraw) {
		var idx;
		for ( var i = 0; i < dates.length; i++) {
			idx = self.dateInArray(self.dates, dates[i]);
			if (idx != -1) {
				self.dates.splice(idx, 1);
			}
		}
		updateSelectedDates();
		if (redraw != false) {
			self.reDraw();
		}
	};
	self.selectDates = function(inpdates, selectVal, redraw, removeothers) {
		var i, idx;
		if (removeothers == true) {
			for (i = 0; i < self.dates.length; i++) {
				self.dates[i].selected = false;
			}
		}
		for (i = 0; i < inpdates.length; i++) {
			idx = self.dateInArray(self.dates, inpdates[i]);
			if (selectVal == true) {
				inpdates[i].selected = true;
				if (idx == -1) {
					self.dates[self.dates.length] = inpdates[i];
				} else {
					self.dates[idx].selected = true;
				}
			} else {
				if (idx > -1) {
					self.dates[idx].selected = inpdates[i].selected = false;
					if (self.dates[idx].type == 'normal') {
						self.dates.splice(idx, 1);
					}
				}
			}
		}
		updateSelectedDates();
		if (redraw != false) {
			self.reDraw();
		}
	};
	self.sendForm = function(form, inputname) {
		var inpname = inputname || 'anshul_dates', f, inp;
		f = (typeof (form) == 'string' ? document.getElementById(form) : form);
		if (!f) {
			alert('ERROR:Invalid form input');
			return false;
		}
		for ( var i = 0; i < self.dates.length; i++) {
			inp = document.createElement('input');
			inp.setAttribute('type', 'hidden');
			inp.setAttribute('name', inpname + '[' + i + ']');
			inp.setAttribute('value', encodeURIComponent(self.dates[i]
					.dateFormat('Y-m-d')));
			f.appendChild(inp);
		}
		return true;
	};
	self.resetSelections = function(retMonth) {
		var dateArray = new Array();
		var dt = self.dates;
		for ( var i = 0; i < dt.length; i++) {
			if (dt[i].selected) {
				dateArray[dateArray.length] = dt[i];
			}
		}
		self.selectDates(dateArray, false, false);
		self.rows = new Array(false, false, false, false, false, false, false);
		self.cols = new Array(false, false, false, false, false, false, false);
		if (self.mode == 'popup') {
			self.tgt.value = '';
			self.hide();
		}
		retMonth == true ? self.goToMonth(self.displayYearInitial,
				self.displayMonthInitial) : self.reDraw();
	};
	self.reDraw = function(index) {
		self.state = 1;
		var len = index ? index + 1 : self.cells.length;
		for ( var i = index || 0; i < len; i++) {
			setCellProperties(i);
		}
		self.state = 2;
	};
	self.getCellIndex = function(date) {
		for ( var i = 0; i < self.cells.length; i++) {
			if (self.cells[i].date.getUeDay() == date.getUeDay()) {
				return i;
			}
		}
		return -1;
	};
	self.state = 0;
	self.name = name;
	self.curDate = new Date();
	self.mode = mode;
	self.selectMultiple = (multiselect == true);
	self.dates = new Array();
	self.selectedDates = new Array();
	self.calendar;
	self.calHeading;
	self.calCells;
	self.rows;
	self.cols;
	self.cells = new Array();
	self.monthSelect;
	self.yearSelect;
	self.mousein = false;
	calConfig();
	setLang();
	setDays();
	createCalendar();
	targetelement = typeof (targetelement) == 'string' ? document.getElementById(targetelement) : targetelement;
	setMode(targetelement);
	self.state = 2;
	self.visible ? self.show() : self.hide();
}
function CalHeading(owner, tableCell, dayOfWeek) {
	function DayHeadingonclick() {
		var sdates = owner.dates;
		var cells = owner.cells;
		var dateArray = new Array();
		owner.cols[dayOfWeek] = !owner.cols[dayOfWeek];
		for ( var i = 0; i < cells.length; i++) {
			if (cells[i].dayOfWeek == dayOfWeek
					&& cells[i].date.canSelect
					&& (!owner.selCurMonthOnly || cells[i].date.getMonth() == owner.displayMonth
							&& cells[i].date.getFullYear() == owner.displayYear)) {
				dateArray[dateArray.length] = cells[i].date;
			}
		}
		owner.selectDates(dateArray, owner.cols[dayOfWeek], true);
	}
	var self = this;
	self.dayOfWeek = dayOfWeek;
	addEventHandler(tableCell, 'mouseup', DayHeadingonclick);
}
function WeekHeading(owner, tableCell, week, tableRow) {
	function weekHeadingonclick() {
		var cells = owner.cells;
		var sdates = owner.dates;
		var dateArray = new Array();
		owner.rows[tableRow] = !owner.rows[tableRow];
		for ( var i = 0; i < cells.length; i++) {
			if (cells[i].tableRow == tableRow
					&& cells[i].date.canSelect
					&& (!owner.selCurMonthOnly || cells[i].date.getMonth() == owner.displayMonth
							&& cells[i].date.getFullYear() == owner.displayYear)) {
				dateArray[dateArray.length] = cells[i].date;
			}
		}
		owner.selectDates(dateArray, owner.rows[tableRow], true);
	}
	var self = this;
	self.week = week;
	tableCell.setAttribute('class', 'wkhead');
	tableCell.setAttribute('className', 'wkhead');
	addEventHandler(tableCell, 'mouseup', weekHeadingonclick);
}
function CalCell(owner, tableCell, dateObj, row, week) {
	var self = this;
	function calCellonclick() {
		if (self.date.canSelect) {
			if (owner.selectMultiple == true) {
				owner.selectDates(new Array(self.date), !self.date.selected,
						false);
				self.setClass();
			} else {
				owner.selectDates(new Array(self.date), true, false, true);
				if (owner.mode == 'popup') {
					owner.tgt.value = self.date.dateFormat();
					owner.tgt.dateObj = new Date(self.date);
					owner.hide();
				}
				owner.reDraw();
			}
		}
	}
	function calCellonmouseover() {
		if (self.date.canSelect) {
			tableCell.setAttribute('class', self.cellClass + ' hover');
			tableCell.setAttribute('className', self.cellClass + ' hover');
		}
	}
	function calCellonmouseout() {
		self.setClass();
	}
	self.setClass = function() {
		if (self.date.canSelect !== false) {
			if (self.date.selected) {
				self.cellClass = 'cell_selected';
			} else if (owner.displayMonth != self.date.getMonth()) {
				self.cellClass = 'notmnth';
			} else if (self.date.type == 'holiday') {
				self.cellClass = 'hlday';
			} else if (self.dayOfWeek > 0 && self.dayOfWeek < 6) {
				self.cellClass = 'wkday';
			} else {
				self.cellClass = 'wkend';
			}
		} else {
			self.cellClass = 'noselect';
		}
		if (self.date.getUeDay() == owner.curDate.getUeDay()) {
			self.cellClass = self.cellClass + ' curdate';
		}
		tableCell.setAttribute('class', self.cellClass);
		tableCell.setAttribute('className', self.cellClass);
	};
	self.setURL = function(href, type) {
		if (href) {
			if (type == 'js') {
				addEventHandler(self.tableCell, 'mousedown', function() {
					window.location.href = href;
				});
			} else {
				var url = document.createElement('a');
				url.setAttribute('href', href);
				url.appendChild(document.createTextNode(self.date.getDate()));
				self.tableCell.replaceChild(url, self.tableCell.firstChild);
			}
		}
	};
	self.setTitle = function(titleStr) {
		if (titleStr && titleStr.length > 0) {
			self.title = titleStr;
			self.tableCell.setAttribute('title', titleStr);
		}
	};
	self.setHTML = function(html) {
		if (html && html.length > 0) {
			if (self.tableCell.childNodes[1]) {
				self.tableCell.childNodes[1].innerHTML = html;
			} else {
				var htmlCont = document.createElement('div');
				htmlCont.innerHTML = html;
				self.tableCell.appendChild(htmlCont);
			}
		}
	};
	self.cellClass;
	self.tableRow = row;
	self.tableCell = tableCell;
	self.date = new Date(dateObj);
	self.date.canSelect = true;
	self.date.type = 'normal';
	self.date.selected = false;
	self.date.cellHTML = '';
	self.dayOfWeek = self.date.getDay();
	self.week = week;
	addEventHandler(tableCell, 'click', calCellonclick);
	addEventHandler(tableCell, 'mouseover', calCellonmouseover);
	addEventHandler(tableCell, 'mouseout', calCellonmouseout);
	self.setClass();
}
Date.prototype.getDayOfYear = function() {
	return parseInt((this.getTime() - new Date(this.getFullYear(), 0, 1)
			.getTime()) / 86400000 + 1);
};
Date.prototype.getWeek = function(dowOffset) {
	dowOffset = typeof (dowOffset) == 'int' ? dowOffset : 0;
	var newYear = new Date(this.getFullYear(), 0, 1);
	var day = newYear.getDay() - dowOffset;
	day = (day >= 0 ? day : day + 7);
	var weeknum, daynum = Math
			.floor((this.getTime() - newYear.getTime() - (this
					.getTimezoneOffset() - newYear.getTimezoneOffset()) * 60000) / 86400000) + 1;
	if (day < 4) {
		weeknum = Math.floor((daynum + day - 1) / 7) + 1;
		if (weeknum > 52) {
			nYear = new Date(this.getFullYear() + 1, 0, 1);
			nday = nYear.getDay() - dowOffset;
			nday = nday >= 0 ? nday : nday + 7;
			weeknum = nday < 4 ? 1 : 53;
		}
	} else {
		weeknum = Math.floor((daynum + day - 1) / 7);
	}
	return weeknum;
};
Date.prototype.getUeDay = function() {
	return parseInt(Math
			.floor((this.getTime() - this.getTimezoneOffset() * 60000) / 86400000));
};
Date.prototype.dateFormat = function(format) {
	if (!format) {
		format = 'm/d/Y';//For data format
	}
	LZ = function(x) {
		return (x < 0 || x > 9 ? '' : '0') + x
	};
	var MONTH_NAMES = new Array('January', 'February', 'March', 'April', 'May',
			'June', 'July', 'August', 'September', 'October', 'November',
			'December', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug',
			'Sep', 'Oct', 'Nov', 'Dec');
	var DAY_NAMES = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday',
			'Thursday', 'Friday', 'Saturday', 'Sun', 'Mon', 'Tue', 'Wed',
			'Thu', 'Fri', 'Sat');
	var result = "";
	var i_format = 0;
	var c = "";
	var token = "";
	var y = this.getFullYear().toString();
	var M = this.getMonth() + 1;
	var d = this.getDate();
	var E = this.getDay();
	var H = this.getHours();
	var m = this.getMinutes();
	var s = this.getSeconds();
	value = {
		Y : y.toString(),
		y : y.substring(2),
		n : M,
		m : LZ(M),
		F : MONTH_NAMES[M - 1],
		M : MONTH_NAMES[M + 11],
		j : d,
		d : LZ(d),
		D : DAY_NAMES[E + 7],
		l : DAY_NAMES[E],
		G : H,
		H : LZ(H)
	};
	if (H == 0) {
		value['g'] = 12;
	} else if (H > 12) {
		value['g'] = H - 12;
	} else {
		value['g'] = H;
	}
	value['h'] = LZ(value['g']);
	if (H > 11) {
		value['a'] = 'pm';
		value['A'] = 'PM';
	} else {
		value['a'] = 'am';
		value['A'] = 'AM';
	}
	value['i'] = LZ(m);
	value['s'] = LZ(s);
	while (i_format < format.length) {
		c = format.charAt(i_format);
		token = "";
		while ((format.charAt(i_format) == c) && (i_format < format.length)) {
			token += format.charAt(i_format++);
		}
		if (value[token] != null) {
			result = result + value[token];
		} else {
			result = result + token;
		}
	}
	return result;
};
function addEventHandler(element, type, func) {
	if (element.addEventListener) {
		element.addEventListener(type, func, false);
	} else if (element.attachEvent) {
		element.attachEvent('on' + type, func);
	}
}
function removeEventHandler(element, type, func) {
	if (element.removeEventListener) {
		element.removeEventListener(type, func, false);
	} else if (element.attachEvent) {
		element.detachEvent('on' + type, func);
	}
}
function getTop(element) {
	var oNode = element;
	var iTop = 0;
	while (oNode.tagName != 'HTML') {
		iTop += oNode.offsetTop || 0;
		if (oNode.offsetParent) {
			oNode = oNode.offsetParent;
		} else {
			break;
		}
	}
	return iTop;
}
function getLeft(element) {
	var oNode = element;
	var iLeft = 0;
	while (oNode.tagName != 'HTML') {
		iLeft += oNode.offsetLeft || 0;
		if (oNode.offsetParent) {
			oNode = oNode.offsetParent;
		} else {
			break;
		}
	}
	return iLeft;
}
