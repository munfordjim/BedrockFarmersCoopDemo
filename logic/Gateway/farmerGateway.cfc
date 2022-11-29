component displayname="farmerGateway - used for multiple records." output="false" hint="farmerGateway Gateway class"
{
    public any function getAllFarmerRecords()
    {
        try 
        {
            sql = "SELECT f.FarmerID, RTRIM(f.FirstName) 'FirstName', RTRIM(f.LastName) 'LastName', RTRIM(f.EmailAddress) 'EmailAddress', RTRIM(f.PhoneNumber) 'PhoneNumber',
            a.AddrID, RTRIM(a.AddressLine1) 'AddressLine1', RTRIM(a.City) 'City', RTRIM(a.State) 'State', RTRIM(a.Zip) 'Zip'
            FROM bfc_Farmer f, bfc_Address a, bfc_Farmer_Address_Map m
            WHERE f.FarmerID = m.FarmerID
            AND a.AddrID = m.AddrID
            ORDER BY f.LastName, f.FirstName;";

            strParams = {};
            strOptions = {datasource=application.datasource};
            qAllRecords = queryExecute(sql, strParams, strOptions);
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in getAllFarmerRecords - farmerGateway.cfc: #e.message#; detail=#e.detail#" );
        }


        return qAllREcords;
    }

    public any function getAllFarmerRecordsByLastName( required string lastName )
    {
        try 
        {
            sql = "SELECT FarmerID, FirstName, LastName, EmailAddress, PhoneNumber
            FROM bfc_Farmer
            WHERE LastName like :lastName;";

            strParams = {lastName = {value="%#arguments.movieID#%", cfsqltype='cf_sql_varchar'}};
            strOptions = {datasource=application.datasource};
            qAllRecordsByLastName = queryExecute(sql, strParams, strOptions);              
        } 
        catch( any e )
        {
            throw( type="custom", message="Error in getAllFarmerRecordsByLastName - farmerGateway.cfc: #e.message#; detail=#e.detail#" );              
        }

        return qAllRecordsByLastName;
    }    

}