<#--
    Plantilla para generar un archivo de texto.
    Esta plantilla crea un listado de personas con sus datos.
-->

Listado de Personas
====================
<#list personas as persona>
<#-- Inicio de cada persona -->
    Nombre: ${persona.nombre}
    Edad: ${persona.edad} años
    Dirección: ${persona.direccion.calle}, ${persona.direccion.ciudad} (${persona.direccion.codigoPostal})

<#-- Añade una línea separadora entre personas si no es el último elemento -->
    <#if persona_has_next>--------------------------------------------</#if>
</#list>
<#-- Fin del bucle -->