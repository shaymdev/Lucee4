<!--- 
 *
 * Copyright (c) 2014, the Railo Company Ltd. All rights reserved.
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
	
	<!--- Constructor ------------------------------------------------------------------------->
    <cffunction name="init" output="no" returntype="ajaxProxyHelper">
		<cfreturn this/>
  	</cffunction> 
	
	<!--- Public ------------------------------------------------------------------------------>
	<cffunction name="classToPath" returntype="string">
		<cfargument name="cfcClass" required="true" type="string" />
		<cfset var cfcPath = reReplace(arguments.cfcClass,'\.','/','All') />
		<cfset cfcPath = '/' & cfcPath & '.cfc' />
		<!--- Support context roots different from '/', ie '/myLucee' --->
		<cfif getContextRoot() neq '/'> 
			<cfset cfcPath = getContextRoot() & cfcPath />
		</cfif>
		<cfreturn cfcPath />
	</cffunction>
	
	<cffunction name="parseMetadata" returntype="struct">
		<cfargument name="cfc" required="true" type="string" />
		<cfargument name="methods" required="false" type="string" default=""/>
		<cfargument name="extends" required="false" type="boolean" default="false" />
		<cfset var result = {}/>
		<cfset var access = "" />
		<cfset var meta = getComponentmetadata(arguments.cfc)/>		
		<cfset result.functions = createObject('java','java.util.ArrayList').init() />
		<cfif structKeyExists(meta,'FUNCTIONS')>
			<cfset var methods = filterFunction(meta.functions,arguments.methods) />
			<cfset result.functions.addAll(methods) />
		</cfif>	
		<cfif arguments.extends>
			<cfset addExtendedFunctions(meta.extends,result.functions,arguments.methods)/>	
		</cfif>
		<cfreturn result />	
	</cffunction>
	
	<cffunction name="addExtendedFunctions" returntype="void">
		<cfargument name="meta" type="struct" required="true" />
		<cfargument name="functions" type="array" required="true"/>
		<cfargument name="methods" required="false" type="string" default=""/>
		
		<cfset var i = "" /> 
		  
	 	<cfif arguments.meta['name'] neq 'WEB-INF.cftags.component ' and arguments.meta['name'] neq 'lucee.component'>
			<cfif structkeyExists(arguments.meta,'functions')>
				<cfset arr = filterFunction(arguments.meta.functions,arguments.methods) />
				<cfset arguments.functions.addAll(arr)/>
			</cfif>	
			<cfif structkeyExists(arguments.meta,'extends')>
				<cfset addExtendedFunctions(arguments.meta.extends,arguments.functions,arguments.methods) />		
			</cfif>	
		</cfif>
		
	</cffunction>
	
	<cffunction name="isDuplicateFunction" returntype="string">
		<cfargument name="result" required="true" type="array" />
		<cfargument name="name" required="true" type="string" />
		<cfset var resp = false />
		<cfset var item = "" />
		<cfloop array="#arguments.result#" index="item">
			<cfif item.name eq arguments.name>
				<cfreturn true />
				<cfbreak/>
			</cfif>
		</cfloop>
		<cfreturn resp />
	</cffunction>
	
	<cffunction name="filterFunction" returntype="array">
		<cfargument name="functions" required="true" type="array" />
		<cfargument name="methods" required="false" type="string" default=""/>
		<cfset var result = arrayNew(1)/>
		<cfset var method = "" />
		<cfloop array="#arguments.functions#" index="method">		
			<cfif structKeyExists(method,'access')>
				<cfif method.access eq 'remote'>
					<cfif listLen(arguments.methods)>
						<cfif listFindnocase(arguments.methods,method.name) gt 0>
							<cfset result.add(method) />
						</cfif>						
					<cfelse>
						<cfset result.add(method) />
					</cfif>	
				</cfif>
			</cfif>
		</cfloop>
		<cfreturn result />
	</cffunction>
	
	<cffunction name="getArguments" returntype="string" output="false">
		<cfargument name="argsArray" required="true" type="array" />
		<cfset var result = "" />
		<cfloop array="#arguments.argsArray#" index="arg">
			<cfset result = listAppend(result,trim(arg.name)) />
		</cfloop>
		<cfreturn result />
	</cffunction>
	
	<cffunction name="argsToJsMode" returntype="string" output="false">
		<cfargument name="args" required="true" type="string" />
		<cfset var result = "" />
		<cfloop list="#arguments.args#" index="arg">
			<cfset result = listAppend(result,'#trim(arg)#:#trim(arg)#') />
		</cfloop>
		<cfreturn result />
	</cffunction>
	
	
</cfcomponent>