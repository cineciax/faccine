<?xml version="1.0" encoding="ISO-8859-1" standalone="no"?>
<#setting number_format="#########0.########">
<Invoice xmlns="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
         xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
         xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
         xmlns:ccts="urn:un:unece:uncefact:documentation:2"
         xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
         xmlns:ext="urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2"
         xmlns:qdt="urn:oasis:names:specification:ubl:schema:xsd:QualifiedDatatypes-2" xmlns:udt="urn:un:unece:uncefact:data:specification:UnqualifiedDataTypesSchemaModule:2"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ext:UBLExtensions>
  </ext:UBLExtensions>
  <cbc:UBLVersionID>2.1</cbc:UBLVersionID>
  <cbc:CustomizationID>2.0</cbc:CustomizationID>
  <cbc:ID>${nroCdpSwf}</cbc:ID>
  <cbc:IssueDate>${fecEmision}</cbc:IssueDate>
  <cbc:IssueTime>${horEmision}</cbc:IssueTime>  
  <#if fecVencimiento?? && fecVencimiento != "-" && fecVencimiento != "" >
  <cbc:DueDate>${fecVencimiento}</cbc:DueDate>
  </#if>
  
  <cbc:InvoiceTypeCode listID="${tipOperacion}"
                       listAgencyName="PE:SUNAT"
                       listName="Tipo de Documento"
                       name="Tipo de Operacion"
                       listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo01"
                       listSchemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo51">${tipCdpSwf}</cbc:InvoiceTypeCode>
					   
<#list listaLeyendas as leyenda>
  <cbc:Note languageLocaleID="${leyenda.codigo}"><![CDATA[${leyenda.descripcion}]]></cbc:Note>
</#list>
  <cbc:DocumentCurrencyCode listID="ISO 4217 Alpha"
                          listName="Currency"
                          listAgencyName="United Nations Economic Commission for Europe">${moneda}</cbc:DocumentCurrencyCode>							  
<#list listaRelacionado as relacion>
  <#if relacion.indDocRelacionado = "3">  
  <!-- Orden Compra --> 
    <cac:OrderReference>
      <cbc:ID>${relacion.numDocRelacionado}</cbc:ID>
    </cac:OrderReference>
  <#elseif relacion.indDocRelacionado = "1">
  <!-- Guia --> 
  <cac:DespatchDocumentReference>
    <cbc:ID>${relacion.numDocRelacionado}</cbc:ID>
	<cbc:DocumentTypeCode listAgencyName="PE:SUNAT" 
						  listName="Tipo de Documento" 
						  listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo01">${relacion.tipDocRelacionado}</cbc:DocumentTypeCode>
  </cac:DespatchDocumentReference>
  <#elseif relacion.indDocRelacionado = "99">
    <!-- Otros Documentos -->
    <cac:AdditionalDocumentReference>
      <cbc:ID>${relacion.numDocRelacionado}</cbc:ID>
      <cbc:DocumentTypeCode listAgencyName="PE:SUNAT" 
							listName="Identificador de documento relacionado"
							listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo12">${relacion.tipDocRelacionado}</cbc:DocumentTypeCode>
    </cac:AdditionalDocumentReference> 
  <#elseif relacion.indDocRelacionado = "2" && relacion.tipDocRelacionado = "02">
  	<!-- Anticipos detalle - Factura --> 
  <cac:AdditionalDocumentReference>
    <cbc:ID schemeID="01">${relacion.numDocRelacionado}</cbc:ID>
    <cbc:DocumentTypeCode listAgencyName="PE:SUNAT"
                          listName="Documento Relacionado"
                          listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo12">${relacion.tipDocRelacionado}</cbc:DocumentTypeCode>
    <cbc:DocumentStatusCode listAgencyName="PE:SUNAT"
                            listName="Anticipo">${relacion.numIdeAnticipo}</cbc:DocumentStatusCode>
    <cac:IssuerParty>
      <cac:PartyIdentification>
        <cbc:ID schemeAgencyName="PE:SUNAT"
                schemeID="${relacion.tipDocEmisor}"
                schemeName="Documento de Identidad"
                schemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo06">${relacion.numDocEmisor}</cbc:ID>
      </cac:PartyIdentification>
    </cac:IssuerParty>
  </cac:AdditionalDocumentReference>
  <#elseif relacion.indDocRelacionado = "2" && relacion.tipDocRelacionado = "03">
  <!-- Anticipos detalle - Boleta --> 
  <cac:AdditionalDocumentReference>
    <cbc:ID schemeID="03">${relacion.numDocRelacionado}</cbc:ID>
    <cbc:DocumentTypeCode listAgencyName="PE:SUNAT"
                          listName="Documento Relacionado"
                          listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo12">${relacion.tipDocRelacionado}</cbc:DocumentTypeCode>
    <cbc:DocumentStatusCode listAgencyName="PE:SUNAT"
                            listName="Anticipo">${relacion.numIdeAnticipo}</cbc:DocumentStatusCode>
    <cac:IssuerParty>
      <cac:PartyIdentification>
        <cbc:ID schemeAgencyName="PE:SUNAT"
                schemeID="${relacion.tipDocEmisor}"
                schemeName="Documento de Identidad"
                schemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo06">${relacion.numDocEmisor}</cbc:ID>
      </cac:PartyIdentification>
    </cac:IssuerParty>
  </cac:AdditionalDocumentReference>
  </#if>
