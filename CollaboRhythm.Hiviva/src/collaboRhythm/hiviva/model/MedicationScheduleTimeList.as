package collaboRhythm.hiviva.model
{
	import feathers.data.ListCollection;

	public class MedicationScheduleTimeList
	{

		public static function timeList():ListCollection
		{
			var listCollection:ListCollection = new ListCollection(

					[
						{text: "00.00"},
						{text: "01.00"},
						{text: "02.00"},
						{text: "03.00"},
						{text: "04.00"},
						{text: "05.00"},
						{text: "06.00"},
						{text: "07.00"},
						{text: "08.00"},
						{text: "09.00"},
						{text: "10.00"},
						{text: "11.00"},
						{text: "12.00"},
						{text: "13.00"},
						{text: "14.00"},
						{text: "15.00"},
						{text: "16.00"},
						{text: "17.00"},
						{text: "18.00"},
						{text: "19.00"},
						{text: "20.00"},
						{text: "21.00"},
						{text: "22.00"},
						{text: "23.00"}
					]);
			return listCollection;
		}
	}
}
