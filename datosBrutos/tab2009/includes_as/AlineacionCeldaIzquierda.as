package includes_as{
	
    import fl.controls.listClasses.CellRenderer;
	import fl.controls.listClasses.ICellRenderer;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;

    public class AlineacionCeldaIzquierda extends CellRenderer implements ICellRenderer {
		
        private var tf:TextFormat;

        public function AlineacionCeldaIzquierda() {
			
            tf = new TextFormat();
			
            tf.align = TextFormatAlign.LEFT;
			
        }

        override protected function drawLayout():void {
			
            textField.width = this.width;
			
            textField.setTextFormat(tf);
			
            super.drawLayout();
			
        }
		
		public static function getStyleDefinition():Object {
			
            return CellRenderer.getStyleDefinition();
			
        }

        override protected function drawBackground():void {
			
            if (_listData.index % 2 == 0) {
				
                setStyle("upSkin", CellRenderer_upSkinBrown);
								
            } else {
				
                setStyle("upSkin", CellRenderer_upSkinDarkBrown);
				
            }			
			
            super.drawBackground();
			
        }
		
    }
	
}
