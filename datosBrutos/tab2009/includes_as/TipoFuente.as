package includes_as{

	import flash.text.TextFormat;

	public class TipoFuente {

		public var miFormato:TextFormat;
		private var miFuente:Object;
		
		public function TipoFuente(fuente:Object, tamano:int, color:int, negrita:Boolean) {
		
			miFuente = new Object();
			miFormato = new TextFormat();
			miFuente = fuente;			

			miFormato.font = miFuente.fontName;
			miFormato.color = color;
			miFormato.size = tamano;
			miFormato.bold = negrita;

		}
		
	}
	
}