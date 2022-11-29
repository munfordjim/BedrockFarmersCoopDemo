component displayname="addressGateway - used for multiple records." output="false" hint="addressGateway Gateway class"
{
    //  This is a stub component not currently in use.
    public any function getAllAddressRecords()
    {
        sql = "SELECT AddrID, AddressLine1, City, State, Zip 
        FROM" ;

        strParams = {};
        strOptions = {datasource=application.datasource};
        qAllRecords = queryExecute(sql, strParams, stOptions);

        return qAllRecords;
    }

    public any function getAllAddressRecordsByCity()
    {
        sql = "SELECT AddrID, AddressLine1, City, State, Zip 
        FROM 
        WHERE City like :city" ;

        strParams = {city = {value="%#arguments.city#%", cfsqltype='cf_sql_varchar'}};
        strOptions = {datasource=application.datasource};
        qAllRecords = queryExecute(sql, strParams, stOptions);

        return qAllRecords;    
    }
}