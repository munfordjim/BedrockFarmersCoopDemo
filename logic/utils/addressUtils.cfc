component
{
	public any function getUSStates()
	{
		try 
		{
			sql = "SELECT RTRIM(StAB) as StAB, RTRIM(StateName) as StateName
			FROM US_States 
			ORDER BY StateName";
	
			strParams = {};
			strOptions = {datasource=application.datasource};
			qGetStates = queryExecute(sql, strParams, strOptions);			  
		} 
		catch( any e )
		{
			throw( type="custom", message="Error in getUSStates - addressUtils.cfc: #e.message#; detail=#e.detail#" );
		}

		return qGetStates;
	}
}
