package includes_as{

	import fl.controls.listClasses.CellRenderer;
	import fl.controls.listClasses.ICellRenderer;

	public class AlternarColoresCelda extends CellRenderer implements ICellRenderer {

		public function AlternarColoresCelda():void {

			super();

		}

		public static function getStyleDefinition():Object {

			return CellRenderer.getStyleDefinition();

		}

		override protected function drawBackground():void {

			switch (data.simbolo) {
				
				case "1" :

					setStyle("upSkin", CellRenderer_upSkinPurple);
					//trace("FALTA EL ACTA")
					break;

				case "2" :
				
					setStyle("upSkin", CellRenderer_upSkinGreen);
					//trace("DIFERENCIA ENTRE NUMEROS Y LETRAS")
					break;
					
				case "3" :
				
					setStyle("upSkin", CellRenderer_upSkinOrange);
					//trace("ACTA NO LEGIBLE")
					break;
				
				case "4" :
				
					setStyle("upSkin", CellRenderer_upSkinGray);
					//trace("ANULADA TET")
					break;

				default :

					if (_listData.index%2==0) {

						setStyle("upSkin", CellRenderer_upSkinBrown);

					} else {

						setStyle("upSkin", CellRenderer_upSkinDarkBrown);

					}
					
					break;

			}


			/*
			if (_listData.index % 2 == 0) {
			
			    setStyle("upSkin", CellRenderer_upSkinGray);
			
			 } else {
			
			     setStyle("upSkin", CellRenderer_upSkinDarkGray);
			
			 }
			 */

			super.drawBackground();

		}

	}

}