</#list>
  <cac:Signature>
    <cbc:ID>${nroRucEmisorSwf}</cbc:ID>
	<cbc:Note>${identificadorFacturadorSwf}</cbc:Note>
    <cac:SignatoryParty>
      <cac:PartyIdentification>
        <cbc:ID>${nroRucEmisorSwf}</cbc:ID>
      </cac:PartyIdentification>
      <cac:PartyName>
        <cbc:Name><![CDATA[${razonSocialSwf}]]></cbc:Name>
      </cac:PartyName>
    </cac:SignatoryParty>
    <cac:DigitalSignatureAttachment>
      <cac:ExternalReference>
        <cbc:URI>${identificadorFirmaSwf}</cbc:URI>
      </cac:ExternalReference>
    </cac:DigitalSignatureAttachment>
  </cac:Signature>
  <cac:AccountingSupplierParty>
    <cac:Party>
      <cac:PartyIdentification>
        <cbc:ID schemeID="${tipDocuEmisorSwf}"
                schemeName="Documento de Identidad"
                schemeAgencyName="PE:SUNAT"
                schemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo06">${nroRucEmisorSwf}</cbc:ID>
      </cac:PartyIdentification>
      <cac:PartyName>
        <cbc:Name><![CDATA[${nombreComercialSwf}]]></cbc:Name>
      </cac:PartyName>
      <cac:PartyLegalEntity>
        <cbc:RegistrationName><![CDATA[${razonSocialSwf}]]></cbc:RegistrationName>
        <cac:RegistrationAddress>
         <cbc:AddressTypeCode>${codLocalEmisor}</cbc:AddressTypeCode>
		 <cbc:CitySubdivisionName><![CDATA[${urbanizaSwf}]]></cbc:CitySubdivisionName>
         <cbc:CityName><![CDATA[${provinSwf}]]></cbc:CityName>
         <cbc:CountrySubentity><![CDATA[${deparSwf}]]></cbc:CountrySubentity>
		 <cbc:CountrySubentityCode><![CDATA[${ubigeoDomFiscalSwf}]]></cbc:CountrySubentityCode>
         <cbc:District><![CDATA[${distrSwf}]]></cbc:District>	
		 <cac:AddressLine>
			<cbc:Line><![CDATA[${direccionDomFiscalSwf}]]></cbc:Line>
		 </cac:AddressLine>		 
         <cac:Country>
          <cbc:IdentificationCode>${paisDomFiscalSwf}</cbc:IdentificationCode>
         </cac:Country>
        </cac:RegistrationAddress>
      </cac:PartyLegalEntity>
    </cac:Party>	
  </cac:AccountingSupplierParty>
  <cac:AccountingCustomerParty>
    <cac:Party>
      <cac:PartyIdentification>
        <cbc:ID schemeID="${tipDocUsuario}"
                schemeName="Documento de Identidad"
                schemeAgencyName="PE:SUNAT"
                schemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo06">${numDocUsuario}</cbc:ID>
      </cac:PartyIdentification>
      <cac:PartyLegalEntity>
        <cbc:RegistrationName><![CDATA[${rznSocialUsuario}]]></cbc:RegistrationName>
		<#if desDireccionCliente??><#if desDireccionCliente != '-' && codUbigeoCliente != '-' &&  desDireccionCliente != ''>
		<cac:RegistrationAddress>
          <cbc:AddressTypeCode>-</cbc:AddressTypeCode>
		  <cbc:CitySubdivisionName>-</cbc:CitySubdivisionName>
          <cbc:CityName>-</cbc:CityName>
          <cbc:CountrySubentity>-</cbc:CountrySubentity>
		  <cbc:CountrySubentityCode><![CDATA[${codUbigeoCliente}]]></cbc:CountrySubentityCode>
          <cbc:District>-</cbc:District>
		  <cac:AddressLine>
			<cbc:Line><![CDATA[${desDireccionCliente}]]></cbc:Line>
		  </cac:AddressLine>	
          <cac:Country>
           <cbc:IdentificationCode>${codPaisCliente}</cbc:IdentificationCode>      
          </cac:Country>
        </cac:RegistrationAddress>
		</#if></#if>
		</cac:PartyLegalEntity>
    </cac:Party>		
  </cac:AccountingCustomerParty>
  <#if desDireccionEntrega??><#if desDireccionEntrega != '-' && codUbigeoEntrega != '-'  && desDireccionEntrega != ''>
  <cac:DeliveryTerms>
    <!-- Dato de Entrega -->
	<cac:DeliveryLocation>
	<cac:Address>
		<cbc:StreetName>${desDireccionEntrega}</cbc:StreetName>
		<cbc:CitySubdivisionName/>
		<cbc:CityName></cbc:CityName>
		<cbc:CountrySubentity></cbc:CountrySubentity>
		<cbc:CountrySubentityCode>${codUbigeoEntrega}</cbc:CountrySubentityCode>
		<cbc:District></cbc:District>
		<cac:Country>
			 <cbc:IdentificationCode	listID="ISO 3166-1"
										listAgencyName="United Nations Economic Commission for Europe"
										listName="Country">${codPaisEntrega}</cbc:IdentificationCode>
		</cac:Country>
	</cac:Address>
	</cac:DeliveryLocation>
	<!-- Fin Dato de Entrega -->
  </cac:DeliveryTerms>
  </#if></#if> 
  
  <#if ctaBancoNacionDetraccion??><#if ctaBancoNacionDetraccion != "-" && ctaBancoNacionDetraccion != "">
  <cac:PaymentMeans>
	<cbc:ID>Detraccion</cbc:ID>    
	<cbc:PaymentMeansCode listName="Medio de pago" 
						  listAgencyName="PE:SUNAT"
						  listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo59">${codMedioPago}</cbc:PaymentMeansCode>
	<cac:PayeeFinancialAccount>
      <cbc:ID>${ctaBancoNacionDetraccion}</cbc:ID>
    </cac:PayeeFinancialAccount>
  </cac:PaymentMeans>
  <cac:PaymentTerms>
	<cbc:ID>Detraccion</cbc:ID>  
	<cbc:PaymentMeansID schemeName="Codigo de detraccion" 
						schemeAgencyName="PE:SUNAT"
						schemeURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo54">${codBienDetraccion}</cbc:PaymentMeansID>
    <cbc:PaymentPercent>${porDetraccion}</cbc:PaymentPercent>
    <cbc:Amount currencyID="PEN">${mtoDetraccion}</cbc:Amount>
  </cac:PaymentTerms>
  <!-- Fin de detracciones -->
   </#if>  
   </#if> 

