//-------------------------------------------------------------------------------------------------
// <copyright file="CompanyActivation.cs" company="Optlegant Solutions">
//     Copyright (c) Optlegant Solutions.  All rights reserved.
// </copyright>
//
// <summary>
//     Class implement the company activation process.
// </summary>
//-------------------------------------------------------------------------------------------------
namespace Onboarding.OxCloud.Optlegant.Net
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using Contract.OxCloud.Optlegant.Net;
    using System.Data.Common;
    using Datastore.OxCloud.Optlegant.Net;
    using System.Data;
   
    /// <summary>
    /// Class implements methods and properties to address company activation.
    /// </summary>
    public class CompanyActivation
    {
        public void CompanyProvision(Company company, User initialUser)
        {

            if (string.IsNullOrEmpty(company.CompanyName))
            {
                Utilities.ErrorMessage("Company Name should not be empty");
            }

            if (string.IsNullOrEmpty(initialUser.FirstName))
            {
                Utilities.ErrorMessage("First Name is Required");
            }
            if (string.IsNullOrEmpty(initialUser.LastName))
            {
                Utilities.ErrorMessage("Last Name is Required");
            }
            if (string.IsNullOrEmpty(initialUser.LogonEmailAddress))
            {
                Utilities.ErrorMessage("Logon Email Address is Required");
            }
            if (string.IsNullOrEmpty(initialUser.Password))
            {
                Utilities.ErrorMessage("Password is Required");
            }
            this.CreateCommand(
                company.CompanyName,
                initialUser.FirstName,
                initialUser.LastName,
                initialUser.LogonEmailAddress,
                initialUser.Password
                );
        }

        private void CreateCommand(string p, string p_2, string p_3, string p_4, string p_5)
        {
            throw new NotImplementedException();
        }

       
        private bool CreateCompany(
            string companyName,
            string currentLogonName,
            string firstName,
            string lastName,
            string logonEmailAddress,
            string telephone,
            string password)
        {
            DbCommand sqlCommand = SqlDataManager.CreateCommand();
            sqlCommand.CommandText = "dbo.CompanyProvision";


            DbParameter paramTemp = sqlCommand.CreateParameter();
            
            paramTemp.ParameterName = "@pCompanyName";
            paramTemp.Value = companyName;
            paramTemp.DbType = DbType.String;
            sqlCommand.Parameters.Add(paramTemp);

            paramTemp.ParameterName = "@pCurrentLogonName";
            paramTemp.Value = companyName;
            paramTemp.DbType = DbType.String;
            sqlCommand.Parameters.Add(paramTemp);

            paramTemp.ParameterName = "@pFirstName";
            paramTemp.Value = companyName;
            paramTemp.DbType = DbType.String;
            sqlCommand.Parameters.Add(paramTemp);

            paramTemp.ParameterName = "@pLastName";
            paramTemp.Value = companyName;
            paramTemp.DbType = DbType.String;
            sqlCommand.Parameters.Add(paramTemp);

            paramTemp.ParameterName = "@pLoginEmailAddress";
            paramTemp.Value = companyName;
            paramTemp.DbType = DbType.String;
            sqlCommand.Parameters.Add(paramTemp);

            paramTemp.ParameterName = "@pTelephone";
            paramTemp.Value = companyName;
            paramTemp.DbType = DbType.String;
            sqlCommand.Parameters.Add(paramTemp);

            paramTemp.ParameterName = "@pPassword";
            paramTemp.Value = companyName;
            paramTemp.DbType = DbType.String;
            sqlCommand.Parameters.Add(paramTemp);


            int affectedRows = SqlDataManager.ExecuteNonQuery(sqlCommand);
            return true;
        }
    }
}


       