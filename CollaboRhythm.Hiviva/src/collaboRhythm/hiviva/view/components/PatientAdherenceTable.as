package collaboRhythm.hiviva.view.components
{
	import collaboRhythm.hiviva.global.HivivaThemeConstants;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.utils.HivivaModifier;
	import collaboRhythm.hiviva.view.HivivaStartup;
	import collaboRhythm.hiviva.view.Main;
	import collaboRhythm.hiviva.view.media.Assets;

	import feathers.controls.Button;

	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import feathers.core.FeathersControl;
	import feathers.layout.TiledColumnsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.text.BitmapFontTextFormat;

	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;

	import source.themes.HivivaTheme;

	import starling.display.BlendMode;
	import starling.display.DisplayObject;

	import starling.display.Image;
	import starling.display.Quad;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	import starling.utils.deg2rad;
	import starling.utils.rad2deg;

	public class PatientAdherenceTable extends FeathersControl
	{
		private var _medications:XMLList;
		private var _history:Dictionary;
		private var _dayRow:Sprite;
		private const _weekDays:Array = ["M", "T", "W", "T", "F", "S", "S"];
		private var _firstColumnWidth:Number;
		private var _firstRowHeight:Number;
		private var _dataColumnsWidth:Number;
		private var _tableStartY:Number;
		private var _mainScrollContainer:ScrollContainer;
		private var _rowsData:Array = [];
		private var _dataContainer:Sprite;
		private var _medicineNamesContainer:Sprite;
		private var _currWeekBeginning:Date;
		private var _dailyTolerabilityData:Array;
		private var _patientData:XML;
		private var _scale:Number = 1;
		private var _wholeTableBg:Sprite;

		public function PatientAdherenceTable()
		{
			super();
		}

		override protected function draw():void
		{
			super.draw();

			this._firstColumnWidth = this.actualWidth * 0.35;
			this._dataColumnsWidth = (this.actualWidth * 0.65) / 8;
		}

		override protected function initialize():void
		{
			super.initialize();
		}

		private function extractHistory():void
		{
			_history = new Dictionary();
			var medicationLength:int = this._medications.length();
			var medicationSchedule:XMLList;
			var medicationScheduleLength:int;
			var referenceDate:Number;
			var medicationId:String;
			for (var i:int = 0; i < medicationLength; i++)
			{
				medicationSchedule = this._medications[i].Schedule.DCMedicationSchedule as XMLList;
				medicationId = _medications[i].MedicationID;

				medicationScheduleLength = medicationSchedule.length();
				for (var j:int = 0; j < medicationScheduleLength; j++)
				{
					referenceDate = HivivaModifier.getDateFromIsoString(String(medicationSchedule[j].DateTaken)).getTime();
					if (_history[referenceDate] == undefined) _history[referenceDate] = [];
					_history[referenceDate].push({id:medicationId,data:medicationSchedule[j]});
				}
			}
		}

		public function drawTable():void
		{
			initDayRow();
			initDayRowBg();
		}

		private function initDayRow():void
		{
			// day names row
			var firstRowPadding:Number = this.actualHeight * 0.02;
			_dayRow = new Sprite();
			addChild(_dayRow);

			var dayLabel:Label;
			for (var dayCount:int = 0; dayCount < 8; dayCount++)
			{
				dayLabel = new Label();
				dayLabel.name = HivivaThemeConstants.PATIENT_DATA_LIGHTER_LABEL;
				dayLabel.width = this._dataColumnsWidth;
				dayLabel.x = this._firstColumnWidth + (this._dataColumnsWidth * dayCount);
				dayLabel.y = firstRowPadding;
				dayLabel.text = this._weekDays[dayCount];
				_dayRow.addChild(dayLabel);
				dayLabel.validate();
			}
			// need to validate for row height
			this._firstRowHeight = _dayRow.height + (firstRowPadding * 2);
			this._tableStartY = this._firstRowHeight;
		}

		private function initTableContainer():void
		{
			if(this._mainScrollContainer != null) this._mainScrollContainer.removeChildren(0,-1,true);

			this._mainScrollContainer = new ScrollContainer();
			addChild(this._mainScrollContainer);
			this._mainScrollContainer.y = this._tableStartY;

			var vLayout:VerticalLayout = new VerticalLayout();
			vLayout.hasVariableItemDimensions = true;
			this._mainScrollContainer.layout = vLayout;
		}

		private function initTableDataContainer():void
		{
			if(this._dataContainer != null) this._dataContainer.removeChildren(0,-1,true);

			this._dataContainer = new Sprite();
			this._mainScrollContainer.addChild(this._dataContainer);
			this._dataContainer.x = this._firstColumnWidth;
		}

		private function initMedicineNamesColumn():void
		{
			this._rowsData = [];
			// names column
			var medLength:uint = _medications.length();
			var medicationCell:MedicationCell;
			var medicationId:String;
			var medIds:Array = [];
			var medExists:Boolean;
			for (var medCount:int = 0; medCount < medLength; medCount++)
			{
				medicationId = _medications[medCount].MedicationID;
				medExists = false;
				for (var i:int = 0; i < medIds.length; i++)
				{
					if(medIds[i] == medicationId)
					{
						medExists = true;
						break;
					}
				}
				if(!medExists)
				{
					medicationCell = new MedicationCell();
					medicationCell.scale = this._scale;
					medicationCell.brandName = HivivaModifier.getBrandName(_medications[medCount].MedicationName);
					medicationCell.genericName = HivivaModifier.getGenericName(_medications[medCount].MedicationName);
					this._mainScrollContainer.addChild(medicationCell);
					medicationCell.width = this._firstColumnWidth;

					medIds.push(medicationId);
					this._rowsData.push({id: medicationId});
				}
			}
			// tolerability row name

			var tolerabilityRowHolder:Sprite = new Sprite();
			this._mainScrollContainer.addChild(tolerabilityRowHolder);

			var tolerabilityRowLabel:Label = new Label();
			tolerabilityRowLabel.text = "Tolerability";
			tolerabilityRowHolder.addChild(tolerabilityRowLabel);
			tolerabilityRowLabel.textRendererProperties.textFormat = new BitmapFontTextFormat(TextField.getBitmapFont("engraved-lighter-bold"), 24 * this.scale, Color.WHITE);
			tolerabilityRowLabel.x = 30 * this.scale; // MedicationCell gap * 2
			tolerabilityRowLabel.y = 15 * this.scale; // MedicationCell gap
			tolerabilityRowLabel.width = this._firstColumnWidth - tolerabilityRowLabel.x;
			tolerabilityRowLabel.validate();

			var tolerabilityRowBg:Quad = new Quad(this._firstColumnWidth, tolerabilityRowLabel.height + (30 * this.scale), 0x000000);
			tolerabilityRowBg.alpha = 0;
			tolerabilityRowHolder.addChild(tolerabilityRowBg);

			this._rowsData.push({id: medLength});

			this._mainScrollContainer.validate();

			var maxHeight:Number = this.actualHeight - this._tableStartY;
			if (maxHeight < this._mainScrollContainer.height) this._mainScrollContainer.height = maxHeight;
			this._mainScrollContainer.layout = null;
		}

		private function recordRowHeights():void
		{
			var rowsDataLength:int = this._rowsData.length;
			var rowData:Object;
			var cellY:Number = 0;
			var rowLabel:DisplayObject;
			for (var rowCount:int = 0; rowCount < rowsDataLength; rowCount++)
			{
				rowLabel = this._mainScrollContainer.getChildAt(rowCount) as DisplayObject;
				rowData = this._rowsData[rowCount];

				rowData.y = cellY;
				rowData.cellHeight = rowLabel.height;
				cellY += rowLabel.height;
			}
		}

		public function updateTableData():void
		{
			this._medications = _patientData.DCUserMedication as XMLList;
			extractHistory();

			initTableContainer();

			initMedicineNamesColumn();
			recordRowHeights();

			initTableDataContainer();

			populateAdherence();
			populateTolerability();
			initHorizontalLines();

			if(_wholeTableBg == null) {
				initTableBgColours();
				initVerticalLines();
			}
		}

		private function populateAdherence():void
		{
			var rowData:Object;
			var currWeekDay:Date = new Date(this._currWeekBeginning.getFullYear(), this._currWeekBeginning.getMonth(),
					this._currWeekBeginning.getDate(), 0, 0, 0, 0);
			var columnData:Array;
			var columnDataLength:int;
			var columnXML:XML;
			var cell:Sprite;
			var tickTexture:Texture = Assets.getTexture("TickPng");
			var crossTexture:Texture = Assets.getTexture("CrossPng");

			this._dailyTolerabilityData = [];

			for (var rowCount:int = 0; rowCount < this._rowsData.length - 1; rowCount++)
			{
				rowData = this._rowsData[rowCount];
				for (var dayCount:int = 0; dayCount < 7; dayCount++)
				{
					columnData = _history[currWeekDay.getTime()];
					if (columnData != null)
					{
						columnDataLength = columnData.length;
						for (var i:int = 0; i < columnDataLength; i++)
						{
							if (columnData[i].id == rowData.id)
							{
								columnXML = columnData[i].data;
								cell = createCell(rowData.cellHeight, this._dataColumnsWidth * dayCount, rowData.y);
								this._dataContainer.addChild(cell);

								var tickCrossImage:Image = new Image(String(columnXML.PercentTaken) ==
										"100" ? tickTexture : crossTexture);
								cell.addChild(tickCrossImage);
								tickCrossImage.x = (cell.width * 0.5) - (tickCrossImage.width * 0.5);
								tickCrossImage.y = (cell.height * 0.5) - (tickCrossImage.height * 0.5);

								this._dailyTolerabilityData.push({day: dayCount, value: int(columnXML.Tolerability)});
							}
						}
					}
					currWeekDay.date++;
				}
				currWeekDay = new Date(this._currWeekBeginning.getFullYear(), this._currWeekBeginning.getMonth(),
						this._currWeekBeginning.getDate(), 0, 0, 0, 0);
			}
		}

		private function populateTolerability():void
		{
			var rowData:Object = this._rowsData[this._rowsData.length - 1];
			var cell:Sprite;
			var medicationTolerability:Number = 0;
			var medicationTolerabilityCount:int = 0;

			for (var dayCount:int = 0; dayCount < 7; dayCount++)
			{
				if(this._dailyTolerabilityData.length > 0)
				{
					for (var tolCount:int = 0; tolCount < this._dailyTolerabilityData.length; tolCount++)
					{
						if(this._dailyTolerabilityData[tolCount].day == dayCount)
						{
							medicationTolerability += this._dailyTolerabilityData[tolCount].value;
							medicationTolerabilityCount++;
						}
					}

					cell = createCell(rowData.cellHeight, this._dataColumnsWidth * dayCount, rowData.y);
					this._dataContainer.addChild(cell);

					var cellLabel:Label = new Label();
					cellLabel.width = this._dataColumnsWidth;
					cellLabel.name = HivivaThemeConstants.PATIENT_DATA_LIGHTER_LABEL;
					cellLabel.text = String(int(medicationTolerability / medicationTolerabilityCount));
					cell.addChild(cellLabel);
					cellLabel.validate();
					cellLabel.y = (cell.height * 0.5) - (cellLabel.height * 0.5);

					medicationTolerability = 0;
					medicationTolerabilityCount = 0;
				}
			}
		}

		private function createCell(cellHeight:Number, cellX:Number, cellY:Number):Sprite
		{
			var cell:Sprite = new Sprite();
			cell.x = cellX;
			cell.y = cellY;

			var cellBg:Quad = new Quad(this._dataColumnsWidth,cellHeight,0x000000);
			cellBg.alpha = 0;
			cell.addChild(cellBg);

			return cell;
		}

		private function initTableBgColours():void
		{
			_wholeTableBg = new Sprite();
			_wholeTableBg.y = this._mainScrollContainer.y;
			addChildAt(_wholeTableBg, 0);

			var tableBgColour:Quad = new Quad(this.actualWidth, this._mainScrollContainer.height, 0x4c5f76);
			tableBgColour.alpha = 0.1;
			tableBgColour.blendMode = BlendMode.MULTIPLY;
			_wholeTableBg.addChild(tableBgColour);

			var firstColumnGrad:Quad = new Quad(this._firstColumnWidth, this._mainScrollContainer.height, 0x233448);
			firstColumnGrad.setVertexAlpha(0, 0);
			firstColumnGrad.setVertexAlpha(1, 1);
			firstColumnGrad.setVertexAlpha(2, 0);
			firstColumnGrad.setVertexAlpha(3, 1);
			firstColumnGrad.alpha = 0.1;
			_wholeTableBg.addChild(firstColumnGrad);

			var lastColumnGrad:Quad = new Quad(this._firstColumnWidth, this._mainScrollContainer.height, 0x233448);
			lastColumnGrad.setVertexAlpha(0, 1);
			lastColumnGrad.setVertexAlpha(1, 0);
			lastColumnGrad.setVertexAlpha(2, 1);
			lastColumnGrad.setVertexAlpha(3, 0);
			lastColumnGrad.x = this._firstColumnWidth + (this._dataColumnsWidth * 7);
			lastColumnGrad.alpha = 0.1;
			_wholeTableBg.addChild(lastColumnGrad);
		}

		private function initDayRowBg():void
		{
			var horizLineTexture:Texture = Main.assets.getTexture("header_line");
			var horizontalLine:Image;

			var dayRowGrad:Quad = new Quad(this.actualWidth, this._firstRowHeight);
			dayRowGrad.setVertexColor(0, 0xFFFFFF);
			dayRowGrad.setVertexColor(1, 0xFFFFFF);
			dayRowGrad.setVertexColor(2, 0x293d54);
			dayRowGrad.setVertexColor(3, 0x293d54);
			dayRowGrad.alpha = 0.2;
			this._dayRow.addChildAt(dayRowGrad, 0);

			horizontalLine = new Image(horizLineTexture);
			horizontalLine.y = this._firstRowHeight;
			horizontalLine.width = this.actualWidth;
			this._dayRow.addChildAt(horizontalLine, 1);
		}

		private function initVerticalLines():void
		{
			var vertLineTexture:Texture = Assets.getTexture("VerticleLinePng");
			var verticalLine:Image;
			for (var dayCount:int = 0; dayCount < 8; dayCount++)
			{
				verticalLine = new Image(vertLineTexture);
				verticalLine.x = this._firstColumnWidth + (this._dataColumnsWidth * dayCount);
//				verticalLine.y = this._weekNavHolder.height;
				verticalLine.height = this._firstRowHeight + this._mainScrollContainer.height;
				addChild(verticalLine);
			}
		}

		private function initHorizontalLines():void
		{
			var horizLineTexture:Texture = Main.assets.getTexture("header_line");
			var horizontalLine:Image;
			var rowData:Object;
			for (var rowCount:int = 0; rowCount < this._rowsData.length; rowCount++)
			{
				rowData = this._rowsData[rowCount];
				horizontalLine = new Image(horizLineTexture);
				horizontalLine.y = rowData.y;
				horizontalLine.width = this.actualWidth;
				this._mainScrollContainer.addChild(horizontalLine);
			}
			horizontalLine = new Image(horizLineTexture);
			horizontalLine.y = rowData.y + rowData.cellHeight;
			horizontalLine.width = this.actualWidth;
			this._mainScrollContainer.addChild(horizontalLine);
		}

		public function get patientData():XML
		{
			return _patientData;
		}

		public function set patientData(value:XML):void
		{
			_patientData = value;
		}

		public function get scale():Number
		{
			return _scale;
		}

		public function set scale(value:Number):void
		{
			_scale = value;
		}

		public function get currWeekBeginning():Date
		{
			return _currWeekBeginning;
		}

		public function set currWeekBeginning(value:Date):void
		{
			_currWeekBeginning = value;
		}
	}
}