<#if (datoPago??) >
    <cac:PaymentTerms>
    <cbc:ID>FormaPago</cbc:ID>
	<#if (formaPago??) >
	<cbc:PaymentMeansID>${formaPago}</cbc:PaymentMeansID>
	</#if>
	<#if (tipMonedaMtoNetoPendientePago?? && mtoNetoPendientePago??) >
	<cbc:Amount currencyID="${tipMonedaMtoNetoPendientePago}">${mtoNetoPendientePago}</cbc:Amount>
	</#if>
    </cac:PaymentTerms>
</#if>
	
	<#if (listaCuotas??) >
   <#list listaCuotas as cuota>
    <cac:PaymentTerms>
    <cbc:ID>FormaPago</cbc:ID>
	<cbc:PaymentMeansID>${cuota.lineaCuota}</cbc:PaymentMeansID>
		<#if (cuota.tipMonedaCuotaPago?? && cuota.mtoCuotaPago??) >
		<cbc:Amount currencyID="${cuota.tipMonedaCuotaPago}">${cuota.mtoCuotaPago}</cbc:Amount>
		</#if>
		<#if (cuota.fecCuotaPago??) >
		<cbc:PaymentDueDate>${cuota.fecCuotaPago}</cbc:PaymentDueDate>
		</#if>
    </cac:PaymentTerms>
	</#list>
	</#if>
	
<#if indRetenIgv??>
<#if (indRetenIgv = "1") >
   <cac:AllowanceCharge>
	<cbc:ChargeIndicator>${constIndRetencion}</cbc:ChargeIndicator>
	<cbc:AllowanceChargeReasonCode listAgencyName="PE:SUNAT"
								   listName="Cargo/descuento"
								   listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo53">${constCodRetencion}</cbc:AllowanceChargeReasonCode>
	<cbc:MultiplierFactorNumeric>${porRetencion}</cbc:MultiplierFactorNumeric>
	<cbc:Amount currencyID="${moneda}">${impRetencion}</cbc:Amount>
	<cbc:BaseAmount currencyID="${moneda}">${impOperacion}</cbc:BaseAmount>
   </cac:AllowanceCharge>
</#if>
</#if>

<#if sumTotalAnticipos??>
<#list listaRelacionado as relacion>
  <#if relacion.indDocRelacionado = "2">
  <!-- Anticipos Montos - Total Anticipos-->
    <cac:PrepaidPayment>
      <cbc:ID schemeAgencyName="PE:SUNAT" schemeName="Anticipo">${relacion.numIdeAnticipo}</cbc:ID>
      <cbc:PaidAmount currencyID="${moneda}">${relacion.mtoDocRelacionado}</cbc:PaidAmount>
    </cac:PrepaidPayment>
	<!-- Fin de Anticipos -->
  </#if>  
</#list>
</#if>

