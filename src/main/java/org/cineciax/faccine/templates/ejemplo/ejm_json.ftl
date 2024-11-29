<#-- Inicio de la plantilla JSON -->
<#--
    Esta plantilla genera un archivo JSON con una lista de personas.
    Cada persona tiene un ID, nombre, edad y dirección.
    Se usa la etiqueta <#list> para iterar sobre la lista de personas.
-->

{
"personas": [
<#-- Inicio del bucle para iterar sobre las personas -->
<#list personas as persona>
    {
    "id": "${persona.id}",    <#-- ID único de la persona -->
    "nombre": "${persona.nombre}",  <#-- Nombre completo -->
    "edad": ${persona.edad},  <#-- Edad como número -->
    "direccion": {
    "codigoPostal": "${persona.direccion.codigoPostal}", <#-- Código postal -->
    "ciudad": "${persona.direccion.ciudad}"  <#-- Ciudad de residencia -->
    }
    }<#if persona_has_next>,</#if>
<#-- Añade una coma si hay más personas en la lista -->
</#list>
<#-- Fin del bucle -->
]
}
<#-- Fin de la plantilla -->