<!--- 
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either 
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public 
 * License along with this library.  If not, see <http://www.gnu.org/licenses/>.
 * 
 ---><cfcomponent>

	<cfset this.options=array()>

	<cffunction name="init" output="no">
    	<cfargument name="type" type="string" required="yes">
    	<cfargument name="name" type="string" required="yes">
    	<cfargument name="value" type="string" required="yes">
    	<cfargument name="selected" type="boolean" default="#false#">
    	<cfargument name="label" type="string" default="#arguments.name#">
    	<cfargument name="description" type="string" default="">
        
        <cfset this.type=arguments.type>
        <cfset this.name=arguments.name>
        <cfset this.value=arguments.value>
        <cfset this.label=arguments.label>
        <cfset this.selected=arguments.selected>
        <cfset this.description=arguments.description>
        
    	<cfreturn this>
    </cffunction>
    
	<cffunction name="createOption" output="no">
    	<cfargument name="value" type="string" required="yes">
    	<cfargument name="selected" type="boolean" default="#false#">
    	<cfargument name="label" type="string" default="#arguments.value#">
    	<cfargument name="description" type="string" default="">
        
        <cfset var option=createObject('component','ExtensionOption').init(value:arguments.value,selected:arguments.selected,label:arguments.label,description:arguments.description)>
        <cfset ArrayAppend(this.options,option)>
    	
    	<cfreturn option>
    </cffunction>
    
	<cffunction name="getOptions" output="no" returntype="array">
    	<cfreturn this.options>
    </cffunction>
    
    
    
	<cffunction name="getLabel" output="no" returntype="String">
    	<cfreturn this.label>
    </cffunction>
    
	<cffunction name="getDescription" output="no" returntype="String">
    	<cfreturn this.description>
    </cffunction>
    
	<cffunction name="getType" output="no" returntype="String">
    	<cfreturn this.type>
    </cffunction>
    
	<cffunction name="getName" output="no" returntype="String">
    	<cfreturn this.name>
    </cffunction>
    
	<cffunction name="getValue" output="no" returntype="String">
    	<cfreturn this.value>
    </cffunction>
    
	<cffunction name="getSelected" output="no" returntype="boolean">
    	<cfreturn this.selected>
    </cffunction>
    
    
	<cffunction name="setLabel" output="no" returntype="void">
    	<cfargument name="label" type="string" required="yes">
    	<cfset this.label=arguments.label>
    </cffunction>
	<cffunction name="setDescription" output="no" returntype="void">
    	<cfargument name="description" type="string" required="yes">
    	<cfset this.description=arguments.description>
    </cffunction>
	<cffunction name="setType" output="no" returntype="void">
    	<cfargument name="type" type="string" required="yes">
    	<cfset this.type=arguments.type>
    </cffunction>
	<cffunction name="setName" output="no" returntype="void">
    	<cfargument name="name" type="string" required="yes">
    	<cfset this.name=arguments.name>
    </cffunction>
	<cffunction name="setValue" output="no" returntype="void">
    	<cfargument name="value" type="string" required="yes">
    	<cfset this.value=arguments.value>
    </cffunction>
	<cffunction name="setSelected" output="no" returntype="void">
    	<cfargument name="description" type="boolean" required="yes">
    	<cfset this.selected=arguments.selected>
    </cffunction>
    
</cfcomponent>