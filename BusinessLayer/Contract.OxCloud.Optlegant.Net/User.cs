//-------------------------------------------------------------------------------------------------
// <copyright file="User.cs" company="Optlegant Solutions">
//     Copyright (c) Optlegant Solutions.  All rights reserved.
// </copyright>
//
// <summary>
//     Class implement the contract for user object.
// </summary>
//-------------------------------------------------------------------------------------------------
namespace Contract.OxCloud.Optlegant.Net
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    /// <summary>
    /// Class implements User object.
    /// </summary>
    public class User
    {
        public int UserId
        {
            get;
            set;
        }

        public string FirstName
        {
            get;
            set;
        }

        public string LastName
        {
            get;
            set;
        }

        public string LogonEmailAddress
        {
            get;
            set;
        }

        public string ContactEmailAddress
        {
            get;
            set;
        }

        public string Telephone
        {
            get;
            set;
        }

        public string Password
        {
            get;
            set;
        }

        public int CompanyId
        {
            get;
            set;
        }

        public bool IsDeleted
        {
            get;
            set;
        }

    }
}
