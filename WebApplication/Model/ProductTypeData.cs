using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace WebApplication.Model
{
    public class ProductTypeData
    {
        private static string connectionString = string.Empty;

        static ProductTypeData()
        {
            connectionString = ConfigurationManager.ConnectionStrings["PlayDB"].ConnectionString;
        }

        public static bool Update(string newName)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                using (SqlCommand command = new SqlCommand("UpdateProductType", connection))
                {
                    connection.Open();
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter() { ParameterName = "@Name", SqlDbType = System.Data.SqlDbType.VarChar, Value = newName });
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            catch (Exception)
            {
                return false;
            }
            return true;
        }

    }
}