<#list listaVariablesGlobales as variableGlobal>
<#if (variableGlobal.codTipoVariableGlobal?? && variableGlobal.codTipoVariableGlobal != "-") >
	<cac:AllowanceCharge>
		<cbc:ChargeIndicator>${variableGlobal.tipVariableGlobal}</cbc:ChargeIndicator>
		<cbc:AllowanceChargeReasonCode>${variableGlobal.codTipoVariableGlobal}</cbc:AllowanceChargeReasonCode>
		<cbc:MultiplierFactorNumeric>${variableGlobal.porVariableGlobal}</cbc:MultiplierFactorNumeric>
		<cbc:Amount currencyID="${variableGlobal.monMontoVariableGlobal}">${variableGlobal.mtoVariableGlobal}</cbc:Amount>
		<cbc:BaseAmount currencyID="${variableGlobal.monBaseImponibleVariableGlobal}">${variableGlobal.mtoBaseImpVariableGlobal}</cbc:BaseAmount>
	</cac:AllowanceCharge>
</#if>
</#list>

  <!-- Inicio Tributos cabecera-->	
  <cac:TaxTotal>
    <cbc:TaxAmount currencyID="${moneda}">${sumTotTributos}</cbc:TaxAmount>  
	<#list listaTributos as tributo>	
      <cac:TaxSubtotal>
		<#if tributo.ideTributo != "7152"> 
        <cbc:TaxableAmount currencyID="${moneda}">${tributo.mtoBaseImponible}</cbc:TaxableAmount>
		</#if>
        <cbc:TaxAmount currencyID="${moneda}">${tributo.mtoTributo}</cbc:TaxAmount>
        <cac:TaxCategory>
          <cac:TaxScheme>
            <cbc:ID schemeID="UN/ECE 5153"
                    schemeName="Codigo de tributos"
                    schemeAgencyName="PE:SUNAT">${tributo.ideTributo}</cbc:ID>
            <cbc:Name>${tributo.nomTributo}</cbc:Name>
            <cbc:TaxTypeCode>${tributo.codTipTributo}</cbc:TaxTypeCode>
          </cac:TaxScheme>
        </cac:TaxCategory>
      </cac:TaxSubtotal>	
	</#list>
	</cac:TaxTotal>	
	<!-- Fin Tributos  Cabecera-->
  <cac:LegalMonetaryTotal>
    <cbc:LineExtensionAmount currencyID="${moneda}">${sumTotValVenta}</cbc:LineExtensionAmount>	
	<#if sumPrecioVenta??> 
	<cbc:TaxInclusiveAmount currencyID="${moneda}">${sumPrecioVenta}</cbc:TaxInclusiveAmount>
	</#if>
    <cbc:AllowanceTotalAmount currencyID="${moneda}">${sumDescTotal}</cbc:AllowanceTotalAmount>
	<cbc:ChargeTotalAmount currencyID="${moneda}">${sumOtrosCargos}</cbc:ChargeTotalAmount>	
	<#if sumTotalAnticipos??> 
	<#if sumTotalAnticipos?number gt 0>												  
	<cbc:PrepaidAmount currencyID="${moneda}">${sumTotalAnticipos}</cbc:PrepaidAmount>
	<#else>
	<cbc:PrepaidAmount currencyID="${moneda}">0.00</cbc:PrepaidAmount>	
	</#if>
	</#if>  
	<cbc:PayableAmount currencyID="${moneda}">${sumImpVenta}</cbc:PayableAmount>  
  </cac:LegalMonetaryTotal>  
<#list listaDetalle as detalle>
<cac:InvoiceLine>
<cbc:ID>${detalle.lineaSwf}</cbc:ID>
    <cbc:InvoicedQuantity unitCode="${detalle.unidadMedida}"
                          unitCodeListID="UN/ECE rec 20"
                          unitCodeListAgencyName="United Nations Economic Commission for Europe">${detalle.ctdUnidadItem}</cbc:InvoicedQuantity>
	<cbc:LineExtensionAmount currencyID="${moneda}">${detalle.mtoValorVentaItem}</cbc:LineExtensionAmount>
<#assign pvUnitario = detalle.mtoPrecioVentaUnitario?number>
<#if (pvUnitario?number gt 0) >
    <cac:PricingReference>
      <cac:AlternativeConditionPrice>
        <cbc:PriceAmount currencyID="${moneda}">${detalle.mtoPrecioVentaUnitario}</cbc:PriceAmount>
        <cbc:PriceTypeCode listName="Tipo de Precio"
                           listAgencyName="PE:SUNAT"
                           listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo16">01</cbc:PriceTypeCode>
      </cac:AlternativeConditionPrice>
	 </cac:PricingReference>
</#if>	  
<#assign pvUnitario = detalle.mtoValorReferencialUnitario?number>
<#if (pvUnitario?number gt 0) >
    <cac:PricingReference>
      <cac:AlternativeConditionPrice>
        <cbc:PriceAmount currencyID="${moneda}">${detalle.mtoValorReferencialUnitario}</cbc:PriceAmount>
        <cbc:PriceTypeCode listName="Tipo de Precio"
                           listAgencyName="PE:SUNAT"
                           listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo16">02</cbc:PriceTypeCode>
    </cac:AlternativeConditionPrice>
	 </cac:PricingReference>
