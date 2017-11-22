package includes_as{

	import flash.display.*;
	import flash.events.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import flash.text.TextField;

	import includes_as.TipoFuente;

	public class Mapas extends Sprite {

		private var btnMuniDist:MovieClip;
		private var nombreMuniDist:String;
		private var tipoEleccion:String
		private var raiz:MovieClip;		
		private var apareceMuniDist:Tween;
		private var apareceContenedor:Tween;
		private var apareceMensaje:Tween;
		private var electos:MovieClip;
		private var fuente:fTexto;

		public function Mapas(boton:MovieClip, nombre:String, tipo:String) {

			btnMuniDist = boton;
			nombreMuniDist = nombre;
			tipoEleccion = tipo
			fuente = new fTexto();

			btnMuniDist.alpha=.5;
			btnMuniDist.addEventListener(MouseEvent.MOUSE_OVER,overMuniDist);
			btnMuniDist.addEventListener(MouseEvent.MOUSE_OUT,outMuniDist);
			btnMuniDist.addEventListener(MouseEvent.CLICK,selecMuniDist);
			btnMuniDist.buttonMode=true;

		}

		private function overMuniDist(eventObj:MouseEvent):void {

			raiz=this.parent.parent as MovieClip;

			var formatoMensaje:TipoFuente=new TipoFuente(fuente,20,0x525252,false);

			raiz.titMuniDist.txtMuniDist.embedFonts=true;

			raiz.titMuniDist.visible=true;

			apareceMensaje=new Tween(raiz.titMuniDist,"alpha",Regular.easeOut,0,1,.7,true);

			raiz.titMuniDist.startDrag(true);

			raiz.titMuniDist.txtMuniDist.defaultTextFormat=formatoMensaje.miFormato;

			raiz.titMuniDist.txtMuniDist.text=nombreMuniDist;

			apareceMuniDist=new Tween(btnMuniDist,"alpha",Regular.easeOut,btnMuniDist.alpha,1,.7,true);

		}

		private function outMuniDist(eventObj:MouseEvent):void {

			raiz.titMuniDist.visible=false;

			raiz.titMuniDist.txtMuniDist.text="";

			raiz.titMuniDist.stopDrag();

			apareceMuniDist=new Tween(btnMuniDist,"alpha",Regular.easeOut,1,.5,.7,true);

		}

		private function selecMuniDist(eventObj:MouseEvent):void {
			
			if(tipoEleccion=="presidentesRegidores"){
				
				listaPresidentesRegidores();				
				
			}
			
			if(tipoEleccion=="diputadosMR"){
				
				listaDiputadosMR();
				
			}
			
			if(tipoEleccion=="diputadosRP"){
				
				listaDiputadosRP();
				
			}
			
		}
		
		private function listaDiputadosRP():void {
			
			electos=this.parent.getChildByName("misElectos") as MovieClip;
			
			var formatoNomCircuns:TipoFuente=new TipoFuente(fuente,14,0x000000,false);
			raiz.contDiputadosRP.txtCircun.embedFonts=true;
			raiz.contDiputadosRP.txtCircun.defaultTextFormat=formatoNomCircuns.miFormato;
			raiz.contDiputadosRP.txtCircun.text=nombreMuniDist+" PLURINOMINAL"
			
			raiz.contDiputadosRP.visible=true;
			
			raiz.contDiputadosRP.btnDetallado.archivo="estatal_"+btnMuniDist.name+".xml"
			
			apareceContenedor=new Tween(raiz.contDiputadosRP,"y",Regular.easeOut,310,492,.7,true);
			apareceContenedor=new Tween(raiz.contDiputadosRP,"alpha",Regular.easeOut,0,1,.7,true);
			
			
			var lista:mcLista = new mcLista();
			
			lista.nombres="";
			lista.tipos="";
			lista.partidos="";
			
			for each (var nombre:String in electos.miXML.diputado.(@circunscripcion==nombreMuniDist).@nombre) {
				
				lista.nombres+=nombre+"\n";
			
			}
			
			for each (var partido:String in electos.miXML.diputado.(@circunscripcion==nombreMuniDist).@partido) {
				
				lista.partidos+=partido+"\n";
			
			}
			
			for each (var tipo:String in electos.miXML.diputado.(@circunscripcion==nombreMuniDist).@tipo) {
				
				if(tipo=="P"){
					
					tipo="PROPIETARIO";
				
				}else{
					
					tipo="SUPLENTE";
					
				}				
				
				lista.tipos+=tipo+"\n";
			
			}
			
			raiz.contDiputadosRP.contLista.source=lista;
			raiz.contDiputadosRP.contLista.verticalScrollPosition=0
		
		}
		
		private function listaDiputadosMR():void {
			
			electos=this.parent.getChildByName("misElectos") as MovieClip;

			var formatoNomDiputado:TipoFuente=new TipoFuente(fuente,14,0x000000,false);
			var formatoCargo:TipoFuente=new TipoFuente(fuente,13,0x525252,false);
			var formatoSuplente:TipoFuente=new TipoFuente(fuente,13,0x000000,false);

			raiz.contDiputadosMR.visible=true;
			
			raiz.contDiputadosMR.btnDetallado.archivo="dip_"+btnMuniDist.name+".xml"

			apareceContenedor=new Tween(raiz.contDiputadosMR,"y",Regular.easeOut,385,505,.7,true);
			apareceContenedor=new Tween(raiz.contDiputadosMR,"alpha",Regular.easeOut,0,1,.7,true);

			raiz.contDiputadosMR.txtDiputado.embedFonts=true;
			raiz.contDiputadosMR.txtCargo.embedFonts=true;
			raiz.contDiputadosMR.txtSuplente.embedFonts=true;

			raiz.contDiputadosMR.txtDiputado.defaultTextFormat=formatoNomDiputado.miFormato;
			raiz.contDiputadosMR.txtCargo.defaultTextFormat=formatoCargo.miFormato;
			raiz.contDiputadosMR.txtSuplente.defaultTextFormat=formatoSuplente.miFormato;
			
			raiz.contDiputadosMR.txtDiputado.text=electos.miXML.diputado.(@distrito==nombreMuniDist && @tipo=="P").@nombre;
			raiz.contDiputadosMR.txtCargo.text="DIPUTADO "+electos.miXML.diputado.(@distrito==nombreMuniDist && @tipo=="P").@romano+" DISTRITO ELECTORAL MUNICIPIO "+electos.miXML.diputado.(@distrito==nombreMuniDist && @tipo=="P").@distrito;
			raiz.contDiputadosMR.txtSuplente.text="SUPLENTE : "+electos.miXML.diputado.(@distrito==nombreMuniDist && @tipo=="S").@nombre;
					
			raiz.contDiputadosMR.logotipos.gotoAndStop(electos.miXML.diputado.(@distrito==nombreMuniDist && @tipo=="P").@partido);
			
		}

		private function listaPresidentesRegidores():void {

			electos=this.parent.getChildByName("misElectos") as MovieClip;

			var formatoNomPresidente:TipoFuente=new TipoFuente(fuente,14,0x000000,false);
			var formatoCargo:TipoFuente=new TipoFuente(fuente,13,0x525252,false);
			var formatoSuplente:TipoFuente=new TipoFuente(fuente,13,0x000000,false);
			
			raiz.contPresiRegidores.visible=true;
			
			raiz.contPresiRegidores.btnDetallado.archivo="reg_"+btnMuniDist.name+".xml";
			
			apareceContenedor=new Tween(raiz.contPresiRegidores,"y",Regular.easeOut,320,450,.7,true);
			apareceContenedor=new Tween(raiz.contPresiRegidores,"alpha",Regular.easeOut,0,1,.7,true);

			raiz.contPresiRegidores.txtPresidente.embedFonts=true;
			raiz.contPresiRegidores.txtCargo.embedFonts=true;
			raiz.contPresiRegidores.txtSuplente.embedFonts=true;
			
			raiz.contPresiRegidores.txtPresidente.defaultTextFormat=formatoNomPresidente.miFormato;
			raiz.contPresiRegidores.txtCargo.defaultTextFormat=formatoCargo.miFormato;
			raiz.contPresiRegidores.txtSuplente.defaultTextFormat=formatoSuplente.miFormato;

			raiz.contPresiRegidores.txtPresidente.text=electos.miXML.municipio.(@nomMunicipio==nombreMuniDist).regidor.(@tipo=="P" && @numero=="01" && @principio=="MR").@nomRegidor;
			raiz.contPresiRegidores.txtCargo.text="PRESIDENTE MUNICIPAL DE "+nombreMuniDist;
			raiz.contPresiRegidores.txtSuplente.text="SUPLENTE : "+electos.miXML.municipio.(@nomMunicipio==nombreMuniDist).regidor.(@tipo=="S" && @numero=="01" && @principio=="MR").@nomRegidor;
			raiz.contPresiRegidores.logotipos.gotoAndStop(electos.miXML.municipio.(@nomMunicipio==nombreMuniDist).@partido);

			var lista:mcLista = new mcLista();
			
			lista.regidoresMR="";
			lista.regidoresRP="";
			lista.tiposMR="";
			lista.tiposRP="";
			lista.partidosRP="";
						
			for each (var regidorMR:String in electos.miXML.municipio.(@nomMunicipio==nombreMuniDist).regidor.(@numero!="01" && @principio=="MR").@nomRegidor) {
				
				lista.regidoresMR+=regidorMR+"\n";
			
			}
			
			for each (var regidorRP:String in electos.miXML.municipio.(@nomMunicipio==nombreMuniDist).regidor.(@principio=="RP").@nomRegidor) {
				
				lista.regidoresRP+=regidorRP+"\n";
			
			}
			
			for each (var tipoMR:String in electos.miXML.municipio.(@nomMunicipio==nombreMuniDist).regidor.(@numero!="01" && @principio=="MR").@tipo) {
				
				if(tipoMR=="P"){
					
					tipoMR="PROPIETARIO";
				
				}else{
					
					tipoMR="SUPLENTE";
					
				}				
				
				lista.tiposMR+=tipoMR+"\n";
			
			}
			
			for each (var tipoRP:String in electos.miXML.municipio.(@nomMunicipio==nombreMuniDist).regidor.(@principio=="RP").@tipo) {
				
				if(tipoRP=="P"){
					
					tipoRP="PROPIETARIO";
				
				}else{
					
					tipoRP="SUPLENTE";
					
				}				
				
				lista.tiposRP+=tipoRP+"\n";
			
			}
			
			for each (var partidoRP:String in electos.miXML.municipio.(@nomMunicipio==nombreMuniDist).regidor.(@principio=="RP").@partido) {
				
				lista.partidosRP+=partidoRP+"\n";
			
			}

			raiz.contPresiRegidores.contLista.source=lista;
			raiz.contPresiRegidores.contLista.verticalScrollPosition=0

		}

	}

}