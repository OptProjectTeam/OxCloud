//-------------------------------------------------------------------------------------------------
// <copyright file="Company.cs" company="Optlegant Solutions">
//     Copyright (c) Optlegant Solutions.  All rights reserved.
// </copyright>
//
// <summary>
//     Class implement the contract for company object.
// </summary>
//-------------------------------------------------------------------------------------------------
namespace Contract.OxCloud.Optlegant.Net
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    /// <summary>
    /// Class implements Company object.
    /// </summary>
    public class Company
    {
        public int CompanyId
        {
            get;
            set;
        }

        public string CompanyName
        {
            get;
            set;
        }

        public string ActivationCode
        {
            get;
            set;
        }

        public string PrimaryPhone
        {
            get;
            set;
        }

        public string AlternatePhone
        {
            get;
            set;
        }

        public string Fax
        {
            get;
            set;
        }

        public string Website
        {
            get;
            set;
        }

        public string AddressLine1
        {
            get;
            set;
        }

        public string AddressLine2
        {
            get;
            set;
        }

        public string AddressLine3
        {
            get;
            set;
        }

        public string CountryId
        {
            get;
            set;
        }

        public string StateId
        {
            get;
            set;
        }

        public string City
        {
            get;
            set;
        }

        public string ZipCode
        {
            get;
            set;
        }



    }
}