</#if>

<#list listaAdicionalDetalle as detalleAdicional>

   <#if detalleAdicional.idLinea??>
   <#if detalleAdicional.idLinea?number = detalle.lineaSwf?number>

<#if (detalleAdicional.codTipoVariable = "00" || detalleAdicional.codTipoVariable = "01") >
	<!-- Descuentos por item - restan a valor unitario por item-->
	 <cac:AllowanceCharge>
		<cbc:ChargeIndicator>${detalleAdicional.tipVariable}</cbc:ChargeIndicator>
		<cbc:AllowanceChargeReasonCode>${detalleAdicional.codTipoVariable}</cbc:AllowanceChargeReasonCode>
		<cbc:MultiplierFactorNumeric>${detalleAdicional.porVariable}</cbc:MultiplierFactorNumeric>
		<cbc:Amount currencyID="${detalleAdicional.monMontoVariable}">${detalleAdicional.mtoVariable}</cbc:Amount>
		<cbc:BaseAmount currencyID="${detalleAdicional.monBaseImponibleVariable}">${detalleAdicional.mtoBaseImpVariable}</cbc:BaseAmount>
	</cac:AllowanceCharge>
</#if>

<#if (detalleAdicional.codTipoVariable = "47" || detalleAdicional.codTipoVariable = "48") >
	<!-- Cargos por item - suman al valor unitario por item-->	
	<cac:AllowanceCharge>
		<cbc:ChargeIndicator>${detalleAdicional.tipVariable}</cbc:ChargeIndicator>
		<cbc:AllowanceChargeReasonCode>${detalleAdicional.codTipoVariable}</cbc:AllowanceChargeReasonCode>
		<cbc:MultiplierFactorNumeric>${detalleAdicional.porVariable}</cbc:MultiplierFactorNumeric>
		<cbc:Amount currencyID="${detalleAdicional.monMontoVariable}">${detalleAdicional.mtoVariable}</cbc:Amount>
		<cbc:BaseAmount currencyID="${detalleAdicional.monBaseImponibleVariable}">${detalleAdicional.mtoBaseImpVariable}</cbc:BaseAmount>
	</cac:AllowanceCharge>
