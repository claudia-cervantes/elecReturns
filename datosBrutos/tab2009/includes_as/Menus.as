package includes_as{

	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class Menus extends MovieClip {

		private var misBotones:Array;
		private var misSwfs:Array;
		private var misTipoSecc:String;
		private var btnActual:MovieClip;
		private var btnAnterior:MovieClip;
		private var raiz:MovieClip;
		private var seccionSwf:URLRequest;
		private var contSeccion:Loader;

		public function Menus(menu:Array, swfs:Array, tipo:String) {

			misBotones=menu;
			misSwfs=swfs;
			misTipoSecc = tipo;
			listaMenu();

		}

		private function listaMenu():void {

			var noBotones:int=misBotones.length;

			for (var i:int=0; i<noBotones; i++) {

				//if (misBotones[i].name!="btnPresidenteRegidores" || misBotones[i].name!="btnDiputados") {
				if (i!=1) {

					habilitarBoton(misBotones[i]);

				} else {

					btnActual=misBotones[i];

					deshabilitaBoton(btnActual);

				}

				ligaSeccion(misBotones[i], misSwfs[i]);

			}

			cargaSeccion(misSwfs[1]);

		}

		private function botonOver(eventObj:MouseEvent):void {

			var miBoton:MovieClip=eventObj.target as MovieClip;

			miBoton.gotoAndPlay("over");

		}

		private function botonOut(eventObj:MouseEvent):void {

			var miBoton:MovieClip=eventObj.target as MovieClip;

			miBoton.gotoAndPlay("out");

		}

		private function botonClick(eventObj:MouseEvent):void {

			btnAnterior=btnActual;

			btnActual=eventObj.target as MovieClip;

			raiz=this.parent as MovieClip;

			deshabilitaBoton(btnActual);

			if (btnAnterior!=null) {

				habilitarBoton(btnAnterior);

			}

			if (btnActual.seccion!="") {

				this.removeChild(contSeccion);

			}

			cargaSeccion(btnActual.seccion);

		}

		private function deshabilitaBoton(boton:MovieClip):void {

			boton.gotoAndStop(12);
			boton.removeEventListener(MouseEvent.MOUSE_OVER,botonOver);
			boton.removeEventListener(MouseEvent.MOUSE_OUT,botonOut);
			boton.removeEventListener(MouseEvent.CLICK,botonClick);
			boton.buttonMode=false;

		}

		private function habilitarBoton(boton:MovieClip):void {

			boton.gotoAndPlay("out");
			boton.addEventListener(MouseEvent.MOUSE_OVER,botonOver);
			boton.addEventListener(MouseEvent.MOUSE_OUT,botonOut);
			boton.addEventListener(MouseEvent.CLICK,botonClick);
			boton.buttonMode=true;

		}

		private function ligaSeccion(boton:MovieClip, secc:String):void {

			boton.seccion=secc;

		}

		private function cargaSeccion(secc:String):void {

			if (secc!="") {

				seccionSwf=new URLRequest("swf/"+secc+".swf");
				contSeccion = new Loader();
				contSeccion.name=""+secc+"";
				contSeccion.load(seccionSwf);

				this.addChild(contSeccion);

			} else {
				
				this.removeChild(contSeccion);

				if (misTipoSecc=="seccPres") {
					
					raiz.removeChild(raiz.miMenuPres);

				}

				if (misTipoSecc=="seccDip") {

					raiz.removeChild(raiz.miMenuDip);

				}
			
				raiz.gotoAndStop(1,"Principal");

			}

		}

	}

}