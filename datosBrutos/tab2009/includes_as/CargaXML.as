package includes_as{
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class CargaXML extends MovieClip {
		
		public var miCargaXML:URLLoader;
		public var noNodos:int;
		public var miXML:XML;
						
		public function CargaXML(ruta:String) {

			var miRutaXML:URLRequest=new URLRequest(ruta);
			miCargaXML=new URLLoader(miRutaXML);
			miCargaXML.addEventListener(Event.COMPLETE,xmlCargado);

		}
		
		private function xmlCargado(eventObj:Event):void {

			try {

				miXML=new XML(miCargaXML.data);

				//miXML.ignoreWhitespace=true;

				noNodos=miXML.elements("*").length();
				

			} catch (e:TypeError) {

				trace(e.message);

			}

		}
		
	}
	
}