</#if>	

   </#if>
   </#if>

   </#list> 	

   <#list listaServicioTransporteCarga as servicioTransporteCarga>

   <#if servicioTransporteCarga.idLineaServicio??>
   <#if servicioTransporteCarga.idLineaServicio?number = detalle.lineaSwf?number>
    <!-- ***   D)    Detracciones - Servicio de transporte de Carga *** -->
	<cac:Delivery>
	
	<!-- ***   D.1)    Datos Generales (cabecera)*** -->
	
      <!-- ***   D.1.2)  Punto Destino *** -->
      <cac:DeliveryLocation>
        <cac:Address>
		  <cbc:ID>${servicioTransporteCarga.ubiDestino}</cbc:ID>
          <cac:AddressLine>
            <cbc:Line>${servicioTransporteCarga.dirDestino}</cbc:Line>
          </cac:AddressLine>
        </cac:Address>
      </cac:DeliveryLocation>
      <cac:Despatch>
	    <!-- ***   D.1.3)   Detalle del viaje *** -->
		<cbc:Instructions>${servicioTransporteCarga.detViaje}</cbc:Instructions>
        <!-- ***   D.1.1)   Punto de Origen *** -->
        <cac:DespatchAddress>
          <cbc:ID>${servicioTransporteCarga.ubiOrigen}</cbc:ID>
          <cac:AddressLine>
            <cbc:Line>${servicioTransporteCarga.dirOrigen}</cbc:Line>
          </cac:AddressLine>
        </cac:DespatchAddress>
      </cac:Despatch>
	  <!-- ***   D.1.4)  Valor referencial del servicio de transporte  *** -->
      <cac:DeliveryTerms>		
        <cbc:ID schemeAgencyID="6" schemeID="01">${servicioTransporteCarga.tipReferencialServicio}</cbc:ID>
        <cbc:Amount currencyID="PEN">${servicioTransporteCarga.varReferencialServicio}</cbc:Amount>
      </cac:DeliveryTerms>
	  <!-- ***   D.1.5)  Valor referencial sobre la carga efectiva  *** -->
      <cac:DeliveryTerms>		
        <cbc:ID schemeAgencyID="6" schemeID="02">${servicioTransporteCarga.tipCargaEfectiva}</cbc:ID>
        <cbc:Amount currencyID="PEN">${servicioTransporteCarga.varCargaEfectiva}</cbc:Amount>
      </cac:DeliveryTerms>	  
	  <!-- ***   D.1.6)  Valor referencial sobre la carga util nominal  *** -->
      <cac:DeliveryTerms>		
        <cbc:ID schemeAgencyID="6" schemeID="03">${servicioTransporteCarga.tipCargaUtil}</cbc:ID>
        <cbc:Amount currencyID="PEN">${servicioTransporteCarga.varCargaUtil}</cbc:Amount>
      </cac:DeliveryTerms>
	  
	  <!-- ***   D.1)    Fin de Datos Generales (cabecera) *** -->
	  

	  
      <cac:Shipment>
	  <!-- ===   D.2)  Inicio  Detalle de tramos === -->	  
	    <!-- ===   D.2.1) Identificador del servicio -valor fijo  === -->
        <cbc:ID>01</cbc:ID>
		<#list listaTramos as tramo>

		<#if tramo.idLineaTramo??>
		<#if tramo.idLineaTramo?number = detalle.lineaSwf?number>
		
        <cac:Consignment>
		  <!-- ===   D.2.3) Identificador del tramo  === -->
          <cbc:ID>${tramo.idTramo}</cbc:ID>
		  <!-- ===   D.2.3) Descripcion del tramo  === -->
          <cbc:CarrierServiceInstructions>${tramo.desTramo}</cbc:CarrierServiceInstructions>
		  
		  <!-- @-@   D.3.5)  Valor Preliminar Referencial por Carga Util Nominal (Tratandose de más de 1 vehiculo)  @-@ -->
          <cbc:DeclaredForCarriageValueAmount currencyID="PEN">${tramo.mtoValorReferencialCargaNominal}</cbc:DeclaredForCarriageValueAmount>
		  
		  <!-- ===   D.2.1)  Detalle de tramos (De corresponder) - Punto de origen del viaje === -->
          <cac:PlannedPickupTransportEvent>
            <cac:Location>
			  <cbc:ID schemeAgencyName="PE:INEI" schemeName="Ubigeos">${tramo.ubiOrigenTramo}</cbc:ID>
            </cac:Location>
          </cac:PlannedPickupTransportEvent>
		  <!-- ===   D.2.2)  Detalle de tramos (De corresponder) - Punto de destino del viaje === -->
          <cac:PlannedDeliveryTransportEvent>
            <cac:Location>
			  <cbc:ID schemeAgencyName="PE:INEI" schemeName="Ubigeos">${tramo.ubiDestinoTramo}</cbc:ID>
            </cac:Location>
          </cac:PlannedDeliveryTransportEvent>
		  <!-- ===   D.2.4)  Valor preliminar referencial sobre la carga efectiva (Por el tramo virtual recorrido) === -->
          <cac:DeliveryTerms>
            <cbc:Amount currencyID="PEN">${tramo.mtoValorReferencialCargaEfectiva}</cbc:Amount>
          </cac:DeliveryTerms>		  
		  <!-- ===   D.2)  FIN  Detalle de tramos === -->
		
		<#list listaVehiculos as vehiculo>

		<#if vehiculo.idLineaVehiculo??>
		<#if vehiculo.idLineaVehiculo?number = detalle.lineaSwf?number && vehiculo.idTramoVehiculo?number = tramo.idTramo?number>
		  <!-- @-@  D.3)  Inicio  Detalle de Vehiculos @-@ -->		  
		  <!-- @-@   D.3)  Servicio de transporte de Carga - Detalle del (os) Vehiculo (s)  @-@ -->
		 
          <cac:TransportHandlingUnit>
            <cac:TransportEquipment>
		      <!-- @-@   D.3.1)  Configuracion vehicular del vehiculo  @-@ -->
              <cbc:SizeTypeCode>${vehiculo.cfgVehiculo}</cbc:SizeTypeCode>
			  <!-- @-@   D.3.6)  Indica factor de retorno de viaje  @-@ -->
              <cbc:ReturnabilityIndicator>${vehiculo.indFactorRetornoVehiculo}</cbc:ReturnabilityIndicator>
			  <!-- @-@   D.3.4) Valor Referencial por TM  @-@ -->
              <cac:Delivery>
                <cac:DeliveryTerms>
                  <cbc:Amount currencyID="PEN">${vehiculo.mtoValorReferencialporTMVehiculo}</cbc:Amount>
                </cac:DeliveryTerms>
              </cac:Delivery>
            </cac:TransportEquipment>
			<!-- @-@   D.3.2)  Carga Util en TM del vehiculo  @-@ -->
            <cac:MeasurementDimension>
              <cbc:AttributeID>${vehiculo.tipCargaEfectivaVehiculo}</cbc:AttributeID>
              <cbc:Measure unitCode="TNE">${vehiculo.valCargaEfectivaVehiculo}</cbc:Measure>
            </cac:MeasurementDimension>
			<!-- @-@   D.3.3)  Carga Efectiva en TM del vehiculo  @-@ -->
            <cac:MeasurementDimension>
              <cbc:AttributeID>${vehiculo.tipCargaUtilVehiculo}</cbc:AttributeID>
              <cbc:Measure unitCode="TNE">${vehiculo.valCargaUtilVehiculo}</cbc:Measure>
            </cac:MeasurementDimension>
          </cac:TransportHandlingUnit>
		  
		  <!-- @-@  D.3)  Fin  Detalle de Vehiculos @-@ -->
		</#if>
		</#if>

		</#list>
        </cac:Consignment>
		
	  </#if>
      </#if>

      </#list>
	  
      </cac:Shipment>
	  
    </cac:Delivery>
	
    </#if>
    </#if>

    </#list>
	
	<!-- Inicio Tributos -->
    <cac:TaxTotal>
      <cbc:TaxAmount currencyID="${moneda}">${detalle.sumTotTributosItem}</cbc:TaxAmount>	  
