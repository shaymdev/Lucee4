/**
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
 **/
package lucee.runtime.functions.query;

import lucee.runtime.PageContext;
import lucee.runtime.exp.PageException;
import lucee.runtime.functions.BIF;
import lucee.runtime.op.Caster;
import lucee.runtime.type.Query;
import lucee.runtime.type.util.ListUtil;

/**
 * Implements the CFML Function querynew
 */
public final class QueryColumnList extends BIF {

	private static final long serialVersionUID = 2718851377017546192L;

	public static String call(PageContext pc , Query qry) {
        return call(pc,qry,",");
    }
    public static String call(PageContext pc , Query qry, String delimiter) {
        return ListUtil.arrayToList(qry.getColumnNamesAsString(),delimiter);
    }
	
	@Override
	public Object invoke(PageContext pc, Object[] args) throws PageException {
		if(args.length==1)return call(pc,Caster.toQuery(args[0]));
		return call(pc,Caster.toQuery(args[0]),Caster.toString(args[1]));
	}
}