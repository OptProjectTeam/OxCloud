//-------------------------------------------------------------------------------------------------
// <copyright file="SqlDataManager.cs" company="Optlegant Solutions">
//     Copyright (c) Optlegant Solutions.  All rights reserved.
// </copyright>
//
// <summary>
//     Class implement the SQL helper methods.
// </summary>
//-------------------------------------------------------------------------------------------------
namespace Datastore.OxCloud.Optlegant.Net
{
    using System;
    using System.Collections.Generic;
    using System.Text;
    using System.Data;
    using System.Data.Common;
    using System.Configuration;
    using System.Data.SqlClient;
   

    public class SqlDataManager
    {
        static SqlDataManager()
        {

        }

        public static DataSet ExecuteSelectCommanddataset(DbCommand command)
        {
            DataSet dataset;
            try
            {
                command.Connection.Open();
                DbDataReader reader = command.ExecuteReader();
                dataset = new DataSet();
                //dataset.Load(reader);
                SqlDataAdapter da = new SqlDataAdapter();
                da.Fill(dataset);
                reader.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                command.Connection.Close();
            }
            return dataset;

        }

        // executes a command and returns the results as a DataTable object
        public static DataTable ExecuteSelectCommand(DbCommand command)
        {
            DataTable table;
            try
            {
                command.Connection.Open();
                DbDataReader reader = command.ExecuteReader();
                table = new DataTable();
                table.Load(reader);
                reader.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                command.Connection.Close();
            }
            return table;
        }



        // creates and prepares a new DbCommand object on a new connection
        public static DbCommand CreateCommand()
        {
            string dataProviderName = ConfigurationSettings.AppSettings[GeneralContants.DataProvider];
            string connectionString = ConfigurationSettings.AppSettings[GeneralContants.ConnectionInfo];
            DbProviderFactory factory = DbProviderFactories.
            GetFactory(dataProviderName);
            DbConnection conn = factory.CreateConnection();
            conn.ConnectionString = connectionString;
            DbCommand comm = conn.CreateCommand();
            comm.CommandType = CommandType.StoredProcedure;
            return comm;
        }


        // execute an update, delete, or insert command and return the number of affected rows
        public static int ExecuteNonQuery(DbCommand command)
        {
            int affectedRows = 0;
            try
            {
                command.Connection.Open();
                affectedRows = command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                command.Connection.Close();
            }

            return affectedRows;
        }



        // execute a select command and return a single result as a string
        public static string ExecuteScalar(DbCommand command)
        {
            string value = "";
            try
            {
                command.Connection.Open();
                value = command.ExecuteScalar().ToString();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                command.Connection.Close();
            }

            return value;
        }


        public static int ExecuteScalarCount(DbCommand command)
        {
            int value;
            try
            {
                command.Connection.Open();
                value = (int)command.ExecuteScalar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                command.Connection.Close();
            }

            return value;
        }
    }
}