<#if (detalle.codTriIGV?? && detalle.codTriIGV != "-")>
<#if (detalle.codTriIGV = "1000" || detalle.codTriIGV = "1016" || detalle.codTriIGV = "9995" || detalle.codTriIGV = "9996" || detalle.codTriIGV = "9998" || detalle.codTriIGV = "9997")>
      <cac:TaxSubtotal>
        <cbc:TaxableAmount currencyID="${moneda}">${detalle.mtoBaseIgvItem}</cbc:TaxableAmount>
        <cbc:TaxAmount currencyID="${moneda}">${detalle.mtoIgvItem}</cbc:TaxAmount>
        <cac:TaxCategory>
          <cbc:Percent>${detalle.porIgvItem}</cbc:Percent>
          <cbc:TaxExemptionReasonCode listAgencyName="PE:SUNAT"
                                      listName="Afectacion del IGV"
                                      listURI="urn:pe:gob:sunat:cpe:see:gem:catalogos:catalogo07">${detalle.tipAfeIGV}</cbc:TaxExemptionReasonCode>
          <cac:TaxScheme>
            <cbc:ID schemeID="UN/ECE 5153"
                    schemeName="Codigo de tributos"
                    schemeAgencyName="PE:SUNAT">${detalle.codTriIGV}</cbc:ID>
            <cbc:Name>${detalle.nomTributoIgvItem}</cbc:Name>
            <cbc:TaxTypeCode>${detalle.codTipTributoIgvItem}</cbc:TaxTypeCode>
          </cac:TaxScheme>
        </cac:TaxCategory>
      </cac:TaxSubtotal>
</#if>
</#if>
<#if (detalle.codTriISC?? && detalle.codTriISC != "-")>
	<#if (detalle.codTriISC = "2000") >
      <cac:TaxSubtotal>
        <cbc:TaxableAmount currencyID="${moneda}">${detalle.mtoBaseIscItem}</cbc:TaxableAmount>
        <cbc:TaxAmount currencyID="${moneda}">${detalle.mtoIscItem}</cbc:TaxAmount>
        <cac:TaxCategory>
          <cbc:Percent>${detalle.porIscItem}</cbc:Percent>
		  <cbc:TierRange>${detalle.tipSisISC}</cbc:TierRange>
          <cac:TaxScheme>
            <cbc:ID schemeID="UN/ECE 5153"
                    schemeName="Codigo de tributos"
                    schemeAgencyName="PE:SUNAT">${detalle.codTriISC}</cbc:ID>
            <cbc:Name>${detalle.nomTributoIscItem}</cbc:Name>
            <cbc:TaxTypeCode>${detalle.codTipTributoIscItem}</cbc:TaxTypeCode>
          </cac:TaxScheme>
        </cac:TaxCategory>
      </cac:TaxSubtotal>
	</#if>
</#if>
<#if (detalle.codTriOtro?? && detalle.codTriOtro != "-")>
	<#if (detalle.codTriOtro = "9999") >
      <cac:TaxSubtotal>
        <cbc:TaxableAmount currencyID="${moneda}">${detalle.mtoBaseTriOtroItem}</cbc:TaxableAmount>
        <cbc:TaxAmount currencyID="${moneda}">${detalle.mtoTriOtroItem}</cbc:TaxAmount>
        <cac:TaxCategory>
          <cbc:Percent>${detalle.porTriOtroItem}</cbc:Percent>
          <cac:TaxScheme>
            <cbc:ID schemeID="UN/ECE 5153"
                    schemeName="Codigo de tributos"
                    schemeAgencyName="PE:SUNAT">${detalle.codTriOtro}</cbc:ID>
            <cbc:Name>${detalle.nomTributoOtroItem}</cbc:Name>
            <cbc:TaxTypeCode>${detalle.codTipTributoOtroItem}</cbc:TaxTypeCode>
          </cac:TaxScheme>
        </cac:TaxCategory>
      </cac:TaxSubtotal>
	</#if>
