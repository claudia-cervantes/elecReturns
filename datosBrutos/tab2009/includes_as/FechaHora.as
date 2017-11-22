package includes_as{

	import flash.display.*;
	import flash.events.*;
	import flash.text.TextField;
	import flash.utils.Timer;

	import includes_as.TipoFuente;

	public class FechaHora extends Sprite {

		private var fecha:Date;
		private var minutos:int;
		private var horas:int;
		private var dia:int;
		private var mes:int;
		private var year:int;
		private var complMinutos:String;
		private var complHoras:String;
		private var complDia:String;
		private var complMes:String;
		private var formato:String;
		private var txtFecha:TextField;
		private var txtHora:TextField;
		private var intervalo:Timer;
		private var fuente:fFecha;

		public function FechaHora(cajaTxtFecha:TextField, cajaTxtHora:TextField) {
			
			txtFecha=cajaTxtFecha;
			txtHora=cajaTxtHora;
			
			intervalo = new Timer(1000, 0);
			intervalo.addEventListener(TimerEvent.TIMER, cambioFecha);
			intervalo.start();
			
			//txtFecha.addEventListener(Event.ENTER_FRAME, cambioFecha);					

		}
		
		private function cambioFecha(eventObj:TimerEvent):void{
			
			fecha = new Date();
			minutos = fecha.getMinutes();
			horas = fecha.getHours();
			dia = fecha.getDate();
			mes = fecha.getMonth()+1;
			year = fecha.getFullYear();
			
			/*////////////////////CEROS A LA IZQUIERDA////////////////////////*/
			
			if (dia<10) {
				complDia="0";
			} else {
				complDia="";
			}

			if (mes<10) {
				complMes="0";
			} else {
				complMes="";
			}
			
			if (minutos<10) {
				complMinutos="0";
			} else {
				complMinutos="";
			}

			if (horas<10) {
				complHoras="0";
			} else {
				complHoras="";
			}
			
			/*///////////////////////////////////////////////////////////////////*/
			/*////////////////////////////AM-PM//////////////////////////////////*/
			
			if(horas<12){
				
				formato = "AM";
			
			}else if(horas<24){
				
				formato = "PM";
				
				if(horas>12){
				
					horas = horas-12;
					
					if (horas < 10){//agregado mcCoy
						
					   complHoras="0";
					   
					}//agregado mcCoy
					
				}
				
			}
			
			/*///////////////////////////////////////////////////////////////////*/
			
			fuente = new fFecha();

			var formatoFecha:TipoFuente = new TipoFuente(fuente, 18, 0x7E7E7E, false);
			var formatoHora:TipoFuente = new TipoFuente(fuente, 25, 0x7E7E7E, false);
					
			txtFecha.embedFonts=true;
			txtHora.embedFonts=true;

			txtFecha.text=complDia+""+dia+"/"+complMes+""+mes+"/"+year;
			txtHora.text=complHoras+""+horas+":"+complMinutos+""+minutos+" "+formato;
			
			txtFecha.defaultTextFormat=formatoFecha.miFormato;
			txtHora.defaultTextFormat=formatoHora.miFormato;
			
			eventObj.updateAfterEvent();
			
		}

	}

}