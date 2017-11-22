package includes_as{

	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import fl.controls.DataGrid;
	import fl.controls.dataGridClasses.DataGridColumn;
	import fl.data.DataProvider;

	import includes_as.CargaXML;
	import includes_as.AlternarColoresCelda;
	import includes_as.AlineacionCeldaIzquierda;
	import includes_as.TipoFuente;

	public class Grids extends Sprite {

		private var miGrid:DataGrid;
		private var miArchivo:String;
		private var miTipoElec:String;
		private var miSubTipoElec:String;
		private var formatoHeaderGrid:TextFormat;
		private var formatoCeldaGrid:TextFormat;
		private var misResultados:CargaXML;
		private var muniDistCol:DataGridColumn;
		private var panCol:DataGridColumn;
		private var priCol:DataGridColumn;
		private var prdCol:DataGridColumn;
		private var ptCol:DataGridColumn;
		private var pvemCol:DataGridColumn;
		private var convCol:DataGridColumn;
		private var naCol:DataGridColumn;
		private var noregCol:DataGridColumn;
		private var coalicionCol:DataGridColumn;
		private var nulosCol:DataGridColumn;
		private var listaNominalCol:DataGridColumn;
		private var votTotalEmitidaCol:DataGridColumn;
		private var porcenVotTotEmitidaCol:DataGridColumn;
		private var abstencionismoCol:DataGridColumn;
		private var porAbstencionismoCol:DataGridColumn;
		private var seccionCol:DataGridColumn;
		private var casillaCol:DataGridColumn;
		private var totalVotosCol:DataGridColumn;

		private var miDataProvider:DataProvider;
		private var fuente:fNomMuni;

		public function Grids(grid:DataGrid, archivo:String, tipo:String, subtipo:String) {

			miGrid=grid;
			miArchivo=archivo;
			miSubTipoElec=subtipo;
			miTipoElec=tipo;
			fuente= new fNomMuni();

			formatoHeaderGrid = new TextFormat();
			formatoHeaderGrid.font="Arial";
			formatoHeaderGrid.bold=true;
			formatoHeaderGrid.size=11;

			formatoCeldaGrid = new TextFormat();
			formatoCeldaGrid.font="Arial";
			formatoCeldaGrid.bold=true;
			formatoCeldaGrid.size=10;
			formatoCeldaGrid.align="center";


			misResultados=new CargaXML(miArchivo);
			misResultados.miCargaXML.addEventListener(Event.COMPLETE,despliegaResultados);

			asignaPropiedades();

		}

		private function asignaPropiedades():void {


			if (miTipoElec=="estatalMuni"||miTipoElec=="estatalDist"||miTipoElec=="estatalRp") {

				if (miSubTipoElec=="detallado") {

					seccionCol=new DataGridColumn("seccion");
					seccionCol.headerText="  SECCION";
					seccionCol.width=72;

					casillaCol=new DataGridColumn("casilla");
					casillaCol.headerText=" CASILLA";
					casillaCol.width=72;

				} else {

					if (miTipoElec=="estatalMuni") {

						muniDistCol=new DataGridColumn("municipio");
						muniDistCol.headerText="            MUNICIPIO";

					}

					if (miTipoElec=="estatalDist"||miTipoElec=="estatalRp") {

						muniDistCol=new DataGridColumn("distrito");
						muniDistCol.headerText="            DISTRITO";

					}

					muniDistCol.cellRenderer=AlineacionCeldaIzquierda;
					muniDistCol.width=144;

				}

				panCol=new DataGridColumn("pan");
				panCol.headerText="";
				panCol.width=67;

				priCol=new DataGridColumn("pri");
				priCol.headerText="";
				priCol.width=67;

				prdCol=new DataGridColumn("prd");
				prdCol.headerText="";
				prdCol.width=67;

				ptCol=new DataGridColumn("pt");
				ptCol.headerText="";
				ptCol.width=67;

				pvemCol=new DataGridColumn("pvem");
				pvemCol.headerText="";
				pvemCol.width=67;

				convCol=new DataGridColumn("convergencia");
				convCol.headerText="";
				convCol.width=67;

				naCol=new DataGridColumn("na");
				naCol.headerText="";
				naCol.width=67;

				noregCol=new DataGridColumn("noreg");
				noregCol.headerText="CANDIDATOS NO \n  REGISTRADOS";
				noregCol.width=104;

				nulosCol=new DataGridColumn("nulos");

				totalVotosCol=new DataGridColumn("total");


				if (miTipoElec!="estatalRp") {

					coalicionCol=new DataGridColumn("coalicion");
					coalicionCol.headerText="COALICION\n  PRIMERO\n TABASCO";
					coalicionCol.width=74;

					nulosCol.headerText=" VOTOS \n NULOS";
					totalVotosCol.headerText=" VOTACION\n    TOTAL";
					nulosCol.width=59;
					totalVotosCol.width=80;

				} else {

					nulosCol.headerText=" VOTOS NULOS";
					totalVotosCol.headerText=" VOTACION TOTAL";

					nulosCol.width=96;
					totalVotosCol.width=117;

				}

			}

			if (miTipoElec=="participacionMuni"||miTipoElec=="participacionDist") {

				if (miTipoElec=="participacionMuni") {

					muniDistCol=new DataGridColumn("municipio");
					muniDistCol.headerText="            MUNICIPIO";

				}

				if (miTipoElec=="participacionDist") {

					muniDistCol=new DataGridColumn("distrito");
					muniDistCol.headerText="            DISTRITO";

				}
				muniDistCol.cellRenderer=AlineacionCeldaIzquierda;
				muniDistCol.width=144;

				listaNominalCol=new DataGridColumn("listanominal");
				listaNominalCol.headerText="       LISTA NOMINAL";
				listaNominalCol.width=141;

				votTotalEmitidaCol=new DataGridColumn("votaciontotalemitida");
				votTotalEmitidaCol.headerText="     VOTACION TOTAL \n              EMITIDA";
				votTotalEmitidaCol.width=141;

				porcenVotTotEmitidaCol=new DataGridColumn("porvotaciontotalemitida");
				porcenVotTotEmitidaCol.headerText="   % VOTACION TOTAL \n            EMITIDA";
				porcenVotTotEmitidaCol.width=141;

				abstencionismoCol=new DataGridColumn("abstencionismo");
				abstencionismoCol.headerText="     ABSTENCIONISMO";
				abstencionismoCol.width=141;

				porAbstencionismoCol=new DataGridColumn("porabstencionismo");
				porAbstencionismoCol.headerText="   % ABSTENCIONISMO";
				porAbstencionismoCol.width=141;

			}


			miGrid.headerHeight=67;
			miGrid.resizableColumns=false;
			miGrid.sortableColumns=false;
			miGrid.selectable=false;

			miGrid.setStyle("cellRenderer", AlternarColoresCelda);
			miGrid.setStyle("headerTextFormat",formatoHeaderGrid);
			miGrid.setRendererStyle("textFormat", formatoCeldaGrid);


		}

		public function filtrarSeccion(eventObj:Event):void {

			var arr:Array=miDataProvider.toArray();
			var filtrarArray:Array=arr.filter(filtrarDataProvider);
			miGrid.dataProvider=new DataProvider(filtrarArray);


		}

		function filtrarDataProvider(obj:Object, idx:int, arr:Array):Boolean {

			var raiz:MovieClip=this.parent as MovieClip;

			var txt1:String=raiz.tiSeccion.text;

			if (! txt1.length) {

				txt1="";


			} else if (txt1.length<2) {

				txt1="000"+txt1;


			} else if (txt1.length<3) {

				txt1="00"+txt1;


			} else if (txt1.length<4) {

				txt1="0"+txt1;


			}

			var txt2:String=obj.seccion.substr(0,txt1.length);

			if (txt1.toLowerCase()==txt2.toLowerCase()) {

				return true;

			}

			return false;

		}


		private function despliegaResultados(eventObj:Event):void {

			var raiz:MovieClip=this.parent as MovieClip;
			miDataProvider=new DataProvider(misResultados.miXML);

			var formatoNombre:TipoFuente=new TipoFuente(fuente,18,0x4F4F3F,false);

			raiz.txtNomGrid.embedFonts=true;
			raiz.txtNomGrid.defaultTextFormat=formatoNombre.miFormato;

			var miArrayPorcentajes:Array= new Array();

			if (miTipoElec=="estatalMuni"||miTipoElec=="estatalDist"||miTipoElec=="estatalRp") {
				
				raiz.barraTotales.listaNominal=misResultados.miXML.@listanominal;
				
				if (miSubTipoElec=="detallado") {			

					miGrid.columns=[seccionCol,casillaCol,panCol,priCol,prdCol,ptCol,pvemCol,convCol,naCol,noregCol,coalicionCol,nulosCol,totalVotosCol];

					if (miTipoElec=="estatalMuni") {

						//raiz.txtNomGrid.embedFonts=true;
						//raiz.txtNomGrid.defaultTextFormat=formatoNombre.miFormato;

						raiz.txtNomGrid.text="MUNICIPIO DE "+misResultados.miXML.@nomMunicipio;

					}

					if (miTipoElec=="estatalDist") {

						//raiz.txtNomGrid.embedFonts=true;
						//raiz.txtNomGrid.defaultTextFormat=formatoNombre.miFormato;

						raiz.txtNomGrid.text="DISTRITO "+misResultados.miXML.@distrito+" "+misResultados.miXML.@nombre;

					}


				} else {

					//raiz.txtNomGrid.embedFonts=true;
					//raiz.txtNomGrid.defaultTextFormat=formatoNombre.miFormato;

					raiz.txtNomGrid.text="CONCENTRADO ESTATAL ";

					if (miTipoElec=="estatalMuni") {

						raiz.txtNomGrid.text+="POR MUNICIPIO";

						miGrid.columns=[muniDistCol,panCol,priCol,prdCol,ptCol,pvemCol,convCol,naCol,noregCol,coalicionCol,nulosCol,totalVotosCol];

						/*for each (var porcenMuni:String in misResultados.miXML.resultado.@porcentaje) {

							miArrayPorcentajes.push(porcenMuni);

						}

						raiz.barraTotales.arrayPorcentaje=miArrayPorcentajes;*/

					}

					if (miTipoElec=="estatalDist") {

						raiz.txtNomGrid.text+="POR DISTRITO";

						miGrid.columns=[muniDistCol,panCol,priCol,prdCol,ptCol,pvemCol,convCol,naCol,noregCol,coalicionCol,nulosCol,totalVotosCol];

						/*for each (var porcenDist:String in misResultados.miXML.resultado.@porcentaje) {

							miArrayPorcentajes.push(porcenDist);

						}

						raiz.barraTotales.arrayPorcentaje=miArrayPorcentajes;*/

					}

					if (miTipoElec=="estatalRp") {

						raiz.txtNomGrid.text+=miSubTipoElec+" CIRCUNSCRIPCION PLURINOMINAL";

						miGrid.columns=[muniDistCol,panCol,priCol,prdCol,ptCol,pvemCol,convCol,naCol,noregCol,nulosCol,totalVotosCol];

					}

				}

				if (miTipoElec!="estatalRp") {


					if (misResultados.miXML.@nomMunicipio=="CENTLA (R)"||misResultados.miXML.@nombre=="CENTRO ORIENTE (R)") {

						raiz.barraTotalesTribunal.txtTotalPan.text=misResultados.miXML.@pan;
						raiz.barraTotalesTribunal.txtTotalPri.text=misResultados.miXML.@pri;
						raiz.barraTotalesTribunal.txtTotalPrd.text=misResultados.miXML.@prd;
						raiz.barraTotalesTribunal.txtTotalPt.text=misResultados.miXML.@pt;
						raiz.barraTotalesTribunal.txtTotalPvem.text=misResultados.miXML.@pvem;
						raiz.barraTotalesTribunal.txtTotalConv.text=misResultados.miXML.@convergencia;
						raiz.barraTotalesTribunal.txtTotalNa.text=misResultados.miXML.@na;
						raiz.barraTotalesTribunal.txtTotalNoReg.text=misResultados.miXML.@noreg;
						raiz.barraTotalesTribunal.txtTotalCoalicion.text=misResultados.miXML.@coalicion;
						raiz.barraTotalesTribunal.txtTotalNulos.text=misResultados.miXML.@nulos;
						raiz.barraTotalesTribunal.txtVotTotal.text=misResultados.miXML.@votaciontotal;



					} else {

						raiz.barraTotales.txtTotalPan.text=misResultados.miXML.@pan;
						raiz.barraTotales.txtTotalPri.text=misResultados.miXML.@pri;
						raiz.barraTotales.txtTotalPrd.text=misResultados.miXML.@prd;
						raiz.barraTotales.txtTotalPt.text=misResultados.miXML.@pt;
						raiz.barraTotales.txtTotalPvem.text=misResultados.miXML.@pvem;
						raiz.barraTotales.txtTotalConv.text=misResultados.miXML.@convergencia;
						raiz.barraTotales.txtTotalNa.text=misResultados.miXML.@na;
						raiz.barraTotales.txtTotalNoReg.text=misResultados.miXML.@noreg;
						raiz.barraTotales.txtTotalCoalicion.text=misResultados.miXML.@coalicion;
						raiz.barraTotales.txtTotalNulos.text=misResultados.miXML.@nulos;
						raiz.barraTotales.txtVotTotal.text=misResultados.miXML.@votaciontotal;

					}


				} else {

					raiz.barraTotalesRP.txtTotalPan.text=misResultados.miXML.@pan;
					raiz.barraTotalesRP.txtTotalPri.text=misResultados.miXML.@pri;
					raiz.barraTotalesRP.txtTotalPrd.text=misResultados.miXML.@prd;
					raiz.barraTotalesRP.txtTotalPt.text=misResultados.miXML.@pt;
					raiz.barraTotalesRP.txtTotalPvem.text=misResultados.miXML.@pvem;
					raiz.barraTotalesRP.txtTotalConv.text=misResultados.miXML.@convergencia;
					raiz.barraTotalesRP.txtTotalNa.text=misResultados.miXML.@na;
					raiz.barraTotalesRP.txtTotalNoReg.text=misResultados.miXML.@noreg;

					raiz.barraTotalesRP.txtTotalNulos.text=misResultados.miXML.@nulos;
					raiz.barraTotalesRP.txtVotTotal.text=misResultados.miXML.@votaciontotal;

				}

			}

			if (miTipoElec=="participacionMuni"||miTipoElec=="participacionDist") {

				miGrid.columns=[muniDistCol,listaNominalCol,votTotalEmitidaCol,porcenVotTotEmitidaCol,abstencionismoCol,porAbstencionismoCol];

				//raiz.txtAbstencionismo.embedFonts=true;
				//raiz.txtAbstencionismo.defaultTextFormat=formatoNombre.miFormato;

				raiz.txtNomGrid.text="PARTICIPACION CIUDADANA ";

				if (miTipoElec=="participacionMuni") {

					raiz.txtNomGrid.text+="POR MUNICIPIO";

				}

				if (miTipoElec=="participacionDist") {

					raiz.txtNomGrid.text+="POR DISTRITO";

				}

				raiz.txtTotalListaNom.text=misResultados.miXML.@listanominal;
				raiz.txtTotalVotTotEmit.text=misResultados.miXML.@votaciontotalemitida;
				raiz.txtTotalPorVotTotEmit.text=misResultados.miXML.@porvotaciontotalemitida;
				raiz.txtTotalAbstencionismo.text=misResultados.miXML.@abstencionismo;
				raiz.txtTotalPorAbstencionismo.text=misResultados.miXML.@porabstencionismo;

				for each (var porcenEst:String in misResultados.miXML.resultado.@porvotaciontotalemitida) {

					miArrayPorcentajes.push(porcenEst);

				}

				raiz.barraTotales.arrayPorcentaje=miArrayPorcentajes;

			}

			miGrid.dataProvider=miDataProvider;
			miGrid.scrollToIndex(0);

		}

	}

}