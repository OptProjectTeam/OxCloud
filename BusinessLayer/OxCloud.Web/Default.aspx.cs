using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Onboarding.OxCloud.Optlegant.Net;
using Contract.OxCloud.Optlegant.Net;

namespace OxCloud.Web
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // validation here
            rfvFirstName.ControlToValidate = TextBox1.Text;
            rfvFirstName.ErrorMessage = "First Name is Required";
            rfvLastName.ControlToValidate = TextBox2.Text;
            rfvLastName.ErrorMessage = "last Name is Reuired";
            rfvCompanyName.ControlToValidate = TextBox3.Text;
            rfvCompanyName.ErrorMessage = "Company Name is Required";
            revEmailAddress.ControlToValidate = TextBox4.Text;
            revEmailAddress.ErrorMessage = "Please provide valid email address";
            cvConfirmEmailAddress.ControlToCompare = TextBox4.Text;
            cvConfirmEmailAddress.ControlToValidate = TextBox5.Text;
            cvConfirmEmailAddress.ErrorMessage = "Email addresses do not match";
            rvPassword.ControlToValidate = TextBox7.Text;
            rvPassword.ErrorMessage = "Password must be between 6-25 characters long";
            cvConfirmPassword.ControlToCompare = TextBox7.Text;
            cvConfirmPassword.ControlToValidate = TextBox8.Text;
            cvConfirmPassword.ErrorMessage = "passwords do not match";


            // Construct company object
            Company company = new Company();
            company.CompanyName = TextBox3.Text;
            
            // Construct user object
            User user = new User();
            user.FirstName = TextBox1.Text; 
            user.LastName = TextBox2.Text;
            user.LogonEmailAddress = TextBox4.Text;
            user.Telephone = TextBox6.Text;
            user.Password = TextBox7.Text;

            // Call activation
            CompanyActivation activation = new CompanyActivation();
            activation.CompanyProvision(company, user);
        }


    }
}