</#if>
<#if (detalle.codTriIcbper?? && detalle.codTriIcbper != "-")>
	<#if (detalle.codTriIcbper = "7152") >
      <cac:TaxSubtotal>
        <cbc:TaxAmount currencyID="${moneda}">${detalle.mtoTriIcbperItem}</cbc:TaxAmount>
        <cbc:BaseUnitMeasure unitCode="NIU">${detalle.ctdBolsasTriIcbperItem}</cbc:BaseUnitMeasure>
        <cac:TaxCategory>
          <cbc:PerUnitAmount currencyID="${moneda}">${detalle.mtoTriIcbperUnidad}</cbc:PerUnitAmount>
          <cac:TaxScheme>
            <cbc:ID schemeID="UN/ECE 5153"
                    schemeName="Codigo de tributos"
                    schemeAgencyName="PE:SUNAT">${detalle.codTriIcbper}</cbc:ID>
            <cbc:Name>${detalle.nomTributoIcbperItem}</cbc:Name>
            <cbc:TaxTypeCode>${detalle.codTipTributoIcbperItem}</cbc:TaxTypeCode>
          </cac:TaxScheme>
        </cac:TaxCategory>
      </cac:TaxSubtotal>
	</#if>
</#if>

    </cac:TaxTotal>	
	<!-- Fin Tributos -->	
    <cac:Item>
      <cbc:Description><![CDATA[${detalle.desItem}]]></cbc:Description>
	  <cac:SellersItemIdentification>
        <cbc:ID>${detalle.codProducto}</cbc:ID>
	  </cac:SellersItemIdentification>
	  <#if detalle.codProductoSUNAT??>
	  <#if detalle.codProductoSUNAT != "" && detalle.codProductoSUNAT != "-">
	  <cac:CommodityClassification>
		<cbc:ItemClassificationCode listID="UNSPSC" listAgencyName="GS1 US" listName="Item Classification">${detalle.codProductoSUNAT}</cbc:ItemClassificationCode>
	  </cac:CommodityClassification>
	  </#if></#if>
	  
   <#list listaAdicionalDetalle as detalleAdicional>

   <#if detalleAdicional.idLinea??>
   <#if detalleAdicional.idLinea?number = detalle.lineaSwf?number>
   
   <#if detalleAdicional.nomPropiedad != "-" && detalleAdicional.nomPropiedad != "">
    <cac:AdditionalItemProperty>
	  <cbc:Name><![CDATA[${detalleAdicional.nomPropiedad}]]></cbc:Name>
	  <cbc:NameCode listName="Propiedad del item"
	      		   listAgencyName="PE:SUNAT">${detalleAdicional.codPropiedad}</cbc:NameCode>
	  <#if detalleAdicional.codPropiedad != "3005" && detalleAdicional.codPropiedad != "3006">
	  	 <cbc:Value>${detalleAdicional.valPropiedad}</cbc:Value>
	  </#if>
	  <#if detalleAdicional.codBienPropiedad != "-" && detalleAdicional.codBienPropiedad != "">
	     <cbc:ValueQualifier>${detalleAdicional.codBienPropiedad}</cbc:ValueQualifier>
      </#if>
      <#if detalleAdicional.codPropiedad == "3006">
            <cbc:ValueQuantity>${detalleAdicional.valPropiedad}</cbc:ValueQuantity>
      </#if>
	  <#if (detalleAdicional.fecInicioPropiedad != "-" && detalleAdicional.fecInicioPropiedad != "") ||
	  (detalleAdicional.horInicioPropiedad != "-" && detalleAdicional.horInicioPropiedad != "") ||
	  (detalleAdicional.fecFinPropiedad != "-" && detalleAdicional.fecFinPropiedad != "") ||
	  (detalleAdicional.numDiasPropiedad != "-" && detalleAdicional.numDiasPropiedad != "")>
	  <cac:UsabilityPeriod>
		<#if detalleAdicional.fecInicioPropiedad != "-" && detalleAdicional.fecInicioPropiedad != "">
		<cbc:StartDate>${detalleAdicional.fecInicioPropiedad}</cbc:StartDate>
		</#if>
		<#if detalleAdicional.horInicioPropiedad != "-" && detalleAdicional.horInicioPropiedad != "">
		<cbc:StartTime>${detalleAdicional.horInicioPropiedad}</cbc:StartTime>
		</#if>
		<#if detalleAdicional.fecFinPropiedad != "-" && detalleAdicional.fecFinPropiedad != "">
		<cbc:EndDate>${detalleAdicional.fecFinPropiedad}</cbc:EndDate>
		</#if>
		<#if detalleAdicional.numDiasPropiedad != "-" && detalleAdicional.numDiasPropiedad != "">
		<cbc:DurationMeasure unitCode="DAY">${detalleAdicional.numDiasPropiedad}</cbc:DurationMeasure>
		</#if>
	  </cac:UsabilityPeriod>
	  </#if>
    </cac:AdditionalItemProperty>
	</#if>
	
   </#if>
   </#if>

   </#list>  
    </cac:Item>
    <cac:Price>
      <cbc:PriceAmount currencyID="${moneda}">${detalle.mtoValorUnitario}</cbc:PriceAmount>
    </cac:Price>
  </cac:InvoiceLine>
</#list>
</Invoice>