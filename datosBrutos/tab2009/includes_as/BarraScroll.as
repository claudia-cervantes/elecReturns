package includes_as{

	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.geom.Rectangle;
	//import flash.utils.Timer;

	public class BarraScroll extends Sprite {

		private var area:MovieClip;
		private var deslizable:MovieClip;
		private var recorrido:Number;
		private var textoContenido:TextField;
		//private var intervalo:Timer;

		public function BarraScroll(barraScroll:MovieClip, barra:MovieClip, texto:TextField, posRootX:int, posRootY:int) {

			deslizable = barraScroll;
			deslizable.buttonMode = true;
			area = barra;
			recorrido = 10*barra.height/11;
			textoContenido = texto;
			
			//var mascara:mcMascara = new mcMascara();
			
			//mascara.x = posRootX+texto.x;
			//mascara.y = posRootY+texto.y
			
			//this.addChild(mascara)
			
			//textoContenido.mask = mascara;
					
			deslizable.addEventListener(MouseEvent.MOUSE_DOWN,arrastarBarra);
			deslizable.addEventListener(MouseEvent.MOUSE_UP,detenerBarra);
			deslizable.addEventListener(MouseEvent.MOUSE_OUT,detenerBarra);
			
			deslizable.addEventListener(Event.ENTER_FRAME, scrollear);
			//intervalo = new Timer(.5, 0);
			//intervalo.addEventListener(TimerEvent.TIMER, scrollear);
			//intervalo.start();

		}
		
		private function arrastarBarra(eventObj:MouseEvent):void {

			var mc:MovieClip = eventObj.target as MovieClip;
			
			var posX:int = Math.round(area.x-mc.width/2);

			var posY:int = Math.round(area.y);

			var alto:int = Math.round(area.height-mc.height);

			var ancho:int = 0;

			mc.startDrag(false, new Rectangle(posX,posY,ancho,alto));

		}
		
		private function detenerBarra(eventObj:MouseEvent):void{
			
			var mc:MovieClip = eventObj.target as MovieClip;
			
			mc.stopDrag();			
			
		}
		
		private function scrollear(eventObj:Event):void{
			
			var porcentaje:Number = 1 - (Math.round(recorrido - deslizable.y+area.y))/recorrido;
			var fin:int = -((textoContenido.height - area.height) * porcentaje - area.y);
			textoContenido.y += (fin - textoContenido.y)/10;//Esto es para hacer un efecto de deslizamiento del texto
			//textoContenido.y += fin - textoContenido.y
			
			//eventObj.updateAfterEvent();
			
		}
	}
}